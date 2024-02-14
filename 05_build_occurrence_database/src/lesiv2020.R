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
thisDataset <- "Lesiv2020"
description <- "The data set, in a form of table, contains information on Human Impact on Forests that was collected during a few crowd sourcing campaigns (Human Impact on Tropical Forest, Human Impact on Temperate Forest and Human Impact on Boreal Forest). the data set is not yet final. We expect to publish the final version under Open Access in nearest future."
doi <- "https://zenodo.org/record/3356758"
licence <- ""

message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(occurr_dir, "input/", thisDataset, "/", "ref.bib"))


# read dataset ----
#
data_path <- paste0(occurr_dir, "input/", thisDataset, "/", "final_training_data.csv")

data <- read_csv(file = data_path, col_names = FALSE, col_types = cols(.default = "c"))


# data management ----
#


# matches <- tibble(new = as.character(unique(data$level12)),
#                   old = c("Palm plantations", "Undisturbed Forest", NA,
#                           "Tree orchards", "Naturally Regenerating Forest",
#                           "Woody plantation", "Tree orchards",
#                           "Undisturbed Forest", "Planted Forest"))

# harmonise data ----
#
data <- data %>%
  mutate(obsID = row_number(), .before = 1)                                     # define observation ID on raw data to be able to join harmonised data with the rest

schema_ <-
  setFormat(decimal = , thousand = , na_values = ) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", columns = 1) %>%
  setIDVar(name = "externalID", columns = 3) %>%
  setIDVar(name = "open", value = FALSE) %>%
  setIDVar(name = "type", value = "point") %>%
  setIDVar(name = "x", columns = 4) %>%
  setIDVar(name = "y", columns = 5) %>%
  setIDVar(name = "epsg", value = "4326") %>%
  setIDVar(name = "date", value = ymd("2015-01-01")) %>%
  setIDVar(name = "sample_type", value = "visual interpretation") %>%
  setIDVar(name = "collector", value = "citizen scientist") %>%
  setIDVar(name = "purpose", value = "validation") %>%
  setObsVar(name = "value", columns = 6) %>%
  setObsVar(name = "irrigated", value = FALSE) %>%
  setObsVar(name = "present", value = TRUE)

temp <- reorganise(schema = schema_, input = data)

otherData <- data %>%
  select()                                                                      # remove all columns that are recorded in 'out'


# harmonize with ontology ----
#
new_source(name = thisDataset,
           description = description,
           homepage = doi,
           date = ymd("2020-10-21"),
           license = licence,
           ontology = onto_path)

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


beep(sound = 10)
message("\n     ... done")
