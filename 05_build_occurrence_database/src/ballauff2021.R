# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://doi.org/10.1016/j.soilbio.2021.108140
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

thisDataset <- "Ballauff2021"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- bibentry(
  bibtype = "misc",
  title = "Belowground fungi, soil, and root chemistry in tropical landuse systems",
  author = as.person("Andrea Polle [aut], Johannes Ballauff [aut]"),
  year = "2021",
  organization = "Dryad",
  address = "Göttingen, Germany",
  doi = "https://doi.org/10.5061/dryad.7h44j0zrd",
  url = "https://datadryad.org/stash/dataset/doi:10.5061/dryad.7h44j0zrd",
  type = "data set"
)

# data_path_cmpr <- paste0(dir_input, "")
# unzip(exdir = dir_input, zipfile = data_path_cmpr)
# untar(exdir = dir_input, tarfile = data_path_cmpr)

data_path <- paste0(dir_input, "Environmental_data.xlsx")
data <- read_excel(path = data_path, skip = 1)


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

# temp <- data %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "areal",
#     country = "Indonesia",
#     x = Longitude,
#     y = Latitude,
#     geometry = NA,
#     epsg = 4326,
#     area = 2500,
#     date = NA,
#     # year = 2016,
#     # month = 11,
#     # day = NA_integer_,
#     externalID = `Plot ID`,
#     externalValue = landuse,
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
           description = "The data were collected in the humid tropical climate on Sumatra (Indonesia) in rain forests, in jungle rubber (rubber planted into forests), in rubber, and oil palm plantations. A total of 44 plots were sampled. The data set consists of two tables. The table Environmental_data contains plot information, geographic coordinates of the plots, and data on soil properties (pH, nitrogen, carbon, C/N, potassium, calcium, magnesium, manganese, iron, phosporous, soil resource index, soil PC1, soil PC2) and on root traits (biomass, nitrogen, carbon, C/N, potassium, calcium, magnesium, manganese, iron, phosporous, root resource index, root PC1, soil PC, root vitality). Table 2 contain abundance data (OTU counts) for fungi associated with roots or with soil and their phylogenetic and functional assignments.",
           homepage = "https://doi.org/10.1016/j.soilbio.2021.108140",
           date = ymd("2022-01-14"),
           license = "https://creativecommons.org/publicdomain/zero/1.0",
           ontology = path_onto_odb)

# matches <- tibble(new = c(unique(data$landuse)),
#                   old = c("Naturally Regenerating Forest", "natural rubber", "oil palm", "natural rubber"))
#
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
