# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : areal
# doi/url   : https://data.amerigeoss.org/tl/dataset/experimental-forest-and-range-locations-feature-layer
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : forest, experimental
# ----

thisDataset <- "agris2018"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, "agrisexport.ris"))

data_path <- paste0(dir_input, "Experimental_Forest_and_Range_Locations__Feature_Layer_.csv")
data <- read_csv(file = data_path)


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
  setIDVar(name = "type", value = "areal") %>%
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

# temp <- data %>%
#   rowwise() %>%
#   mutate(
#     year = paste0(seq(from = ESTABLISHED, to = year(Sys.Date()), 1), collapse = "_") # check if the to year is still correct
#   )
#
# temp <- temp %>%
#   separate_rows(year, sep = "_") %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "",
#     country = "USA",
#     x = X,
#     y = Y,
#     geometry = NA,
#     epsg = 4326,
#     area = HECTARES * 10000,
#     date = ymd(paste0(year, "-01-01")),
#     externalID = as.character(OBJECTID),
#     externalValue = TYPE,
#     irrigated = NA,
#     presence = TRUE,
#     sample_type = "field",
#     collector = "expert",
#     purpose = "map development") %>%
#   select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
#          externalID, externalValue, irrigated, presence,
#          sample_type, collector, purpose, everything())

temp <- reorganise(schema = schema_INSERT, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "This point feature class contains the locations of all 87 experimental forests, ranges and watersheds, including cooperating experimental areas.",
           homepage = "https://data.amerigeoss.org/tl/dataset/experimental-forest-and-range-locations-feature-layer",
           date = dmy("28-10-2020"),
           license = _INSERT,
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

