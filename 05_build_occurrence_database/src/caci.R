# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://open.canada.ca/data/en/dataset/503a3113-e435-49f4-850c-d70056788632
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : crop, general
# ----

thisDataset <- "caci"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- bibentry(bibtype = "Misc",
                title = "Annual Crop Inventory Ground Truth Data",
                publisher = "Agriculture and Agri-Food Canada",
                year = 2020)

data_path <- paste0(dir_input, _INSERT)
data <- read_csv(file = data_path)
data <- read_tsv(file = data_path)
data <- read_excel(path = data_path)
data <- read_parquet(file = data_path)
data <- st_read(dsn = data_path) %>% as_tibble()
# make sure that coordinates are transformed to EPSG:4326 (WGS84)

dataNames <- list.dirs(path = occurrenceDBDir, "00_incoming/", thisDataset)[-1]
data <- lapply(dataNames, st_read)
data <- bind_rows(data)

message(" --> normalizing data")
# temp <- data %>%
#   mutate(x = st_coordinates(.)[,1],
#          y = st_coordinates(.)[,2]) %>%
#   as.data.frame() %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "point",
#     country = "Canda",
#     x = NA_real_,
#     y = NA_real_,
#     geometry = geometry,
#     epsg = 4326,
#     area = NA_real_,
#     date = NA,
#     # year = year(DATE_COLL),
#     # month = month(DATE_COLL),
#     # day = day(DATE_COLL),
#     externalID = NA_character_,
#     externalValue = NOMTERRE,
#     irrigated = FALSE,
#     presence = TRUE,
#     sample_type = "field",
#     collector = "expert",
#     purpose = "validation") %>%
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
           description = "Beginning with the 2011 grow season, the Earth Observation Team of the Science and Technology Branch (STB) at Agriculture and Agri-Food Canada (AAFC) started collecting ground truth data via windshield surveys. This observation data is collected in support of the generation of an annual crop inventory digital map. These windshield surveys take place in provinces where AAFC does not have access to crop insurance data. The collection routes driven attempt to maximize not only the geographical distribution of observations but also to target unique or specialty crop types within a given region. Windshield surveys are mainly collected by the AAFC Earth Observation team (Ottawa) with the support of regional AAFC Research Centres (St John’s NL; Kentville NS; Charlottetown PE; Moncton NB; Guelph ON; Summerland BC). Support is also provided by provincial agencies in British Columbia, Ontario, and Prince Edward Island, and by contractors when needed.",
           homepage = "https://open.canada.ca/data/en/dataset/503a3113-e435-49f4-850c-d70056788632",
           date = ymd("2022-05-16"),
           license = "Open Government Licence - Canada",
           ontology = path_onto_odb)

# matches <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "caci_onotology.csv"))
# newConcept(new = c("beetroot", "celery",
#                    "goji berry", "haskap",
#                    "flax", "elderberry"),
#            broader = c("Root or Bulb vegetables", "Leafy or stem vegetables",
#                        "Berries", "Berries",
#                        "Fibre crops", "Berries"),
#            class = "commodity",
#            source = thisDataset)

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
