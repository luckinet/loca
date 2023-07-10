# script arguments ----
#
thisDataset <- "Annighoefer2015"
description <- "In supplement to: Annighöfer, P et al. (2015): Regeneration patterns of European oak species (Quercus petraea (Matt.) Liebl., Quercus robur L.) in dependence of environment and neighborhood. PLoS ONE, https://doi.org/10.1371/journal.pone.0134935"
url <- "https://doi.org/10.1594/PANGAEA.847281 https://" # doi, in case this exists and download url separated by empty space
licence <- "CC-BY-3.0"


# reference ----
#
bib <- ris_reader(paste0(thisPath, "Oak_inven.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("14-01-2022"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_tsv(paste0(thisPath, "Oak_inven.tab"), skip = 20)


# harmonise data ----
#
temp <- data %>%
  distinct(Longitude, Latitude, Event, Comment) %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = as.numeric(year),
         fid = row_number()) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Germany",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = 500,
    date = dmy(paste0("01-01-", year)),
    externalID = Event,
    externalValue = "Naturally regenerating forest",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring") %>%
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
