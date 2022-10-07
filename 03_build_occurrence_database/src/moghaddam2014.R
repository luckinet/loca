# script arguments ----
#
thisDataset <- "Moghaddam2014"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibentry(
  title = "SMAPVEX12 In Situ Vegetation Data for Forest Area, Version 1",
  bibtype = "Misc",
  doi = "https://doi.org/10.5067/ZOBW4CNJZAW1",
  institution = "NASA National Snow and Ice Data Center Distributed Active Archive Center",
  author = person(c("Mahta", "Moghaddam"))
)

regDataset(name = thisDataset,
           type = "static",
           description = "This data set contains in situ vegetation data collected at several forest sites as a part of the Soil Moisture Active Passive Validation Experiment 2012 (SMAPVEX12).",
           url = "https://doi.org/10.5067/ZOBW4CNJZAW1",
           download_date = "2022-01-11",
           licence = "",
           notes = "",
           contact = "mmoghadd@umich.edu",
           disclosed = "yes",
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Field_Sites_ver4_coords.csv"))


# harmonise data ----
#

temp <- data %>%
  st_as_sf(., coords = c("X", "Y"), crs = 32614) %>%
  st_transform(., crs = 4326)

temp <- temp %>%
  mutate(
    datasetID = thisDataset,
    type = "point",
    x = st_coordinates(.)[,1],
    y = st_coordinates(.)[,2],
    year = 2012,
    month = "6_7",
    country = "USA",
    irrigated = F,
    area = NA_real_,
    presence = F,
    geometry = geometry,
    externalID = as.character(OBJECTID),
    externalValue = "Naturally Regenerating Forest",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(month, sep = "_") %>%
  mutate(
    date = ymd(paste0(year, "-", month, "-01")),
    fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
