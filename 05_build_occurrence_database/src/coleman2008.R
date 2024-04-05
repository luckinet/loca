# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://doi.org/10.5067/YVQTPSF4VZ9N, https://nsidc.org/data/NSIDC-0348/versions/1
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : vegetation
# ----

thisDataset <- "Coleman2008"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- bibentry(
  bibtype = "misc",
  title = "SMEX03 Vegetation Data: Alabama, Version 1",
  author = as.person("T. Coleman, T. Tsegaye, R. Metzl, M. Schamschula"),
  year = "2008",
  organization = "NASA National Snow and Ice Data Center Distributed Active Archive Center",
  address = "Boulder, Colorado USA",
  doi = "https://doi.org/10.5067/YVQTPSF4VZ9N",
  url = "https://nsidc.org/data/NSIDC-0348/versions/1",
  type = "data set"
)

# data_path_cmpr <- paste0(dir_input, "")
# unzip(exdir = dir_input, zipfile = data_path_cmpr)
# untar(exdir = dir_input, tarfile = data_path_cmpr)

data_path <- paste0(dir_input, "AL_SMEX03_vegetation.xls")
data <- read_excel(path = data_path)


message(" --> normalizing data")
# data <- data %>%
#   mutate_if(is.numeric,~na_if(.,-99)) %>%
#   filter(!is.na(`Latitude WGS84`) | !is.na(`Longitude WGS84`)) %>%
#   filter(!is.na(year)) %>%
#   distinct(`NA Crop`,`Latitude WGS84`,`Longitude WGS84`,.keep_all = TRUE)
#
# temp <- data %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "point",
#     country = "United States",
#     x = `Longitude WGS84`,
#     y = `Latitude WGS84`,
#     geometry = NA,
#     epsg = 4326,
#     area = NA_real_,
#     date = mdy(`Date (mm/dd/yyyy)`),
#     externalID = as.character(row_number()),
#     externalValue = `NA Crop`,
#     irrigated = FALSE,
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
           description = "This data set includes vegetation data collected over the Soil Moisture Experiment 2003 (SMEX03) area of northern Alabama, USA.",
           homepage = "https://doi.org/10.5067/YVQTPSF4VZ9N, https://nsidc.org/data/NSIDC-0348/versions/1",
           date = ymd(_INSERT),
           license = _INSERT,
           ontology = path_onto_odb)

# matches <- tibble(new = c(unique(data$`NA Crop`)),
#                   old = c("maize", "Permanent grazing", "Permanent grazing", "Temporary grazing", "soybean",
#                           "wheat", "wheat", "Permanent grazing", "cotton", "soybean", "Temporary grazing", "Permanent cropland",
#                           "Permanent grazing","Permanent grazing", NA))

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
