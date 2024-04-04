# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://nsidc.org/data/NSIDC-0298/versions/1
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : grassland, soil moisture
# ----

thisDataset <- "Bosch2008"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- bibentry(
  bibtype = "misc",
  title = "SMEX03 Vegetation Data: Georgia, Version 1",
  author = as.person("D. Bosch [aut], L. Marshall [aut], D. Rowland [aut], J. Jacobs [aut]"),
  year = "2008",
  organization = "NASA National Snow and Ice Data Center Distributed Active Archive Center",
  address = "Boulder, Colorado USA",
  doi = "https://doi.org/10.5067/UAPN8GAYSU83",
  url = "https://nsidc.org/data/NSIDC-0298/versions/1",
  type = "data set"
)

data_path <- paste0(dir_input, "/GA_SMEX03_vegetation_raw.txt")
data <- read_tsv(file = data_path, skip =  1)


message(" --> normalizing data")
# data <- data[-1,]
# data <- data %>%
#   mutate_if(is.double,~na_if(.,-99.000)) %>%
#   filter(!is.na(Longitude) | !is.na(Latitude)) %>%
#   distinct(Site, Crop, Date, Latitude, Longitude, .keep_all = T)
# temp <- data %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "point",
#     country = "United States",
#     x = Longitude,
#     y = Latitude,
#     geometry = NA,
#     epsg = 4326,
#     area = NA_real_,
#     date = mdy(Date),
#     externalID = Site,
#     externalValue = Crop,
#     irrigated = NA,
#     presence = TRUE,
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
           description = "This data set includes data collected over the Soil Moisture Experiment 2003 (SMEX03) area of Georgia, USA.",
           homepage = "https://nsidc.org/data/NSIDC-0298/versions/1",
           date = ymd("2021-09-13"),
           license = _INSERT,
           ontology = path_onto_odb)

# matches <- tibble(new = c(unique(data$Crop)),
#                   old = c("cotton", "peanut", "Permanent grazing", "cotton"))
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
