thisDataset <- "globe"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, _INSERT))
# bib <- bibentry(bibtype = "Misc",
#                 title = "Global Learning and Observations to Benefit the Environment (GLOBE) Program",
#                 url = "https://www.globe.gov/",
#                 note = "'Filter by Protocol' == 'Land Cover'")

# data_path_cmpr <- paste0(input_dir, "")
# unzip(exdir = input_dir, zipfile = data_path_cmpr)
# untar(exdir = input_dir, tarfile = data_path_cmpr)

# data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "GLOBEMeasurementData-17618.csv"))
# data <- data[-1,]

data_path <- paste0(input_dir, _INSERT)
data <- read_csv(file = data_path)
data <- read_tsv(file = data_path)
data <- read_excel(path = data_path)
data <- read_parquet(file = data_path)
data <- st_read(dsn = data_path) %>% as_tibble()
# make sure that coordinates are transformed to EPSG:4326 (WGS84)


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
  setIDVar(name = "type", value = "point") %>%
  setIDVar(name = "x", type = "n", columns = _INSERT) %>% # longitude
  setIDVar(name = "y", type = "n", columns = _INSERT) %>% # latitude
  setIDVar(name = "geometry", columns = _INSERT) %>%
  setIDVar(name = "date", columns = _INSERT) %>% # measured_on
  setIDVar(name = "irrigated", type = "l", value = FALSE) %>%
  setIDVar(name = "present", type = "l", value = TRUE) %>%
  setIDVar(name = "sample_type", value = "field") %>%
  setIDVar(name = "collector", value = "citizen scientist") %>%
  setIDVar(name = "purpose", value = "monitoring") %>%
  setObsVar(name = "concept", type = "c", columns = _INSERT) # `land covers:muc description`

temp <- reorganise(schema = schema_INSERT, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "This tool allows you to find and retrieve GLOBE data using several different search parameters.You will be presented a summary of sites that have data available based on your search parameters.From those sites you can further refine your search and or download the data into a CSV file for detailed analysis.A summary CSV file is also available that summarizes the amount of data available for each site.",
           homepage = "https://datasearch.globe.gov/",
           date = ymd("2022-05-30"),
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
