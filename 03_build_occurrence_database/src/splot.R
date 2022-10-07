# script arguments ----
#
thisDataset <- "splot"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)


# reference ----
#
bib <- ris_reader(paste0(thisPath, "")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "",
           url = "",
           type = "",
           licence = "",
           bibliography = bib,
           update = )


# preprocess data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#
load(paste0(thisPath, "sPlotOpen.RData"))
data <- header.oa


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
    datasetID = thisDataset,
    fid = row_number(),
    x = Longitude,
    y = Latitude,
    year = year(Date_of_recording),
    month = month(Date_of_recording),
    day = day(Date_of_recording),
    country = Country,
    irrigated = NA_character_,
    area = Releve_area,
    presence = TRUE,
    externalID = NA_character_,
    externalValue = ,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp, type = "in-situ point") %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
