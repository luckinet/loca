# script arguments ----
#
thisDataset <- "Weber2011"
description <- ""
url <- "https://doi.org/ https://"
licence <- ""


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "doi 10.34725_DVN_HC0ECP.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd(),
           type = NA_character_,
           licence = licence,
           contact = NA_character_,
           disclosed = NA,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(path = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Balanites-tree-location.xls"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Niger",
    x = `Longitude(°E)`,
    y = `Latitude(°N)`,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd("2011-01-01"),
    externalID = NA_character_,
    externalValue = "Agroforestry",
    irrigated = NA,
    presence = FALSE,
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
