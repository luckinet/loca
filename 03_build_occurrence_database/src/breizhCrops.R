# script arguments ----
#
thisDataset <- "breizhCrops"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "abs-1905-11893.bib"))

regDataset(name = thisDataset,
           description = "We present BreizhCrops, a novel benchmark dataset for the supervised classification of field crops from satellite time series. We aggregated label data and Sentinel-2 top-of-atmosphere as well as bottom-of-atmosphere time series in the region of Brittany (Breizh in local language), north-east France. We compare seven recently proposed deep neural networks along with a Random Forest baseline. The dataset, model (re-)implementations and pre-trained model weights are available at the associated GitHub repository (https://github.com/dl4sits/breizhcrops) that has been designed with applicability for practitioners in mind. We plan to maintain the repository with additional data and welcome contributions of novel methods to build a state-of-the-art benchmark on methods for crop type mapping.",
           url = "https://doi.org/10.5194/isprs-archives-XLIII-B2-2020-1545-2020",
           download_date = "2020-06-08",
           type = "static",
           licence = "GPL-3.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# pre-process data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
untar(exdir = thisPath, tarfile = paste0(thisPath, "belle-ile.tar.gz"))

labels <- read_delim(paste0(thisPath, "codes.csv"), delim = ";") %>%
  rename(CODE_CULTU = `Code Culture`)
data <- st_read(dsn = paste0(thisPath, "belle-ile.shp")) %>%
  left_join(labels, by = "CODE_CULTU")


# manage ontology ---
#
# define labels in the new dataset and their matching already harmonised labels
matches <-
  tibble(new = unique(data$`Libellé Culture`),
         old = c("Permanent grazing", "Permanent grazing", "potato", "Fallow",
                 "Tree orchards", "Temporary grazing", NA, "cabbage", "barley",
                 "maize", "sugarbeet", "sorghum", "rapeseed", NA, "strawberry",
                 "melon", "pumpkin", "leek", "Medicinal crops",
                 "Root or Bulb vegetables", "Grass crops", "Grass crops",
                 "Grass crops", "FODDER CROPS", "oat", "alfalfa", "oat",
                 "wheat", "triticale", "Fallow", "Fallow", "barley",
                 "Other fodder crops", "Grazing Woodland", "Mixed cereals",
                 "Fodder legumes", "Fallow", "Permanent grazing", "soybean",
                 "Fallow", "Medicinal crops", "Woody plantation", "wheat",
                 "maize", "Fodder legumes", "broad bean"))
# getConcept(label_en = matches$old, missing = TRUE)

newConcept(new = c("Grazing Woodland"),
           broader = c("Other Wooded Areas"),
           class = c("forest use"),
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
centroids <- data %>%
  st_centroid() %>%
  st_coordinates() %>%
  as_tibble()
areas <- data %>%
  st_area() %>%
  as.numeric()
data <- data %>%
  as_tibble()

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = centroids$X,
    y = centroids$Y,
    geometry = geometry,
    area = areas,
    year = 2017,
    month = NA_real_,
    day = NA_integer_,
    country = "France",
    irrigated = NA,
    presence = TRUE,
    externalID = as.character(ID),
    externalValue = `Libellé Culture`,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "validation",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
