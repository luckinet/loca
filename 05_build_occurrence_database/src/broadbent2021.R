# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://doi.org/10.5061/dryad.tmpg4f4v8
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : grassland, leaf-trait analysis
# ----

thisDataset <- "Broadbent2021"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, "pericles_1466823829.ris"))

# data_path_cmpr <- paste0(dir_input, "")
# unzip(exdir = dir_input, zipfile = data_path_cmpr)
# untar(exdir = dir_input, tarfile = data_path_cmpr)

data_path <- paste0(dir_input, "Broadbent_et_al_2020_GEB_Data.csv")
data <- read_csv(file = data_path)


message(" --> normalizing data")
# temp <- data %>%
#   distinct(year, latitude, longitude, .keep_all = T) %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "areal",
#     country = case_when(country == "AU" ~ "Australia",
#                         country == "PT" ~ "Portugal",
#                         country == "CA" ~ "Canada",
#                         country == "US" ~ "United States of America",
#                         country == "CH" ~ "Switzerland",
#                         country == "ZA" ~ "South Africa",
#                         country == "UK" ~ "Unitedd Kingdom",
#                         country == "DE" ~ "Germany"),
#     x = longitude,
#     y = latitude,
#     geometry = NA,
#     epsg = 4326,
#     area = 25,
#     date = NA,
#     # year = "2007_2008_2009_2010_2011_2012_2013_2014",
#     # month = NA_real_,
#     # day = NA_integer_,
#     externalID = NA_character_,
#     externalValue = "Herbaceous associations",
#     irrigated = FALSE,
#     presence = FALSE,
#     sample_type = "field",
#     collector = "expert",
#     purpose = "study") %>%
#   separate_rows(year, sep = "_") %>%
#   mutate(year = as.numeric(year),
#          fid = row_number()) %>%
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
           description = "Aim Nutrient enrichment is associated with plant invasions and biodiversity loss. Functional trait advantages may predict the ascendancy of invasive plants following nutrient enrichment but this is rarely tested. Here, we investigate 1) whether dominant native and non-native plants differ in important morphological and physiological leaf traits, 2) how their traits respond to nutrient addition, and 3) whether responses are consistent across functional groups. Location Australia, Europe, North America and South Africa Time period 2007 - 2014 Major taxa studied Graminoids and forbs Methods We focused on two types of leaf traits connected to resource acquisition: morphological features relating to light-foraging surfaces and investment in tissue (Specific Leaf Area, SLA) and physiological features relating to internal leaf chemistry as the basis for producing and utilizing photosynthate. We measured these traits on 503 leaves from 151 dominant species across 27 grasslands on four continents. We used an identical nutrient addition treatment of nitrogen (N), phosphorus (P) and potassium (K) at all sites. Sites represented a broad range of grasslands that varied widely in climatic and edaphic conditions. Results We found evidence that non-native graminoids invest in leaves with higher nutrient concentrations than native graminoids, particularly at sites where native and non-native species both dominate. We found little evidence that native and non-native forbs differed in the measured leaf traits. These results were consistent in natural soil fertility levels and nutrient enriched conditions, with dominant species responding similarly to nutrient addition regardless of whether they were native or non-native. Main conclusions Our work identifies the inherent physiological trait advantages that can be used to predict non-native graminoid establishment; potentially because of higher efficiency at taking up crucial nutrients into their leaves. Most importantly, these inherent advantages are already present at natural soil fertility levels and are maintained following nutrient enrichment.",
           homepage = "https://doi.org/10.5061/dryad.tmpg4f4v8",
           date = ymd("2020-06-02"),
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
