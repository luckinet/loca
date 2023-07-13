# script arguments ----
#
thisDataset <- "breizhCrops"
description <- "We present BreizhCrops, a novel benchmark dataset for the supervised classification of field crops from satellite time series. We aggregated label data and Sentinel-2 top-of-atmosphere as well as bottom-of-atmosphere time series in the region of Brittany (Breizh in local language), north-east France. We compare seven recently proposed deep neural networks along with a Random Forest baseline. The dataset, model (re-)implementations and pre-trained model weights are available at the associated GitHub repository (https://github.com/dl4sits/breizhcrops) that has been designed with applicability for practitioners in mind. We plan to maintain the repository with additional data and welcome contributions of novel methods to build a state-of-the-art benchmark on methods for crop type mapping."
url <- "https://doi.org/10.5194/isprs-archives-XLIII-B2-2020-1545-2020 https://"
licence <- "GPL-3.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "abs-1905-11893.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2020-06-08"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
untar(exdir = thisPath, tarfile = paste0(thisPath, "belle-ile.tar.gz"))

labels <- read_delim(paste0(thisPath, "codes.csv"), delim = ";") %>%
  rename(CODE_CULTU = `Code Culture`)
data <- st_read(dsn = paste0(thisPath, "belle-ile.shp")) %>%
  left_join(labels, by = "CODE_CULTU")


# pre-process data ----
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


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "France",
    x = centroids$X,
    y = centroids$Y,
    geometry = geometry,
    epsg = 4326,
    area = areas,
    date = NA,
    # year = 2017,
    # month = NA_real_,
    # day = NA_integer_,
    externalID = as.character(ID),
    externalValue = `Libellé Culture`,
    irrigated = NA,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "validation") %>%
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

# matches <-
#   tibble(new = unique(data$`Libellé Culture`),
#          old = c("Permanent grazing", "Permanent grazing", "potato", "Fallow",
#                  "Tree orchards", "Temporary grazing", NA, "cabbage", "barley",
#                  "maize", "sugarbeet", "sorghum", "rapeseed", NA, "strawberry",
#                  "melon", "pumpkin", "leek", "Medicinal crops",
#                  "Root or Bulb vegetables", "Grass crops", "Grass crops",
#                  "Grass crops", "FODDER CROPS", "oat", "alfalfa", "oat",
#                  "wheat", "triticale", "Fallow", "Fallow", "barley",
#                  "Other fodder crops", "Grazing Woodland", "Mixed cereals",
#                  "Fodder legumes", "Fallow", "Permanent grazing", "soybean",
#                  "Fallow", "Medicinal crops", "Woody plantation", "wheat",
#                  "maize", "Fodder legumes", "broad bean"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
