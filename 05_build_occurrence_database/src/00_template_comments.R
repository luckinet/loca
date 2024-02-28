thisDataset <- _INSERT                                                         # the ID of this dataset
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, _INSERT))                              # citation(s)

# data_path_cmpr <- paste0(input_dir, "")
# unzip(exdir = input_dir, zipfile = data_path_cmpr)                            # in case of zip archive
# untar(exdir = input_dir, tarfile = data_path_cmpr)                            # in case of tar archive

data_path <- paste0(input_dir, _INSERT)
data <- read_csv(file = data_path)                                              # in case of comma separated file
data <- read_tsv(file = data_path)                                              # in case of tab-stop separated files
data <- read_excel(path = data_path)                                            # in case of excel file
data <- read_parquet(file = data_path)                                          # in case of parquet-database
data <- st_read(dsn = data_path) %>% as_tibble()                                # in case of geopackage/shape/...
# make sure that coordinates are transformed to EPSG:4326 (WGS84)


message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1)                                     # define observation ID on raw data to be able to join harmonised data with the rest

other <- data %>%
  select(obsID, _INSERT)                                                        # capture all other columns that are important to interpret this dataset later on

schema_INSERT <-
  setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
            na_values = _INSERT) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%                         # the dataset ID
  setIDVar(name = "obsID", type = "i", columns = 1) %>%                         # the observation ID
  setIDVar(name = "externalID", columns = _INSERT) %>%                          # the verbatim observation-specific ID as used in the external dataset
  setIDVar(name = "open", type = "l", value = _INSERT) %>%                      # whether the dataset is freely available (TRUE) or restricted (FALSE)
  setIDVar(name = "type", value = _INSERT) %>%                                  # whether the data are "point" or "areal" (when its from a plot, region, nation, etc)
  setIDVar(name = "x", type = "n", columns = _INSERT) %>%                       # the x-value of the coordinate (or centroid if type = "areal")
  setIDVar(name = "y", type = "n", columns = _INSERT) %>%                       # the y-value of the coordinate (or centroid if type = "areal")
  setIDVar(name = "geometry", columns = _INSERT) %>%                            # the geometries if type = "areal"
  setIDVar(name = "date", columns = _INSERT) %>%                                # the date (as character) of the observation
  setIDVar(name = "irrigated", type = "l", value = _INSERT) %>%                 # whether the observation receives irrigation (TRUE) or not (FALSE)
  setIDVar(name = "present", type = "l", value = _INSERT) %>%                   # whether the observation describes a presence (TRUE) or an absence (FALSE)
  setIDVar(name = "sample_type", value = _INSERT) %>%                           # from what space the data were collected, either "field/ground", "visual interpretation", "experience", "meta study" or "modelled"
  setIDVar(name = "collector", value = _INSERT) %>%                             # who the collector was, either "expert", "citizen scientist" or "student"
  setIDVar(name = "purpose", value = _INSERT) %>%                               # what the data were collected for, either "monitoring", "validation", "study" or "map development"
  setObsVar(name = "concept", type = "c", columns = _INSERT)                    # the value of the observation

temp <- reorganise(schema = schema_INSERT, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = _INSERT,                                               # the abstract (if paper available) or project description
           homepage = _INSERT,                                                  # either the doi to the dataset, the doi to the paper or the url to the dataset
           date = ymd(_INSERT),                                                 # the download date
           license = _INSERT,                                                   # the url to a license
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
