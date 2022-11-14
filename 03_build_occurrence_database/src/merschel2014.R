# script arguments ----
#
thisDataset <- "Merschel2014"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

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
           description = "This data publication contains 171 site samples of tree density measurements recorded in mixed-conifer forests of central Oregon in the Deschutes and Ochoco National Forests collected in the summers of 2009 and 2010. Density measurements are available for three common species and all other species: 1) grand and white fir; 2) ponderosa pine; 3) Douglas-fir; and 4) all species not including grand fir, white fir, ponderosa pine or Douglas-fir. Data are also available in four diameter at breast height classes: 10-29.9 centimeters (cm), 30-49.9 cm, 50-69.9 cm, and >70 cm.",
           url = "https://doi.org/10.2737/RDS-2014-0018",
           download_date = "2022-01-13",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Merschel_Spies_Heyerdahl_SC.csv"))


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)


# harmonise data ----
#
Zone10 <- data %>% filter(Zone == 10)

Zone10 <- st_as_sf(Zone10,
                   coords = c("UTM_Easting", "UTM_Northing"),
                   crs = 26910)

CRS <- CRS("+proj=longlat +datum=WGS84")
Zone10 <- st_transform(Zone10, CRS)
Zone10C <- as.data.frame(st_coordinates(Zone10))
Zone10 <- bind_cols(Zone10, Zone10C)


Zone11 <- data %>% filter(Zone == 11)

Zone11 <- st_as_sf(Zone11,
                   coords = c("UTM_Easting", "UTM_Northing"),
                   crs = 26911)

CRS <- CRS("+proj=longlat +datum=WGS84")
Zone11 <- st_transform(Zone11, CRS)
Zone11C <- as.data.frame(st_coordinates(Zone11))
Zone11 <- bind_cols(Zone11, Zone11C)

data <- bind_rows(Zone10, Zone11) %>% as_tibble()


temp <- data %>%
  mutate(year = "2009_2010") %>%
  separate_rows(year, sep = "_") %>%
  mutate(
    fid = row_number(),
    x = X...22,
    y = Y...23,
    geometry = NA,
    area = NA_real_,
    type = "point",
    presence = F,
    year = as.numeric(year),
    month = NA_real_,
    day = NA_integer_,
    datasetID = thisDataset,
    country = "United States of America",
    irrigated = F,
    externalID = as.character(Site),
    externalValue = "Naturally Regenerating Forest",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")

