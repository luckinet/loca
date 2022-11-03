# script arguments ----
#
thisDataset <- "Camara2020"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "tandf_tgis2033_176.bib"))

description <- "This dataset contains the yearly maps of land use and land cover classification for Amazon biome, Brazil, from 2000 to 2019 at 250 meters of spatial resolution. We used image time series from MOD13Q1 product from MODIS (collection 6), with four bands (NDVI, EVI, near-infrared, and mid-infrared) as data input. A deep learning classification MLP network consisting of 4 hidden layers with 512 units was trained using a set of 33,052 time series of 12 known classes from both natural and anthropic land covers."
url <- "https://doi.org/10.1594/PANGAEA.911560"
license <- "CC-BY-4.0"

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2022-01-22",
           type = "static",
           licence = license,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- readRDS(paste0(thisPath, "samples_amazonia.rds"))

# preprocess
#
data <- data %>%
  as_tibble() %>%
  separate_rows(label, sep = "_")

data < -data[!(data$label=="Roraima"),]


# manage ontology ---
#
matches <- tibble(new = unique(data$label),
                  old = c("Fallow", "cotton", "Forests", "millet", "cotton",
                          "Permanent grazing", "savanna", "savanna", "soybean",
                          "maize", "soybean", "cotton", "soybean", "Fallow",
                          "soybean", "millet", "soybean", "sunflower", "WETLANDS"))

# manage ontology ---
#
newConcepts <- tibble(target = c("Forests", "Temporary grazing", "soybean",
                                 "maize", "cotton", "Fallow",
                                 "millet", "Other Wooded Areas", "Inland wetlands",
                                 "sunflower"),
                      new = unique(data$label),
                      class = c("landcover", "land-use", "commodity",
                                "commodity", "commodity", "land-use",
                                "commodity", "landcover", "landcover",
                                "commodity"),
                      description = NA,
                      match = "close",
                      certainty = 3)

luckiOnto <- new_source(name = thisDataset,
                        description = description,
                        date = Sys.Date(),
                        homepage = url,
                        license = license,
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = newConcepts$new,
                         target = get_concept(x = newConcepts %>% select(label = target), ontology = luckiOnto),
                         source = thisDataset,
                         description = newConcepts$description,
                         match = newConcepts$match,
                         certainty = newConcepts$certainty,
                         ontology = luckiOnto, matchDir = paste0(occurrenceDBDir, "01_concepts/"))



# harmonise data ----
#
temp <- data %>% select(-start_date) %>%
  rename(start_date = end_date)

temp <- data %>%
  bind_rows(temp)

temp <- data %>%
  mutate(
    fid = row_number(),
    type = "point",
    date = ymd(start_date),
    x = longitude,
    y = latitude,
    datasetID = thisDataset,
    country = "Brazil",
    irrigated = NA,
    area = NA_real_,
    presence = T,
    geometry = NA,
    externalID = as.character(id_sample),
    externalValue = label,
    LC1_orig = label,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = NA_character_,
    purpose = "map development",
    epsg = 4326) %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated,presence, LC1_orig, LC2_orig,
         LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(path = occurrenceDBDir, name = thisDataset)

write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
