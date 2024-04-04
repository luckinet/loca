# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://doi.org/10.1016/j.foreco.2021.119126
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : forest, subtropical
# ----

thisDataset <- "Bordin2021"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, "bordin.bib"))

data_path <- paste0(dir_input, "forestPlots_Bordin.xlsx")
data <- read_csv(file = data_path)

yearArea <-  read_xlsx(paste0(dir_input, "plotArea.xlsx")) %>%
  rename(site = Site) %>%
  left_join(., read_xlsx(paste0(dir_input, "data_years.xlsx")), by = "site")

data <- left_join(data, yearArea, by = "site") %>%
  distinct(long, lat, forest_type, year, .keep_all = TRUE)

message(" --> normalizing data")
# temp <- data %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "areal",
#     country = "Brazil",
#     x = long,
#     y = lat,
#     geometry = NA,
#     epsg = 4326,
#     area = as.numeric(`Sampled area (ha)`)*10000,
#     date = ymd(paste0(year, "-01-01")),
#     externalID = site,
#     externalValue = forest_type,
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
           description = "Subtropical forests certainly contribute to terrestrial global carbon storage, but we have limited understanding about the relative amounts and of the drivers of above-ground biomass (AGB) variation in their region. Here we assess the spatial distribution and drivers of AGB in 119 sites across the South American subtropical forests. We applied a structural equation modelling approach to test the causal relationships between AGB and environmental (climate and soil), structural (proportion of large-sized trees) and community (functional and species diversity and composition) variables. The AGB on subtropical forests is on average 246 Mg ha−1. Biomass stocks were driven directly by temperature annual range and the proportion of large-sized trees, whilst soil texture, community mean leaf nitrogen content and functional diversity had no predictive power. Temperature annual range had a negative effect on AGB, indicating that communities under strong thermal amplitude across the year tend to accumulate less AGB. The positive effect of large-sized trees indicates that mature forests are playing a key role in the long-term persistence of carbon storage, as these large trees account for 64% of total biomass stored in these forests. Our study reinforces the importance of structurally complex subtropical forest remnants for maximising carbon storage, especially facing future climatic changes predicted for the region.",,
           homepage = "https://doi.org/10.1016/j.foreco.2021.119126",
           date = ymd("2021-09-13"),
           license = _INSERT,
           ontology = path_onto_odb)

# matches <- tibble(new = c(data$forest_type),
#                   old = "Undisturbed Forest")

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
