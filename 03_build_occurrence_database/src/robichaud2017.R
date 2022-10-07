# script arguments ----
#
thisDataset <- "Robichaud201z"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, ""))

regDataset(name = thisDataset,
           description = "Black walnut stands from four sites located in Indiana in the Midwestern United States were sampled. Two sites are forest fragments, both of which are on private agricultural land in Carol County. The other two sites are on continuous forests: Turkey Run State Park in Parke County and Long Hollow State Forest in Crawford County. Leaves from every living black walnut tree on these four sites were collected in 2002-2004, and then their DNA extracted and genotyping carried out at Purdue University 2004-2006. Data include tree diameter, tree location, and the generated alleles or amplicons for each of the 12 microsatellites for that individual tree.",
           url = "https://doi.org/10.2737/RDS-2017-0002",
           download_date = "2022-06-01",
           type = "static",
           licence = "",
           contact = "",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#

data <- read.dbf(file = paste0(thisPath, "FA_FB.DBF"))
data1 <- read.dbf(file = paste0(thisPath, "long_hollow.DBF"))
data2 <- read.dbf(file = paste0(thisPath, "turkey run.DBF"))



# harmonise data ----
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

temp <- temp %>%
  mutate(
    datasetID = thisDataset,
    type = "point",
    x = lon,
    y = lat,
    geometry = NA,
    month = NA_real_,
    day = NA_integer_,
    country = "United States of America",
    irrigated = F,
    area = NA_real_,
    presence = F,
    externalID = NA_character_,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
    separate_rows(year, sep = "_") %>%
    mutate(year = as.numeric(year),
           fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
