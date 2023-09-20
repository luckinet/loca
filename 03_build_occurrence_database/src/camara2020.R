# script arguments ----
#
thisDataset <- "Camara2020"
description <- "This dataset contains the yearly maps of land use and land cover classification for Amazon biome, Brazil, from 2000 to 2019 at 250 meters of spatial resolution. We used image time series from MOD13Q1 product from MODIS (collection 6), with four bands (NDVI, EVI, near-infrared, and mid-infrared) as data input. A deep learning classification MLP network consisting of 4 hidden layers with 512 units was trained using a set of 33,052 time series of 12 known classes from both natural and anthropic land covers."
url <- "https://doi.org/10.1594/PANGAEA.911560 https://"
license <- "CC-BY-4.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "tandf_tgis2033_176.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-22"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- readRDS(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "samples_amazonia.rds"))


# pre-process data ----
#
data <- data %>%
  as_tibble() %>%
  separate_rows(label, sep = "_")

data < -data[!(data$label=="Roraima"),]


# harmonise data ----
#

temp <- data %>%
  select(-start_date) %>%
  rename(start_date = end_date)

data <- data %>%
  bind_rows(temp)

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Brazil",
    x = longitude,
    y = latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(start_date),
    externalID = as.character(id_sample),
    externalValue = label,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = TRUE,
    sample_type = "field",
    collector = NA_character_,
    purpose = "map development") %>%
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

# matches <- tibble(new = unique(data$label),
#                   old = c("Fallow", "cotton", "Forests", "millet", "cotton",
#                           "Permanent grazing", "savanna", "savanna", "soybean",
#                           "maize", "soybean", "cotton", "soybean", "Fallow",
#                           "soybean", "millet", "soybean", "sunflower", "WETLANDS"))
# newConcepts <- tibble(target = c("Forests", "Temporary grazing", "soybean",
#                                  "maize", "cotton", "Fallow",
#                                  "millet", "Other Wooded Areas", "Inland wetlands",
#                                  "sunflower"),
#                       new = unique(data$label),
#                       class = c("landcover", "land-use", "commodity",
#                                 "commodity", "commodity", "land-use",
#                                 "commodity", "landcover", "landcover",
#                                 "commodity"),
#                       description = NA,
#                       match = "close",
#                       certainty = 3)

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
