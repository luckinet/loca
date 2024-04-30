# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://doi.org/10.1594/PANGAEA.911560
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

thisDataset <- "Camara2020"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, "tandf_tgis2033_176.bib"))

# data_path_cmpr <- paste0(dir_input, "")
# unzip(exdir = dir_input, zipfile = data_path_cmpr)
# untar(exdir = dir_input, tarfile = data_path_cmpr)

data_path <- paste0(dir_input, "samples_amazonia.rds")
data <- read_rds(file = data_path)


message(" --> normalizing data")
# data <- data %>%
#   as_tibble() %>%
#   separate_rows(label, sep = "_")
#
# data < -data[!(data$label=="Roraima"),]
# temp <- data %>%
#   select(-start_date) %>%
#   rename(start_date = end_date)
#
# data <- data %>%
#   bind_rows(temp)
#
# temp <- data %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "point",
#     country = "Brazil",
#     x = longitude,
#     y = latitude,
#     geometry = NA,
#     epsg = 4326,
#     area = NA_real_,
#     date = ymd(start_date),
#     externalID = as.character(id_sample),
#     externalValue = label,
#     # attr_1 = NA_character_,
#     # attr_1_typ = NA_character_,
#     irrigated = NA,
#     presence = TRUE,
#     sample_type = "field",
#     collector = NA_character_,
#     purpose = "map development") %>%
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
           description = "This dataset contains the yearly maps of land use and land cover classification for Amazon biome, Brazil, from 2000 to 2019 at 250 meters of spatial resolution. We used image time series from MOD13Q1 product from MODIS (collection 6), with four bands (NDVI, EVI, near-infrared, and mid-infrared) as data input. A deep learning classification MLP network consisting of 4 hidden layers with 512 units was trained using a set of 33,052 time series of 12 known classes from both natural and anthropic land covers.",
           homepage = "https://doi.org/10.1594/PANGAEA.911560",
           date = ymd("2022-01-22"),
           license = "https://creativecommons.org/licenses/by/4.0/",
           ontology = path_onto_odb)

# matches <- tibble(new = unique(data$label),
#                   old = c("Fallow", "cotton", "Forests", "millet", "cotton",
#                           "Permanent grazing", "savanna", "savanna", "soybean",
#                           "maize", "soybean", "cotton", "soybean", "Fallow",
#                           "soybean", "millet", "soybean", "sunflower", "WETLANDS"))
# newConcepts <- tibble(target = c("Forests", "Temporary grazing", "soybean",
#                                  "maize", "cotton", "Fallow",
#                                  "millet", "Other Wooded Areas", "Inland wetlands",
#                                  "sunflower"),
#                       new = unique(data$label),
#                       class = c("landcover", "land-use", "commodity",
#                                 "commodity", "commodity", "land-use",
#                                 "commodity", "landcover", "landcover",
#                                 "commodity"),
#                       description = NA,
#                       match = "close",
#                       certainty = 3)

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
