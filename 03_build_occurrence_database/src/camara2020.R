# script arguments ----
#
thisDataset <- "Camara2020"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "tandf_tgis2033_176.bib"))

regDataset(name = thisDataset,
           description = "This dataset contains the yearly maps of land use and land cover classification for Amazon biome, Brazil, from 2000 to 2019 at 250 meters of spatial resolution. We used image time series from MOD13Q1 product from MODIS (collection 6), with four bands (NDVI, EVI, near-infrared, and mid-infrared) as data input. A deep learning classification MLP network consisting of 4 hidden layers with 512 units was trained using a set of 33,052 time series of 12 known classes from both natural and anthropic land covers.",
           url = "https://doi.org/10.1594/PANGAEA.911560",
           download_date = "2022-01-22",
           type = "static",
           licence = "CC-BY-4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- readRDS(paste0(thisPath, "samples_amazonia.rds"))


# manage ontology ---
#
matches <- tibble(new = sort(c(unique(data$label), unique(data$label)[-c(1, 2, 8, 9, 10)])),
                  old = c("Fallow", "cotton", "Forests", "millet", "cotton",
                          "Permanent grazing", "savanna", "savanna", "soybean",
                          "maize", "soybean", "cotton", "soybean", "Fallow",
                          "soybean", "millet", "soybean", "sunflower", "WETLANDS"))

newConcept(new = c("savanna"),
           broader = c("Forests"),
           class = "forest type",
           source = thisDataset)

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)



# harmonise data ----
#
temp_start <- data %>%
  separate("start_date", c("year", "month", "day"), sep = "-") %>%
  mutate(
    fid = row_number(),
    type = "point",
    year = as.numeric(year),
    month = as.numeric(month),
    day = as.integer(day),
    x = longitude,
    y = latitude,
    datasetID = thisDataset,
    country = "Brazil",
    irrigated = NA,
    area = NA_real_,
    presence = TRUE,
    externalID = as.character(id_sample),
    externalValue = label,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = NA_character_,
    purpose = "map development",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


temp_end <- data %>%
  separate("end_date", c("year", "month", "day"), sep = "-") %>%
  mutate(
    fid = row_number(),
    type = "point",
    year = as.numeric(year),
    month = as.numeric(month),
    day = as.integer(day),
    x = longitude,
    y = latitude,
    datasetID = thisDataset,
    country = "Brazil",
    irrigated = NA,
    area = NA_real_,
    presence = TRUE,
    externalID = as.character(id_sample),
    externalValue = label,
    LC1_orig = label,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = NA_character_,
    purpose = "map development",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())

temp <- bind_rows(temp_start, temp_end)


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
