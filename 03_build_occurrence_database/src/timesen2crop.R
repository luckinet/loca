# script arguments ----
#
thisDataset <- "TimeSen2Crop"
description <- "This article presents TimeSen2Crop, a pixel-based dataset made up of more than 1 million samples of Sentinel 2 time series (TSs) associated to 16 crop types. This dataset, publicly available, aims to contribute to the worldwide research related to the supervised classification of TSs of Sentinel 2 data for crop type mapping. TimeSen2Crop includes atmospherically corrected images and reports the snow, shadows, and clouds information per labeled unit..."
url <- "https://doi.org/10.1109/JSTARS.2021.3073965 https://"
licence <- "CC-BY-4.0"


# reference ----
#
bib <- ris_reader(paste0(thisPath, "reference.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("27-01-2022"),
           type = "static",
           licence = licence,
           contact = "see corresponding authors",
           disclosed = FALSE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", ""))

# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = NA_character_,
    country = NA_character_,
    x = NA_real_,
    y = NA_real_,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = NA_character_,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = NA,
    sample_type = NA_character_,
    collector = NA_character_,
    purpose = NA_character_) %>%
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
