# script arguments ----
#
thisDataset <- "Grump"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- ris_reader(paste0(thisPath, "grump-v1-settlement-points-rev01-citation.ris"))

regDataset(name = thisDataset,
           description = "The Global Rural-Urban Mapping Project, Version 1 (GRUMPv1): Settlement Points, Revision 01 is an updated version of the Settlement Points, Version 1 (v1) used in the original population reallocation. Revision 01 includes improved geospatial location for selected settlements, as well as new georeferenced settlements. Revision 01 was produced by the Columbia University Center for International Earth Science Information Network (CIESIN) in collaboration with the CUNY Institute for Demographic Research (CIDR).",
           url = "https://doi.org/10.7927/H4BC3WG1",
           download_date = "2021-11-15",
           type = "static",
           licence = "",
           contact = "Center for International Earth Science Information Network - CIESIN - Columbia University",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "grump-v1-settlement-points-rev01.csv"))

# harmonise data ----
#
temp <- data %>%
  na_if(., -999) %>%
  distinct(Latitude, Longitude, Year, .keep_all = TRUE) %>%
  mutate(
    fid = row_number(),
    x = Longitude,
    y = Latitude,
    date = ymd(paste0(Year, "-01-01")),
    datasetID = thisDataset,
    country = Country,
    irrigated = FALSE,
    externalID = OBJECTID,
    externalValue = "Urban fabric",
    LC1_orig = "Urban fabric",
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    type = "point",
    geometry = NA,
    presence = FALSE,
    area = NA_real_,
    sample_type = "visual interpretation",
    collector = "expert",
    purpose = "map development",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")


