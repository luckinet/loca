# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://doi.org/10.1594/PANGAEA.777749
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : forest, tropical montane cloud forest
# ----

thisDataset <- "Bücker2010"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, "FOR816_macros.bib"))

# data_path_cmpr <- paste0(dir_input, "")
# unzip(exdir = dir_input, zipfile = data_path_cmpr)
# untar(exdir = dir_input, tarfile = data_path_cmpr)

data_path <- paste0(dir_input, "FOR816_macros.tab")
data <- read_tsv(file = data_path, skip = 74)


message(" --> normalizing data")
# temp <- data %>%
#   separate(`Date/Time`, c("Date","Time"), sep = " ") %>%
#   distinct(Latitude, Longitude, `Land use`, .keep_all = TRUE) %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "point",
#     country = "Ecuador",
#     x = Longitude,
#     y = Latitude,
#     geometry = NA,
#     epsg = 4326,
#     area = NA_real_,
#     date = ymd(`Date`),
#     externalID = `Sample label (the first two digits denote t...)`,
#     externalValue = `Land use`,
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
           description = "Despite the importance of tropical montane cloud forest streams, studies investigating aquatic communities in these regions are rare and knowledge on the driving factors of community structure is missing. The objectives of this study therefore were to understand how land-use influences habitat structure and macroinvertebrate communities in cloud forest streams of southern Ecuador. We evaluated these relationships in headwater streams with variable land cover, using multivariate statistics to identify relationships between key habitat variables and assemblage structure, and to resolve differences in composition among sites. Results show that shading intensity, substrate type and pH were the environmental parameters most closely related to variation in community composition observed among sites. In addition, macroinvertebrate density and partly diversity was lower in forested sites, possibly because the pH in forested streams lowered to almost 5 during spates. Standard bioindicator metrics were unable to detect the changes in assemblage structure between disturbed and forested streams. In general, our results indicate that tropical montane headwater streams are complex and heterogeneous ecosystems with low invertebrate densities. We also found that some amount of disturbance, i.e. patchy deforestation, can lead at least initially to an increase in macroinvertebrate taxa richness of these streams.",
           homepage = "https://doi.org/10.1594/PANGAEA.777749",
           date = ymd("2021-09-14"),
           license = "https://creativecommons.org/licenses/by-nc-sa/3.0/",
           ontology = path_onto_odb)

# matches <- tibble(new = c(unique(data$`Land use`)),
#                   old = c("Permanent grazing", "Undisturbed Forest", NA, "Naturally Regenerating Forest"))

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
