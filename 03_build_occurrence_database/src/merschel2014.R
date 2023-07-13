# script arguments ----
#
thisDataset <- "Merschel2014"
description <- "This data publication contains 171 site samples of tree density measurements recorded in mixed-conifer forests of central Oregon in the Deschutes and Ochoco National Forests collected in the summers of 2009 and 2010. Density measurements are available for three common species and all other species: 1) grand and white fir; 2) ponderosa pine; 3) Douglas-fir; and 4) all species not including grand fir, white fir, ponderosa pine or Douglas-fir. Data are also available in four diameter at breast height classes: 10-29.9 centimeters (cm), 30-49.9 cm, 50-69.9 cm, and >70 cm."
url <- "https://doi.org/10.2737/RDS-2014-0018 https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- bibentry(
  bibtype = "Misc",
  title = "Tree density, size, and composition data for mixed-conifer forest in the Deschutes and Ochoco National Forests ",
  author= c(
    person("Andrew G", "Merschel"),
    person("Thomas A", "Spies"),
    person("Emily K", "Heyerdahl")),
  year = 2014,
  doi = "https://doi.org/10.2737/RDS-2014-0018",
  institution = "Forest Service Research Data Archive"
)

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-13"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Merschel_Spies_Heyerdahl_SC.csv"))


# pre-process data ----
#
Zone10 <- data %>%
  filter(Zone == 10)

Zone10 <- st_as_sf(Zone10,
                   coords = c("UTM_Easting", "UTM_Northing"),
                   crs = 26910)

CRS <- CRS("+proj=longlat +datum=WGS84")
Zone10 <- st_transform(Zone10, CRS)
Zone10C <- as.data.frame(st_coordinates(Zone10))
Zone10 <- bind_cols(Zone10, Zone10C)


Zone11 <- data %>%
  filter(Zone == 11)

Zone11 <- st_as_sf(Zone11,
                   coords = c("UTM_Easting", "UTM_Northing"),
                   crs = 26911)

CRS <- CRS("+proj=longlat +datum=WGS84")
Zone11 <- st_transform(Zone11, CRS)
Zone11C <- as.data.frame(st_coordinates(Zone11))
Zone11 <- bind_cols(Zone11, Zone11C)

data <- bind_rows(Zone10, Zone11) %>%
  as_tibble()


# harmonise data ----
#
temp <- data %>%
  mutate(year = "2009_2010") %>%
  separate_rows(year, sep = "_") %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "United States of America",
    x = X...22,
    y = Y...23,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = as.numeric(year),
    # month = NA_real_,
    # day = NA_integer_,
    externalID = as.character(Site),
    externalValue = "Naturally Regenerating Forest",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
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
