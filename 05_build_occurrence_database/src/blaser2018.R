# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://doi.org/10.1038/s41893-018-0062-8
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : crop, agroforest
# ----

thisDataset <- "Blaser2018"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, "10.1038_s41893-018-0062-8-citation.ris"))

# data_path_cmpr <- paste0(dir_input, "")
# unzip(exdir = dir_input, zipfile = data_path_cmpr)
# untar(exdir = dir_input, tarfile = data_path_cmpr)

data_path <- paste0(dir_input, "Blaser_etal_2018_NatureSustainability_GIS_Coordinates.xlsx")
data <- read_excel(path = data_path)


message(" --> normalizing data")
#
# temp <- data %>%
#   .[-1] %>%
#   na.omit() %>%
#   filter(Latitude != "NA") %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "areal",
#     country = "Ghana",
#     x = as.numeric(Longitude),
#     y = as.numeric(Latitude),
#     geometry = NA,
#     epsg = 4326,
#     area = 900,
#     date = NA,
#     # year = "2015_2016_2017",
#     externalID = paste0(Site,"_", Type),
#     externalValue = "cocoa beans",
#     irrigated = FALSE,
#     presence = FALSE,
#     sample_type = "field",
#     collector = "expert",
#     purpose = "study") %>%
#   separate_rows(year, sep = "_") %>%
#   mutate(year = as.numeric(year)) %>%
#   select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
#          externalID, externalValue, irrigated, presence,
#          sample_type, collector, purpose, everything())
#
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
           description = "Meeting demands for agricultural production while maintaining ecosystem services, mitigating and adapting to climate change and conserving biodiversity will be a defining challenge of this century. Crop production in agroforests is being widely implemented with the expectation that it can simultaneously meet each of these goals. But trade-offs are inherent to agroforestry and so unless implemented with levels of canopy cover that optimize these trade-offs, this effort in climate-smart, sustainable intensification may simply compromise both production and ecosystem services. By combining simultaneous measurements of production, soil fertility, disease, climate variables, carbon storage and species diversity along a shade-tree cover gradient, here we show that low-to-intermediate shade cocoa agroforests in West Africa do not compromise production, while creating benefits for climate adaptation, climate mitigation and biodiversity. As shade-tree cover increases above approximately 30%, agroforests become increasingly less likely to generate win–win scenarios. Our results demonstrate that agroforests cannot simultaneously maximize production, climate and sustainability goals but might optimise the trade-off between these goals at low-to-intermediate levels of cover.",
           homepage = "https://doi.org/10.1038/s41893-018-0062-8",
           date = ymd("2020-11-02"),
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
