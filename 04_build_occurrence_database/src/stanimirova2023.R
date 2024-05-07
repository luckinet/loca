# ----
# geography : Global
# period    : 1984 - 2020
# typology  :
#   - cover  : various
#   - use    : -
# features  : 1874995
# data type : point
# doi/url   : https://doi.org/10.1038/s41597-023-02798-5
# authors   : Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : landcover for ML training
# ----

thisDataset <- "stanimirova2023"
message("\n---- ", thisDataset, " ----")

message(" --> handling metadata")
dir_input <- paste0(dir_occurr_wip, "input/", thisDataset, "/")

new_reference(object = paste0(dir_input, "10.1038_s41597-023-02798-5-citation.bib"),
              file = paste0(dir_occurr_wip, "references.bib"))

new_source(name = thisDataset,
           description = "State-of-the-art cloud computing platforms such as Google Earth Engine (GEE) enable regional to-global land cover and land cover change mapping with machine learning algorithms. However, collection of high-quality training data, which is necessary for accurate land cover mapping, remains costly and labor-intensive. To address this need, we created a global database of nearly 2 million training units spanning the period from 1984 to 2020 for seven primary and nine secondary land cover classes. Our training data collection approach leveraged GEE and machine learning algorithms to ensure data quality and biogeographic representation...",
           homepage = "https://doi.org/10.1038/s41597-023-02798-5",
           date = ymd("2024-02-15"),
           license = "https://creativecommons.org/licenses/by/4.0/",
           ontology = path_onto_odb)


message(" --> handling data")
data_path <- paste0(dir_input, "bu_glance_training_dataV1.parquet")
data <- read_parquet(file = data_path)


message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1)

other <- data %>%
  select(_INSERT)

schema_stanimirova2023 <-
  setFormat(header = 1L) %>%
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

temp <- reorganise(schema = schema_stanimirova2023, input = data)


message(" --> harmonizing with ontology")
out <- matchOntology(table = temp,
                     columns = "concept",
                     colsAsClass = FALSE,
                     dataseries = thisDataset,
                     ontology = path_onto_odb)

out <- list(harmonised = out, extra = other)


message(" --> writing output")
saveRDS(object = out, file = paste0(dir_occurr_wip, "output/", thisDataset, ".rds"))

beep(sound = 10)
message("\n     ... done")
