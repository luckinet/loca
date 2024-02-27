thisDataset <- _INSERT
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, _INSERT))

# data_path_cmpr <- paste0(input_dir, "")
# unzip(exdir = input_dir, zipfile = data_path_cmpr)
# untar(exdir = input_dir, tarfile = data_path_cmpr)

data_path <- paste0(input_dir, _INSERT)
data <- read_csv(file = data_path)
data <- read_tsv(file = data_path)
data <- read_excel(path = data_path)
data <- read_parquet(file = data_path)
data <- st_read(dsn = data_path) %>% as_tibble()


message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1)

other <- data %>%
  select(obsID, _INSERT)

schema_INSERT <-
  setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
            na_values = _INSERT) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", type = "i", columns = 1) %>%
  setIDVar(name = "externalID", columns = _INSERT) %>%
  setIDVar(name = "open", type = "l", value = _INSERT) %>%
  setIDVar(name = "type", value = _INSERT) %>%
  setIDVar(name = "x", type = "n", columns = _INSERT) %>%
  setIDVar(name = "y", type = "n", columns = _INSERT) %>%
  setIDVar(name = "epsg", value = _INSERT) %>%
  setIDVar(name = "geometry", columns = _INSERT) %>%
  setIDVar(name = "date", columns = _INSERT) %>%
  setIDVar(name = "irrigated", type = "l", value = _INSERT) %>%
  setIDVar(name = "present", type = "l", value = _INSERT) %>%
  setIDVar(name = "sample_type", value = _INSERT) %>%
  setIDVar(name = "collector", value = _INSERT) %>%
  setIDVar(name = "purpose", value = _INSERT) %>%
  setObsVar(name = "concept", type = "c", columns = _INSERT)

temp <- reorganise(schema = schema_INSERT, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = _INSERT,
           homepage = _INSERT,
           date = ymd(_INSERT),
           license = _INSERT,
           ontology = odb_onto_path)

out <- matchOntology(table = temp,
                     columns = "concept",
                     colsAsClass = FALSE,
                     dataseries = thisDataset,
                     ontology = odb_onto_path)


message(" --> writing output")
saveRDS(object = out, file = paste0(occurr_dir, "output/", thisDataset, ".rds"))
saveRDS(object = other, file = paste0(occurr_dir, "output/", thisDataset, "_extra.rds"))
saveBIB(object = bib, file = paste0(occurr_dir, "references.bib"))

beep(sound = 10)
message("\n     ... done")

# script arguments ----
#
thisDataset <- "breizhCrops"
description <- "We present BreizhCrops, a novel benchmark dataset for the supervised classification of field crops from satellite time series. We aggregated label data and Sentinel-2 top-of-atmosphere as well as bottom-of-atmosphere time series in the region of Brittany (Breizh in local language), north-east France. We compare seven recently proposed deep neural networks along with a Random Forest baseline. The dataset, model (re-)implementations and pre-trained model weights are available at the associated GitHub repository (https://github.com/dl4sits/breizhcrops) that has been designed with applicability for practitioners in mind. We plan to maintain the repository with additional data and welcome contributions of novel methods to build a state-of-the-art benchmark on methods for crop type mapping."
url <- "https://doi.org/10.5194/isprs-archives-XLIII-B2-2020-1545-2020 https://"
licence <- "GPL-3.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "abs-1905-11893.bib"))

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
untar(exdir = occurrenceDBDir, "00_incoming/", thisDataset, tarfile = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "belle-ile.tar.gz"))

labels <- read_delim(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "codes.csv"), delim = ";") %>%
  rename(CODE_CULTU = `Code Culture`)
data <- st_read(dsn = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "belle-ile.shp")) %>%
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
