# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# sample    : _INSERT
# doi/url   : _INSERT
# license   : _INSERT
# disclosed : _INSERT
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

thisDataset <- "gofc-gold"
message("\n---- ", thisDataset, " ----")

message(" --> handling metadata")
dir_input <- paste0(dir_occurr_wip, "input/", thisDataset, "/")

new_reference(object = paste0(dir_input, _INSERT),
              file = paste0(dir_occurr_wip, "references.bib"))

new_source(name = thisDataset,
           description = "Towards Better Use of Global Land Cover Datasets and Improved Accuracy Assessment Practices",
           homepage = "https://gofcgold.org/",
           date = ymd("2021-11-12"),
           license = _INSERT,
           ontology = path_onto_odb)


message(" --> handling data")
# data_path_cmpr <- paste0(dir_input, "")
# unzip(exdir = dir_input, zipfile = data_path_cmpr)
# untar(exdir = dir_input, tarfile = data_path_cmpr)

data_path <- paste0(dir_input, _INSERT)
data <- read_csv(file = data_path)
data <- read_tsv(file = data_path)
data <- read_excel(path = data_path)
data <- read_parquet(file = data_path)
data <- read_rds(file = data_path)
data <- st_read(dsn = data_path) |> as_tibble()
# make sure that coordinates are transformed to EPSG:4326 (WGS84)

# data1 <- read_excel(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "glc2k_agl11_rndsel.xlsx"), sheet = 1)
# data2 <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "GLCNMO_2008.csv"))
# data3 <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Globcover2005_April2013_no_commo.csv"))
# data4 <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "step_september152014_70rndsel_igbpcl.csv"))


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
  setIDVar(name = "date", columns = _INSERT) |>
  setIDVar(name = "irrigated", type = "l", value = _INSERT) |>
  setIDVar(name = "present", type = "l", value = _INSERT) |>
  setIDVar(name = "sample_type", value = _INSERT) |>
  setIDVar(name = "collector", value = _INSERT) |>
  setIDVar(name = "purpose", value = _INSERT) |>
  setObsVar(name = "concept", type = "c", columns = _INSERT)

temp <- reorganise(schema = schema_INSERT, input = data)


message(" --> harmonizing with ontology")
out <- matchOntology(table = temp,
                     columns = "concept",
                     colsAsClass = FALSE,
                     dataseries = thisDataset,
                     ontology = path_onto_odb)

out <- list(harmonised = out, extra = other)

# # in case it's type=areal ...
# geom <- data |>
#   select(obsID, geom)


message(" --> writing output")
saveRDS(object = out, file = paste0(dir_occurr_wip, "output/", thisDataset, ".rds"))
# st_write(obj = geom, dsn = paste0(dir_occurr_wip, "output/", thisDataset, ".gpkg"))

beep(sound = 10)
message("\n     ... done")
