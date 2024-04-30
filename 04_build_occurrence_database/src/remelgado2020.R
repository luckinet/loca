# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://doi.org/10.1038/s41597-020-00591-2, https://doi.org/10.6084/m9.figshare.12047478
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

thisDataset <- "Remelgado2020"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, "10.1038_s41597-020-00591-2-citation.ris"))

# data_path_cmpr <- paste0(dir_input, "")
# unzip(exdir = dir_input, zipfile = data_path_cmpr)
# untar(exdir = dir_input, tarfile = data_path_cmpr)

data_path <- paste0(dir_input, "CAWa_CropType_samples.shp")
data <- st_read(dsn = data_path) %>%
  as_tibble()


message(" --> normalizing data")

# sf_use_s2(FALSE)
# temp <- data %>% %>%
#   separate_rows(label_1, sep = "-")
#   st_make_valid(data) %>%
#   st_centroid() %>%
#   mutate(
#     x = st_coordinates(.)[,1],
#     y = st_coordinates(.)[,2]
#   ) %>%
#   select(x,y,sampler) %>%
#   as.tibble()
# sf_use_s2(TRUE)
#
# data <- bind_cols(data, temp)
#
# temp <- data %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "areal",
#     country = country,
#     x = x,
#     y = y,
#     geometry = geometry...9,
#     epsg = 4326,
#     area = area...8,
#     date = ymd(date),
#     externalID = NA_character_,
#     externalValue = label_1,
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
           description = "Land cover is a key variable in the context of climate change. In particular, crop type information is essential to understand the spatial distribution of water usage and anticipate the risk of water scarcity and the consequent danger of food insecurity. This applies to arid regions such as the Aral Sea Basin (ASB), Central Asia, where agriculture relies heavily on irrigation. Here, remote sensing is valuable to map crop types, but its quality depends on consistent ground-truth data. Yet, in the ASB, such data are missing. Addressing this issue, we collected thousands of polygons on crop types, 97.7% of which in Uzbekistan and the remaining in Tajikistan. We collected 8,196 samples between 2015 and 2018, 213 in 2011 and 26 in 2008. Our data compile samples for 40 crop types and is dominated by “cotton” (40%) and “wheat”, (25%). These data were meticulously validated using expert knowledge and remote sensing data and relied on transferable, open-source workflows that will assure the consistency of future sampling campaigns.",
           homepage = "https://doi.org/10.1038/s41597-020-00591-2, https://doi.org/10.6084/m9.figshare.12047478",
           date = ymd("2021-09-14"),
           license = _INSERT,
           ontology = path_onto_odb)

# newConcepts <- tibble(target = c("cotton", "wheat", NA,
#                                  "Tree orchards", "rice", "VEGETABLES",
#                                  "maize", "alfalfa", "melon",
#                                  "Grapes", "Fallow", "sorghum",
#                                  NA, "soybean", "barley",
#                                  "carrot", "potato", "carrot",
#                                  "cabbage", "onion", "bean",
#                                  "sunflower", "tomato", "oat",
#                                  "potato", "pumpkin"),
#                       new = unique(data$label_1),
#                       class = c("commodity", "commodity", NA,
#                                 "land-use", "commodity", "group",
#                                 "commodity", "commodity", "commodity",
#                                 "group", "land-use", "commodity",
#                                 NA, "commodity", "commodity",
#                                 "commodity", "commodity", "commodity",
#                                 "commodity", "commodity", "commodity",
#                                 "commodity", "commodity", "commodity",
#                                 "commodity", "commodity"
#                       ),
#                       description = "",
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
