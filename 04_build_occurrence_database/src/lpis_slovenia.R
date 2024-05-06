# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# sample    : _INSERT
# doi/url   : https://rkg.gov.si/vstop/
# license   : _INSERT
# disclosed : _INSERT
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

thisDataset <- "lpis_slovenia"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr_wip, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, _INSERT))

# data_path_cmpr <- paste0(dir_input, "")
# unzip(exdir = dir_input, zipfile = data_path_cmpr)
# untar(exdir = dir_input, tarfile = data_path_cmpr)

data_path <- paste0(dir_input, _INSERT)
data <- read_csv(file = data_path)
data <- read_tsv(file = data_path)
data <- read_excel(path = data_path)
data <- read_parquet(file = data_path)
data <- read_rds(file = data_path)
data <- st_read(dsn = data_path) %>% as_tibble()
# make sure that coordinates are transformed to EPSG:4326 (WGS84)


message(" --> normalizing data")
data <- data |>
  mutate(obsID = row_number(), .before = 1)

other <- data |>
  select(obsID, _INSERT)

schema_INSERT <-
  setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
            na_values = _INSERT) |>
  setIDVar(name = "datasetID", value = thisDataset) |>
  setIDVar(name = "obsID", type = "i", columns = 1) |>
  setIDVar(name = "externalID", columns = _INSERT) |>
  setIDVar(name = "open", type = "l", value = _INSERT) |>
  setIDVar(name = "type", value = _INSERT) |>
  setIDVar(name = "x", type = "n", columns = _INSERT) |>
  setIDVar(name = "y", type = "n", columns = _INSERT) |>
  setIDVar(name = "geometry", columns = _INSERT) |>
  setIDVar(name = "date", columns = _INSERT) |>
  setIDVar(name = "irrigated", type = "l", value = _INSERT) |>
  setIDVar(name = "present", type = "l", value = _INSERT) |>
  setIDVar(name = "sample_type", value = _INSERT) |>
  setIDVar(name = "collector", value = _INSERT) |>
  setIDVar(name = "purpose", value = _INSERT) |>
  setObsVar(name = "concept", type = "c", columns = _INSERT)

temp <- reorganise(schema = schema_INSERT, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = _INSERT,
           homepage = _INSERT,
           date = ymd(_INSERT),
           license = _INSERT,
           ontology = path_onto_odb)

out <- matchOntology(table = temp,
                     columns = "concept",
                     colsAsClass = FALSE,
                     dataseries = thisDataset,
                     ontology = path_onto_odb)

out <- list(harmonised = out, extra = other)


message(" --> writing output")
saveRDS(object = out, file = paste0(dir_occurr_wip, "output/", thisDataset, ".rds"))
saveBIB(object = bib, file = paste0(dir_occurr_wip, "references.bib"))

beep(sound = 10)
message("\n     ... done")



