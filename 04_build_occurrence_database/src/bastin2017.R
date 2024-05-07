# ----
# geography : Global
# period    : 2015
# typology  :
#   - cover  : VEGETATED
#   - use    : -
# features  : 213796
# data type : point
# sample    : _INSERT
# doi/url   : https://doi.org/10.1126/science.aam6527
# license   : _INSERT
# disclosed : _INSERT
# authors   : Steffen Ehrmann
# date      : 2024-04-05
# status    : done
# comment   : forest dryland
# ----

thisDataset <- "bastin2017"
message("\n---- ", thisDataset, " ----")

message(" --> handling metadata")
dir_input <- paste0(dir_occurr_wip, "input/", thisDataset, "/")

new_reference(object = paste0(dir_input, "csp_356_.bib"),
              file = paste0(dir_occurr_wip, "references.bib"))

new_source(name = thisDataset,
           description = "The extent of forest in dryland biomes",
           homepage = "https://doi.org/10.1126/science.aam6527",
           date = dmy("15-12-2021"),
           license = "unknown",
           ontology = path_onto_odb)


message(" --> handling data")
data_path_cmpr <- paste0(dir_input, "aam6527_Bastin_Database-S1.csv.zip")
data_path <- paste0(dir_input, "aam6527_Bastin_Database-S1.csv")

unzip(exdir = dir_input, zipfile = data_path_cmpr)

data <- read_delim(file = data_path,
                   delim = ";")


message(" --> normalizing data")
data <- data |>
  filter(!is.na(location_x) & !is.na(location_y)) |>
  mutate(present = if_else(land_use_category == "forest", TRUE, FALSE)) |>
  mutate(obsID = row_number(), .before = 1)

other <- data |>
  select(obsID, region = dryland_assessment_region, aridity = Aridity_zone, cover.tree = tree_cover)

schema_bastin2017 <-
  setFormat(header = 1L, decimal = ".") |>
  setIDVar(name = "datasetID", value = thisDataset) |>
  setIDVar(name = "obsID", type = "i", columns = 1) |>
  setIDVar(name = "open", type = "l", value = TRUE) |>
  setIDVar(name = "type", value = "point") |>
  setIDVar(name = "x", type = "n", columns = 2) |>
  setIDVar(name = "y", type = "n", columns = 3) |>
  setIDVar(name = "epsg", value = "4326") |>
  setIDVar(name = "date", value = "2015") |>
  setIDVar(name = "irrigated", type = "l", value = FALSE) |>
  setIDVar(name = "present", type = "l", columns = 8) |>
  setIDVar(name = "sample_type", value = "visual interpretation") |>
  setIDVar(name = "collector", value = "citizen scientist") |>
  setIDVar(name = "purpose", value = "study") |>
  setObsVar(name = "concept", type = "c", columns = 6)

temp <- reorganise(schema = schema_bastin2017, input = data)


message(" --> harmonizing with ontology")
out <- matchOntology(table = temp,
                     columns = "concept",
                     dataseries = thisDataset,
                     colsAsClass = FALSE,
                     ontology = path_onto_odb)

out <- list(harmonised = out, extra = other)


message(" --> writing output")
saveRDS(object = out, file = paste0(dir_occurr_wip, "output/", thisDataset, ".rds"))

beep(sound = 10)
message("\n     ... done")
