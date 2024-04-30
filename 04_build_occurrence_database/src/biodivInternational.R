# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://doi.org/10.1007/s10722-015-0231-9
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

thisDataset <- "biodivInternational"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, "10.1007_s10722-015-0231-9-citation.ris"))

data_path1 <- paste0(dir_input, "export_1603813703.csv")
data_path2 <- paste0(dir_input, "export_1603813923.csv")
data_path3 <- paste0(dir_input, "export_1603813979.csv")

data <- read_csv(file = data_path1) %>%
  bind_rows(read_csv(file = data_path2)) %>%
  bind_rows(read_csv(file = data_path3))


message(" --> normalizing data")
# temp <- data %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "point",
#     country = tolower(Country_Name),
#     x = LONGITUDEdecimal,
#     y = LATITUDEdecimal,
#     geometry = NA,
#     epsg = 4326,
#     area = NA_real_,
#     date = paste0(year, "-", month, "-01"),
#     externalID = as.character(ID_SUB_MISSION),
#     externalValue = Speciestype,
#     irrigated = NA,
#     presence = TRUE,
#     sample_type = "field",
#     collector = "expert",
#     purpose = "study") %>%
#   select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
#          externalID, externalValue, irrigated, presence,
#          sample_type, collector, purpose, everything())
#
# temp <- data %>%
#   select(-End_Date) %>%
#   separate(Start_Date, sep = "/", into = c("year", "month")) %>%
#   mutate(month = replace(month, is.na(month), "01"))
#
# data <- data %>%
#   select(-Start_Date) %>%
#   separate(End_Date, sep = "/", into = c("year", "month")) %>%
#   mutate(month = replace(month, is.na(month), "01")) %>%
#   bind_rows(temp)

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
           description = "Studying temporal changes in genetic diversity depends upon the availability of comparable time series data. Plant genetic resource collections provide snapshots of the diversity that existed at the time of collecting and provide a baseline against which to compare subsequent observations.",
           homepage = "https://doi.org/10.1007/s10722-015-0231-9",
           date = ymd("2020-10-27"),
           license = _INSERT,
           ontology = path_onto_odb)

# newConcepts <- tibble(target = c("VEGETABLES", "Tree orchards", "Leguminous crops",
#                                  NA, "Spice crops", "Planted Forest",
#                                  "Oilseed crops", "Roots and Tubers", "Leguminous crops",
#                                  "CEREALS", NA, "Grass crops",
#                                  "Fibre crops", "Heterogeneous semi-natural areas", "Spice crops",
#                                  NA, NA, NA,
#                                  "Grass crops", "Herbaceous associations", "cocoa beans",
#                                  NA, "Other fodder crops", "FRUIT",
#                                  "Tree orchards", "SUGAR CROPS", "Medicinal crops",
#                                  NA, NA, NA),
#                       new = unique(data$Speciestype),
#                       class = c("group", "land-use", "class",
#                                 NA, "class", "land-use",
#                                 "class", "class", "class",
#                                 "group", NA, "class",
#                                 "class", "landcover", "class",
#                                 NA, NA, NA,
#                                 "class", "landcover", "commodity",
#                                 NA, "class", "group",
#                                 "class", "group", "class",
#                                 NA, NA, NA),
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
