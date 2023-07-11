# script arguments ----
#
thisDataset <- "Koskinen2018"
description <- "Validation data set collected by the author team in the field, November 2016"
url <- " https://doi.org/10.1016/j.isprsjprs.2018.12.011 https://doi.pangaea.de/10.1594/PANGAEA.894891"
license <- "CC-BY-4.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Tanzania_Southern_Highlands_validation_dataset_field.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("22-01-2022"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_tsv(paste0(thisPath, "Tanzania_Southern_Highlands_validation_dataset_field.tab"), skip = 18)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Tanzania",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd("2016-11-01"),
    externalID = as.character(ID),
    externalValue = `Land use (Level 3)`,
    irrigated = NA,
    presence = TRUE,
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
