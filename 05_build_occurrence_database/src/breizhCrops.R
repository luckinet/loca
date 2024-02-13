thisDataset <- INSERT                                                           # the ID of this dataset
description <- INSERT                                                           # the abstract (if paper available) or project description
doi <- INSERT                                                                   # either the doi to the dataset, the doi to the paper or the url to the dataset
licence <- INSERT                                                               # the url to a license

message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, INSERT))                               # citation(s)

# data_path_cmpr <- paste0(input_dir, "")
data_path <- paste0(input_dir, INSERT)

# (unzip/untar)
# unzip(exdir = input_dir, zipfile = data_path_cmpr)                            # in case of zip archive
# untar(exdir = input_dir, tarfile = data_path_cmpr)                            # in case of tar archive

data <- read_csv(file = data_path,
                 col_names = FALSE,
                 col_types = cols(.default = "c"))                              # in case of csv
data <- read_tsv()
data <- st_read(dsn = data_path) %>% as_tibble()                                # in case of geopackage/shape/...
data <- read_excel(path = data_path)                                            # in case of excel file


message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1)                                     # define observation ID on raw data to be able to join harmonised data with the rest

schema_INSERT <-
  setFormat(decimal = INSERT, thousand = INSERT, na_values = INSERT) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%                         # the dataset ID
  setIDVar(name = "obsID", type = "i", columns = 1) %>%                         # the observation ID
  setIDVar(name = "externalID", columns = INSERT) %>%                           # the verbatim observation-specific ID as used in the external dataset
  setIDVar(name = "open", type = "l", value = INSERT) %>%                       # whether the dataset is freely available (TRUE) or restricted (FALSE)
  setIDVar(name = "type", value = INSERT) %>%                                   # whether the data are "point" or "areal" (when its from a plot, region, nation, etc)
  setIDVar(name = "x", type = "n", columns = INSERT) %>%                        # the x-value of the coordinate (or centroid if type = "areal")
  setIDVar(name = "y", type = "n", columns = INSERT) %>%                        # the y-value of the coordinate (or centroid if type = "areal")
  setIDVar(name = "epsg", value = INSERT) %>%                                   # the EPSG code of the coordinates or geometry
  setIDVar(name = "geometry", columns = INSERT) %>%                             # the geometries if type = "areal"
  setIDVar(name = "date", columns = INSERT) %>%                                 # the date (as character) of the observation
  setIDVar(name = "irrigated", type = "l", columns = INSERT) %>%                # whether the observation receives irrigation (TRUE) or not (FALSE)
  setIDVar(name = "present", type = "l", columns = INSERT) %>%                  # whether the observation describes a presence (TRUE) or an absence (FALSE)
  setIDVar(name = "sample_type", value = INSERT) %>%                            # from what space the data were collected, either "field/ground", "visual interpretation", "experience", "meta study" or "modelled"
  setIDVar(name = "collector", value = INSERT) %>%                              # who the collector was, either "expert", "citizen scientist" or "student"
  setIDVar(name = "purpose", value = INSERT) %>%                                # what the data were collected for, either "monitoring", "validation", "study" or "map development"
  setObsVar(name = "concept", type = "c", columns = INSERT)                     # the value of the observation

temp <- reorganise(schema = schema_INSERT, input = data)

other <- data %>%
  slice(-INSERT) %>%                                                            # slice off the rows that contain the header
  select(INSERT)                                                                # remove all columns that are recorded in 'out'


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = description,
           homepage = doi,
           date = ymd(INSERT),                                                        # the download date
           license = license,
           ontology = odb_onto_path)

out <- matchOntology(table = temp,
                     columns = "concept",
                     colsAsClass = FALSE,
                     dataseries = thisDataset,
                     ontology = odb_onto_path)


message(" --> writing output")
saveRDS(object = out, file = paste0(occurr_dir, "output/", thisDataset, ".rds"))
saveRDS(object = other, file = paste0(occurr_dir, "output/", thisDataset, "_other.rds"))
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
