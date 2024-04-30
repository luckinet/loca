# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://doi.org/10.1371/journal.pone.0190234
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : crop, shea tree
# ----

thisDataset <- "Aleza2018"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, "10.1371_journal.pone.0190234.ris"))

data_path <- paste0(dir_input, "Benin Agroforetry LU GPS Coordinate.xlsx")
data <- read_excel(path = data_path)


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

# temp <- data %>% dplyr::filter( `Species name` == "Vitellaria paradoxa" | `Species name` == "Vitellaria paradoxa coupe")
#
# temp <- temp %>%
#   st_as_sf(., coords = c("Longitude", "Latitude"), crs = CRS("EPSG:32631")) %>%
#   st_transform(., crs = "EPSG:4326") %>%
#   mutate(lon = st_coordinates(.)[,1],
#          lat = st_coordinates(.)[,2]) %>%
#   as.data.frame()
#
# temp <- temp %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "point",
#     country = "Benin",
#     x = lon,
#     y = lat,
#     geometry = NA,
#     epsg = 4326,
#     area = NA_real_,
#     date = NA, # 2013 - month 9_10_11
#     externalID = NA_character_,
#     externalValue = `Species name`,
#     irrigated = FALSE,
#     presence = TRUE,
#     sample_type = "field",
#     collector = "expert",
#     purpose = "study") %>%
#   separate_rows(month, sep = "_") %>%
#   mutate(month = as.numeric(month),
#          fid = row_number()) %>%
#   select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
#          externalID, externalValue, irrigated, presence,
#          sample_type, collector, purpose, everything())

temp <- reorganise(schema = schema_INSERT, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "Vitellaria paradoxa (Gaertn C. F.), or shea tree, remains one of the most valuable trees for farmers in the Atacora district of northern Benin, where rural communities depend on shea products for both food and income. To optimize productivity and management of shea agroforestry systems, or parklands, accurate and up-to-date data are needed. For this purpose, we monitored120 fruiting shea trees for two years under three land-use scenarios and different soil groups in Atacora, coupled with a farm household survey to elicit information on decision making and management practices. To examine the local pattern of shea tree productivity and relationships between morphological factors and yields, we used a randomized branch sampling method and applied a regression analysis to build a shea yield model based on dendrometric, soil and land-use variables. We also compared potential shea yields based on farm household socio-economic characteristics and management practices derived from the survey data. Soil and land-use variables were the most important determinants of shea fruit yield. In terms of land use, shea trees growing on farmland plots exhibited the highest yields (i.e., fruit quantity and mass) while trees growing on Lixisols performed better than those of the other soil group. Contrary to our expectations, dendrometric parameters had weak relationships with fruit yield regardless of land-use and soil group. There is an inter-annual variability in fruit yield in both soil groups and land-use type. In addition to observed inter-annual yield variability, there was a high degree of variability in production among individual shea trees. Furthermore, household socioeconomic characteristics such as road accessibility, landholding size, and gross annual income influence shea fruit yield. The use of fallow areas is an important land management practice in the study area that influences both conservation and shea yield.",
           homepage = "https://doi.org/10.1371/journal.pone.0190234",
           date = dmy("29-10-2020"),
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
