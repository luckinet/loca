# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : _INSERT
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : the labels for the points are missing
# ----

thisDataset <- "Crowther2019"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, "pericles_1461024822.ris"))

# data_path_cmpr <- paste0(dir_input, "")
# unzip(exdir = dir_input, zipfile = data_path_cmpr)
# untar(exdir = dir_input, tarfile = data_path_cmpr)

data_path <- paste0(dir_input, "Nutrient_Enrichment_Dataset.csv.csv")
data <- read_csv(file = data_path)


message(" --> normalizing data")
# temp <- data %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "point",
#     country = NA_character_,
#     x = long,
#     y = llat,
#     geometry = NA,
#     epsg = 4326,
#     area = NA_real_,
#     date = NA,
#     externalID = NA_character_,
#     externalValue = NA_character_,
#     # attr_1 = NA_character_,
#     # attr_1_typ = NA_character_,
#     irrigated = FALSE,
#     presence = NA,
#     sample_type = "field",
#     collector = "expert",
#     purpose = "study") %>%
#   select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
#          externalID, externalValue, irrigated, presence,
#          sample_type, collector, purpose, everything())

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
           description = "Soil stores approximately twice as much carbon as the atmosphere and fluctuations in the size of the soil carbon pool directly influence climate conditions. We used the Nutrient Network global change experiment to examine how anthropogenic nutrient enrichment might influence grassland soil carbon storage at a global scale. In isolation, enrichment of nitrogen and phosphorous had minimal impacts on soil carbon storage. However, when these nutrients were added in combination with potassium and micronutrients, soil carbon stocks changed considerably, with an average increase of 0.04 KgCm−2 year−1 (standard deviation 0.18 KgCm−2 year−1). These effects did not correlate with changes in primary productivity, suggesting that soil carbon decomposition may have been restricted. Although nutrient enrichment caused soil carbon gains most dry, sandy regions, considerable absolute losses of soil carbon may occur in high‐latitude regions that store the majority of the world's soil carbon. These mechanistic insights into the sensitivity of grassland carbon stocks to nutrient enrichment can facilitate biochemical modelling efforts to project carbon cycling under future climate scenarios.",
           homepage = "https://doi.org/10.5061/dryad.0dt27vb",
           date = ymd("2022-06-01"),
           license = "https://creativecommons.org/publicdomain/zero/1.0",
           ontology = path_onto_odb)

out <- matchOntology(table = temp,
                     columns = "concept",
                     colsAsClass = FALSE,
                     dataseries = thisDataset,
                     ontology = path_onto_odb)

out <- list(harmonised = out, extra = other)


message(" --> writing output")
saveRDS(object = out, file = paste0(dir_occurr, "output/", thisDataset, ".rds"))
saveBIB(object = bib, file = paste0(dir_occurr, "references.bib"))

beep(sound = 10)
message("\n     ... done")
