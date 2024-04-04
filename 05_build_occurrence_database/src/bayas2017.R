# ----
# geography : Global
# period    : 2016
# typology  :
#   - cover  : VEGETATED
#   - dynamic: Herbaceous
#   - use    : cropland
# features  : 203516
# data type : point
# doi/url   : https://doi.org/10.1594/PANGAEA.873912
# authors   : Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

thisDataset <- "bayas2017"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, "Crowdsource_cropland.bib"))

data_path <- paste0(input_dir, "loc_all.txt")

data <- read_tsv(file = data_path)


message(" --> normalizing data")
# uniqueDat <- data %>%
#   mutate(year = paste0("20", str_split(str_split(string = timestamp, pattern = " ")[[1]][[1]], pattern = "-")[[1]][3])) %>%
#   distinct(locationid, year) %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     country = NA_character_,
#     epsg = 4326,
#     area = NA_real_,
#     date = ymd(paste0(as.numeric(year), "-01-01")),
#     externalID = as.character(locationid),
#     externalValue = matches$new,
#     attr_1 = mean(sumcrop),
#     attr_1_typ = "cover",
#     irrigated = FALSE,
#     presence = TRUE,
#     sample_type = "visual interpretation",
#     collector = "citizen scientist",
#     purpose = "validation")
#
# temp <- data %>%
#   rename(date = "timestamp") %>%
#   group_by(locationid) %>%
#   summarise(x = unique(centroid_X),
#             y = unique(centroid_Y),
#             geometry = NA) %>%
#   left_join(uniqueDat, by = "locationid") %>%
#   mutate(fid = row_number(),
#          type = "point") %>%
#   select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
#          externalID, externalValue, irrigated, presence,
#          sample_type, collector, purpose, everything())

data <- data %>%
  mutate(obsID = row_number(), .before = 1)

other <- data %>%
  select(obsID, _INSERT)

schema_bayas2017 <-
  setFormat(header = 1L, decimal = _INSERT, thousand = _INSERT, na_values = _INSERT) %>%
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
  setIDVar(name = "irrigated", type = "l", columns = _INSERT) %>%
  setIDVar(name = "present", type = "l", columns = _INSERT) %>%
  setIDVar(name = "sample_type", value = _INSERT) %>%
  setIDVar(name = "collector", value = _INSERT) %>%
  setIDVar(name = "purpose", value = _INSERT) %>%
  setObsVar(name = "concept", type = "c", columns = _INSERT)

temp <- reorganise(schema = schema_bayas2017, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "A global reference dataset on cropland was collected through a crowdsourcing campaign implemented using Geo-Wiki. This reference dataset is based on a systematic sample at latitude and longitude intersections, enhanced in locations where the cropland probability varies between 25-75% for a better representation of cropland globally. Over a three week period, around 36K samples of cropland were collected. For the purpose of quality assessment, additional datasets are provided. One is a control dataset of 1793 sample locations that have been validated by students trained in image interpretation. This dataset was used to assess the quality of the crowd validations as the campaign progressed. Another set of data contains 60 expert or gold standard validations for additional evaluation of the quality of the participants. These three datasets have two parts, one showing cropland only and one where it is compiled per location and user. This reference dataset will be used to validate and compare medium and high resolution cropland maps that have been generated using remote sensing. The dataset can also be used to train classification algorithms in developing new maps of land cover and cropland extent",
           homepage = "https://doi.org/10.1594/PANGAEA.873912",
           date = ymd("2021-09-13"),
           license = "https://creativecommons.org/licenses/by/3.0/",
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

