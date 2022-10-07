# script arguments ----
#
thisDataset <- "Koskinen2018"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Tanzania_Southern_Highlands_validation_dataset_field.bib")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "Validation data set collected by the author team in the field, November 2016",
           url = "https://doi.pangaea.de/10.1594/PANGAEA.894891, https://doi.org/10.1016/j.isprsjprs.2018.12.011",
           download_date = "2022-01-22",
           type = "static",
           licence = "CC-BY-4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_tsv(paste0(thisPath, "Tanzania_Southern_Highlands_validation_dataset_field.tab"), skip = 18)


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
temp <- data %>%
  mutate(
    fid = row_number(),
    x = Longitude,
    y = Latitude,
    year = 2016,
    month = 11,
    day = NA_real_,
    datasetID = thisDataset,
    country = "Tanzania",
    irrigated = NA_character_,
    externalID = ID,
    externalValue = `Land use (Level 3)`,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, year, month, day, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
