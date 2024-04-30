# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://doi.org/10.1111/btp.12546
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : forest, undisturbed
# ----

thisDataset <- "Capaverde2018"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, "pericles_1744742950.bib"))

# data_path_cmpr <- paste0(dir_input, "")
# unzip(exdir = dir_input, zipfile = data_path_cmpr)
# untar(exdir = dir_input, tarfile = data_path_cmpr)

data_path <- paste0(dir_input, "Bats_Ducke_data_metadata.xlsx")
data <- read_excel(path = data_path, sheet = 3)


message(" --> normalizing data")
# temp <- data %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "areal",
#     country = "Brazil",
#     x = LONG,
#     y = LAT,
#     geometry = NA,
#     epsg = 4326,
#     area = 250 * 40,
#     date = NA,
#     year = "2013_2014",
#     externalID = as.character(Plots),
#     externalValue = "Undisturbed Forest",
#     presence = FALSE,
#     sample_type = "field",
#     collector = "expert",
#     purpose = "study") %>%
#   separate_rows(year, sep = "_") %>%
#   mutate(year = ymd(paste0(year, "-01-01"))) %>%
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
           description = _INSERT,
           homepage = "The distribution patterns of animal species at local scales have been explained by direct influences of vegetation structure, topography, food distribution, and availability. However, these variables can also interact and operate indirectly on the distribution of species. Here, we examined the direct and indirect effects of food availability (fruits and insects), vegetation clutter, and elevation in structuring phyllostomid bat assemblages in a continuous terra firme forest in Central Amazonia. Bats were captured in 49 plots over 25-km² of continuous forest. We captured 1138 bats belonging to 52 species with 7056 net*hours of effort. Terrain elevation was the strongest predictor of species and guild compositions, and of bat abundance. However, changes in elevation were associated with changes in vegetation clutter, and availability of fruits and insects consumed by bats, which are likely to have had direct effects on bat assemblages. Frugivorous bat composition was more influenced by availability of food-providing plants, while gleaning-animalivore composition was more influenced by the structural complexity of the vegetation. Although probably not causal, terrain elevation may be a reliable predictor of bat-assemblage structure at local scales in other regions. In situations where it is not possible to collect local variables, terrain elevation can substitute other variables, such as vegetation structure, and availability of fruits and insects.",
           date = ymd("2021-08-11"),
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
