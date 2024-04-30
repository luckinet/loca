# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://doi.org/10.5067/XCGVUPGKER17
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : crop, general
# ----

thisDataset <- "Anderson2003"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")


bib <- bibentry(
  bibtype = "misc",
  title = "SMEX02 Watershed Vegetation Sampling Data, Walnut Creek, Iowa, Version 1",
  author = as.person("M. Anderson [aut]"),
  year = "2003",
  organization = "NASA National Snow and Ice Data Center Distributed Active Archive Center",
  address = "Boulder, Colorado USA",
  doi = "https://doi.org/10.5067/XCGVUPGKER17",
  url = "https://nsidc.org/data/NSIDC-0187/versions/1",
  type = "data set"
)

data_path <- paste0(dir_input, "smex02_wc_vegdata.xls")
coord <- read_excel(path = data_path, skip = 1, sheet = 1)
data <- read_excel(path = data_path, sheet = 2)

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

# a <- coord %>%
#   st_as_sf(coords = c("Easting", "Northing"), crs = 26915) %>% st_transform(4326) %>%
#   st_coordinates() %>%
#   as_tibble()
# coord <- cbind(coord, a) %>% select(X,Y,Site,Location,Crop)
#
# data <- data |>  %>%
#   na.omit()
# temp <- inner_join(data, coord, by = c("Site" = "Site", "Loc" = "Location")) %>%
#   separate(Date, c("year","month","day"), sep="-") %>%
#   mutate_if(is.character, ~na_if(., -999)) %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "point",
#     country = "United States",
#     x = X,
#     y = Y,
#     geometry = NA,
#     epsg = 4326,
#     area = NA_real_,
#     date = NA,
#     # year = as.numeric(year),
#     # month = as.numeric(month),
#     # day = as.integer(day),
#     externalID = NA_character_,
#     externalValue = Crop.x,
#     irrigated = FALSE,
#     presence = TRUE,
#     sample_type = "field",
#     collector = "expert",
#     purpose = "study") %>%
#   select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
#          externalID, externalValue, irrigated, presence,
#          sample_type, collector, purpose, everything())

temp <- reorganise(schema = schema_INSERT, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "This data set contains vegetation parameters as part of the Soil Moisture Experiment 2002 (SMEX02).",
           homepage = "https://doi.org/10.5067/XCGVUPGKER17",
           date = dmy("13-01-2022"),
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
