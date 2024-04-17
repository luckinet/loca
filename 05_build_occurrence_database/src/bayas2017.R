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
# status    : done
# comment   : -
# ----

thisDataset <- "bayas2017"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, "Crowdsource_cropland.bib"))

data_path <- paste0(input_dir, "loc_all.txt")

data <- read_tsv(file = data_path)


message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1) |>
  separate_wider_delim(cols = "timestamp", delim = " ", names = "date", too_many = "drop") |>
  mutate(concept = "Cropland")

other <- data %>%
  select(obsID, sumcrop)

schema_bayas2017 <-
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", type = "i", columns = 1) %>%
  setIDVar(name = "externalID", columns = 2) %>%
  setIDVar(name = "open", type = "l", value = TRUE) %>%
  setIDVar(name = "type", value = "point") %>%
  setIDVar(name = "x", type = "n", columns = 6) %>%
  setIDVar(name = "y", type = "n", columns = 7) %>%
  setIDVar(name = "epsg", value = "4326") %>%
  setIDVar(name = "date", type = "D", columns = 4) %>%
  setIDVar(name = "irrigated", type = "l", value = FALSE) %>%
  setIDVar(name = "present", type = "l", value = TRUE) %>%
  setIDVar(name = "sample_type", value = "visual interpretation") %>%
  setIDVar(name = "collector", value = "citizen scientist") %>%
  setIDVar(name = "purpose", value = "validation") %>%
  setObsVar(name = "concept", type = "c", columns = 8)

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

