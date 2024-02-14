thisDataset <- "INSERT"                                                         # the ID of this dataset
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, "INSERT"))                             # citation(s)

# data_path_cmpr <- paste0(input_dir, "")
data_path <- paste0(input_dir, "INSERT")

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
           description = "INSERT",                                              # the abstract (if paper available) or project description
           homepage = "INSERT",                                                 # either the doi to the dataset, the doi to the paper or the url to the dataset
           date = ymd("INSERT"),                                                # the download date
           license = "INSERT",                                                  # the url to a license
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
thisDataset <- "cropHarvest"
description <- "CropHarvest is an open source remote sensing dataset for agriculture with benchmarks. It collects data from a variety of agricultural land use datasets and remote sensing products."
url <- "https://github.com/nasaharvest/cropharvest"
licence <- "https://creativecommons.org/licenses/by-sa/4.0/"

message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(occurr_dir, "input/", thisDataset, "/", "cropHarvest.bib"))


# read dataset ----
#
data_path <- paste0(occurr_dir, "input/", thisDataset, "/", "labels.geojson")

data <- st_read(dsn = data_path) %>% as_tibble()


# data management ----
#
# data <- data %>%
#   filter(st_geometry_type(data) == "MULTIPOLYGON") %>%
#   st_cast("POLYGON") %>%
#   bind_rows(data %>% filter(st_geometry_type(data) == "POLYGON")) %>%
#   st_boundary() %>%
#   st_centroid() %>%
#   bind_rows(data %>% filter(st_geometry_type(data) %in% c("POINT", "MULTIPOINT"))) %>%
#   st_cast("POINT")
#
# centroid <- data  %>%
#   st_coordinates() %>%
#   as_tibble()
#
# temp <- data %>%
#   as_tibble() %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "point",
#     country = dataset,
#     x = centroid$X,
#     y = centroid$Y,
#     geometry = NA,
#     epsg = 4326,
#     area = NA_real_,
#     date = dmy(collection_date),
#     externalID = NA_character_,
#     externalValue = label,
#     irrigated = NA,
#     presence = TRUE,
#     sample_type = "field",
#     collector = "expert",
#     purpose = "validation") %>%
#   select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
#          externalID, externalValue, irrigated, presence,
#          sample_type, collector, purpose, everything())


# harmonise data ----
#
data <- data %>%
  mutate(obsID = row_number(), .before = 1)                                     # define observation ID on raw data to be able to join harmonised data with the rest

schema_INSERT <-
  setFormat(decimal = INSERT, thousand = INSERT, na_values = INSERT) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%                         # the dataset ID
  setIDVar(name = "obsID", columns = 1) %>%                                     # the observation ID
  setIDVar(name = "externalID", columns = INSERT) %>%                           # the verbatim observation-specific ID as used in the external dataset
  setIDVar(name = "open", value = INSERT) %>%                                   # whether the dataset is freely available (TRUE) or restricted (FALSE)
  setIDVar(name = "type", value = INSERT) %>%                                   # whether the data are "point" or "areal" (when its from a plot, region, nation, etc)
  setIDVar(name = "x", columns = INSERT) %>%                                    # the x-value of the coordinate (or centroid if type = "areal")
  setIDVar(name = "y", columns = INSERT) %>%                                    # the y-value of the coordinate (or centroid if type = "areal")
  setIDVar(name = "epsg", value = INSERT) %>%                                   # the EPSG code of the coordinates or geometry
  setIDVar(name = "geometry", columns = INSERT) %>%                             # the geometries if type = "areal"
  setIDVar(name = "date", columns = INSERT) %>%                                 # the date of the observation
  setIDVar(name = "sample_type", value = INSERT) %>%                            # from what space the data were collected, either "field/ground", "visual interpretation", "experience", "meta study" or "modelled"
  setIDVar(name = "collector", value = INSERT) %>%                              # who the collector was, either "expert", "citizen scientist" or "student"
  setIDVar(name = "purpose", value = INSERT) %>%                                # what the data were collected for, either "monitoring", "validation", "study" or "map development"
  setObsVar(name = "value", columns = INSERT) %>%                               # the value of the observation
  setObsVar(name = "irrigated", columns = INSERT) %>%                           # whether the observation receives irrigation (TRUE) or not (FALSE)
  setObsVar(name = "present", columns = INSERT) %>%                             # whether the observation describes a presence (TRUE) or an absence (FALSE)
  setObsVar(name = "area", columns = INSERT)                                    # the area covered by the observation (if type = "areal")

temp <- reorganise(schema = schema_INSERT, input = data)

otherData <- data %>%
  select(INSERT)                                                                # remove all columns that are recorded in 'out'


# harmonize with ontology ----
#
new_source(name = thisDataset,
           description = description,
           homepage = doi,
           date = ymd("2021-09-17"),
           license = licence,
           ontology = onto_path)

