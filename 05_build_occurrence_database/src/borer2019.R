# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://doi.org/10.5061/dryad.c742372
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : grassland
# ----

thisDataset <- "Borer2019"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, "pericles_1461024822.ris"))

# data_path_cmpr <- paste0(dir_input, "")
# unzip(exdir = dir_input, zipfile = data_path_cmpr)
# untar(exdir = dir_input, tarfile = data_path_cmpr)

data_path <- paste0(dir_input, "sodium-resp-data-table.csv")
data <- read_csv(file = data_path)


message(" --> normalizing data")
# temp <- data %>%
#   distinct(latitude, longitude, year, .keep_all = T) %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "areal",
#     country = case_when(country == "US" ~ "United States of America",
#                         country == "AU" ~ "Australia",
#                         country == "PT" ~ "Portugal",
#                         country == "CA" ~ "Canada",
#                         country == "CH" ~ "Switzerland",
#                         country == "ZA" ~ "South Africa",
#                         country == "UK" ~ "united Kingdom"),
#     x = longitude,
#     y = latitude,
#     geometry = NA,
#     epsg = 4326,
#     area = NA_real_,
#     area = 25,
#     # year = year,
#     # month = NA_real_,
#     # day = NA_integer_,
#     externalID = NA_character_,
#     externalValue = "Permanent grazing",
#     irrigated = FALSE,
#     presence = FALSE,
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
           description = "Sodium is unique among abundant elemental nutrients, because most plant species do not require it for growth or development, whereas animals physiologically require sodium. Foliar sodium influences consumption rates by animals and can structure herbivores across landscapes. We quantified foliar sodium in 201 locally abundant, herbaceous species representing 32 families and, at 26 sites on four continents, experimentally manipulated vertebrate herbivores and elemental nutrients to determine their effect on foliar sodium. Foliar sodium varied taxonomically and geographically, spanning five orders of magnitude. Site‐level foliar sodium increased most strongly with site aridity and soil sodium; nutrient addition weakened the relationship between aridity and mean foliar sodium. Within sites, high sodium plants declined in abundance with fertilisation, whereas low sodium plants increased. Herbivory provided an explanation: herbivores selectively reduced high nutrient, high sodium plants. Thus, interactions among climate, nutrients and the resulting nutritional value for herbivores determine foliar sodium biogeography in herbaceous‐dominated systems.",
           homepage = "https://doi.org/10.5061/dryad.c742372",
           date = ymd("2022-06-01"),
           license = "https://creativecommons.org/publicdomain/zero/1.0",
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
