# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://portal.tern.org.au/slats-star-transects-field-sites/23207
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

thisDataset <- "ausCoverb"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- bibentry(bibtype =  "Misc",
                author = person("Department of Environment and Science"),
                year = 2022,
                title = "SLATS Star Transects - Australian field sites. Version 1.0.0. Terrestrial Ecosystem Research Network",
                organization = "Queensland Government",
                url = "https://portal.tern.org.au/slats-star-transects-field-sites/23207")

# data_path_cmpr <- paste0(dir_input, "")
# unzip(exdir = dir_input, zipfile = data_path_cmpr)
# untar(exdir = dir_input, tarfile = data_path_cmpr)

data_path <- paste0(dir_input, "star_transects.csv")
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


# data <- data %>%
#   mutate(ontology = paste(data$landuse, data$commod, sep="_"))
#
# temp <- data %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "areal",
#     country = NA_character_,
#     x = ref_x,
#     y = ref_y,
#     geometry = geom,
#     epsg = 4326,
#     area = 10000,
#     date = obs_time,
#     externalID = NA_character_,
#     externalValue = ontology,
#     irrigated = grepl("irrigated", site_desc),
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
           description = "The SLATS star transect field dataset has been compiled as a record of vegetative and non-vegetative fractional cover as recorded in situ according to the method described in Muir et al (2011). The datasets are a combination of vegetation fractions collected in three strata - non-woody vegetation including vegetative litter near the soil surface, woody vegetation less than 2 metres, and woody vegetation greater than 2 metres - at homogeneous areas of approximately 1 hectare. This dataset is compiled from a variety of sources, including available sites from the ABARES ground cover reference sites database.",
           homepage = "https://portal.tern.org.au/slats-star-transects-field-sites/23207",
           date = dmy("13-05-2022"),
           license = "https://creativecommons.org/licenses/by/4.0/",
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