# matches <- tibble(new = unique(data$label),
#                   old = c(NA, "Cerrado", "Permanent grazing", "coffee", "Fallow", "Temporary grazing", NA, "eucalyptus",
#                           "Permanent grazing", "cotton", "wheat", "rice", "Tree orchards", "alfalfa", "maize", "grape",
#                           "cassava", "sorghum", "bean", "peanut", "Fallow", "millet", "tomato", "sugarcane",
#                           "sweet potato", "banana", "soybean", "cabbage", "bean", "sunflower", "string bean", "safflower",
#                           "sorghum", "maize", "oil palm", "potato", "peanut", "barley", "Leguminous crops", "wheat",
#                           "maize", "Fallow", "Permanent grazing", "barley", "Fallow", "barley", "rapeseed", "potato",
#                           "Fallow", "clover", "Temporary grazing", "Temporary grazing", "sugarbeet", "alfalfa", "linseed", "Temporary grazing",
#                           NA, "pea", "triticale", "soybean", "oat", "Tree orchards", "Temporary grazing", "onion",
#                           "", "", "", "", "", "", "", "",
#                           "", "", "", "", "", "", "", "",
#                           "", "", "", "", "", "", "", "",
#                           "", "", "", "rye", "", "", "", "",
#                           "", "", "", "", "", "", "", "",
#                           "Root or Bulb vegetables", "", "", "", "", "", "", "",
#                           "", "", "", "", "", "", "", "",
#                           "", "", "", "", "", "", "", "",
#                           "", "", "", "", "", "", "", "",
#                           "", "", "", "", "", "", "", "",
#                           "", "", "", "", "celery", "", "", "",
#                           "", "", "", "", "", "", "", "",
#                           "bean", "", "", "", "", "", "", "",
#                           "", "", "", "", "", "", "", "melon",
#                           "", "", "", "", "", "", "", "",
#                           "", "", "", "", "", "", "", "",
#                           "", "", "", "", "", "Medicinal crops", "", "Protective cover",
#                           "banana", "", "", "sugarcane", "sugarcane", "banana", "avocado", "",
#                           "banana", "", "", "", "", "", "banana", "banana",
#                           "banana", "banana", "", "", "peanut", "bean", "potato", "sesame",
#                           "WETLANDS", "Herbaceous associations", "", "Shrubland", "", "Permanent grazing", "", "CEREALS",
#                           "Barley", "maize", "Permanent grazing", "wheat", "soybean", "Forests", NA, "barley",
#                           "rapeseed", "wheat", "Permanent grazing", "Woody plantation", "Protective cover", "rye", "Permanent grazing", "clover",
#                           "Shrubland", NA, "Fallow", "Herbaceous associations", "Open spaces with little or no vegetation", "WATER BODIES", "oat", "Coniferous Forest",
#                           "clover", "Broad-leaved Forest", "clover", "sunflower", "Grass and fodder crops", "bean", "apple", "VEGETABLES",
#                           "raspberry", "FRUIT", "strawberry", "onion", "broccoli", "cauliflower", "pea", "pea",
#                           "sugarbeet", "ginseng", "rye", "cherry", "cucumber", "tomato", "squash", "carrot",
#                           "tobacco", "asparagus", "Other crops", "lettuce", "pumpkin", "brussels sprout", "lavendar", "maize",
#                           "peach", "pepper", "pear", "miscanthus", "", "blueberry", "broad bean", "Mixed Forest",
#                           "hop", "buckwheat", "rye", NA, "blueberry", "triticale", "Permanent grazing", "linseed",
#                           "Grass and fodder crops", "", "plum", "apricot", "barley", "clover", "Wheat", "Grass and fodder crops",
#                           "sugarbeet", "triticale", "wheat", "eggplant", "blueberry", "cranberry", "mustard", "hemp",
#                           "raspberry", "Other stimulants", "Other stimulants", NA, "hazelnut", "Other vegetables", "Treenuts", "Temporally Unstocked Forest",
#                           "CEREALS", NA, "Oilseed crops", "Leguminous crops", "triticale", "poplar", "celery", "honeyberry",
#                           "walnut", "Berries", "Open spaces with little or no vegetation", "NUTS", "wheat", "BIOENERGY CROPS", "artichoke", "Grass and fodder crops",
#                           "vetch", "lentil", "quinoa", "Tree orchards"))

out <- matchOntology(table = temp,
                     columns = "value",
                     dataseries = thisDataset,
                     ontology = onto_path)


# write output ----
#
validateFormat(object = out) %>%
  saveRDS(file = paste0(occurr_dir, thisDataset, ".rds"))

saveRDS(object = otherData, file = paste0(occurr_dir, thisDataset, "_other.rds"))

read_lines(file = paste0(occurr_dir, "references.bib")) %>%
  c(bibtex_writer(z = bib, key = thisDataset)) %>%
  write_lines(file = paste0(occurr_dir, "references.bib"))


# beep(sound = 10)
message("\n     ... done")

