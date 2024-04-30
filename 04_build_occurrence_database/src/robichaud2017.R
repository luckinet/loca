# script arguments ----
#
thisDataset <- "Robichaud2012"
description <- "Black walnut stands from four sites located in Indiana in the Midwestern United States were sampled. Two sites are forest fragments, both of which are on private agricultural land in Carol County. The other two sites are on continuous forests: Turkey Run State Park in Parke County and Long Hollow State Forest in Crawford County. Leaves from every living black walnut tree on these four sites were collected in 2002-2004, and then their DNA extracted and genotyping carried out at Purdue University 2004-2006. Data include tree diameter, tree location, and the generated alleles or amplicons for each of the 12 microsatellites for that individual tree."
url <- "https://doi.org/10.2737/RDS-2017-0002 https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "")) # or bibtex_reader()

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-06-01"),
           type = "static",
           licence = licence,
           contact = NA_character_,
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read.dbf(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "FA_FB.DBF"))
data1 <- read.dbf(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "long_hollow.DBF"))
data2 <- read.dbf(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "turkey run.DBF"))


# pre-process data ----
#
data <- data %>%
  mutate(externalValue = "Naturally Regenerating Forest",
         year= "1947_1948_1949_1950_1951_1952_1953_1954_1955_1956_1957_1958_1959_1960_1961_1962_1963_1964_1965_1966_1967_1968_1969_1970_1971_1972_1973_1974_1975_1976_1977_1978_1979_1980_1981_1982_1983_1984_1985_1986_1987_1988_1989_1990_1991_1992_1993_1994_1995_1996_1997_1998_1999_2000_2001_2002_2003_2004")

data1 <- data1 %>%
  mutate(externalValue = "Naturally Regenerating Forest",
         year= "1940_1941_1942_1943_1944_1945_1946_1947_1948_1949_1950_1951_1952_1953_1954_1955_1956_1957_1958_1959_1960_1961_1962_1963_1964_1965_1966_1967_1968_1969_1970_1971_1972_1973_1974_1975_1976_1977_1978_1979_1980_1981_1982_1983_1984_1985_1986_1987_1988_1989_1990_1991_1992_1993_1994_1995_1996_1997_1998_1999_2000_2001_2002_2003_2004")

data2 <- data2 %>%
  mutate(externalValue = "Naturally Regenerating Forest",
         year= "2002_2003_2004")

temp <- bind_rows(data, data1, data2) %>%
  st_as_sf(., coords = c("Long_UTM", "Lat_UTM"), crs = CRS("EPSG:26916")) %>%
  st_transform(., crs = "EPSG:4326") %>%
  mutate(lon = st_coordinates(.)[,1],
         lat = st_coordinates(.)[,2]) %>%
  as.data.frame()


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "United States of America",
    x = lon,
    y = lat,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = NA_character_,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = as.numeric(year),
         fid = row_number()) %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated, presence,
         sample_type, collector, purpose, everything())


# harmonize with ontology ----
#
new_source(name = thisDataset,
           description = description,
           homepage = url,
           date = Sys.Date(),
           license = licence,
           ontology = ontoDir)

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
