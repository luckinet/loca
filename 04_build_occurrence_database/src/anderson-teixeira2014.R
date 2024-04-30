# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://doi.org/10.1111/gcb.12712
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : forest
# ----

thisDataset <- "Anderson-Teixeira2014"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, "pericles_1365248621.ris"))

data_path <- paste0(dir_input, "luquillo_tree6_1ha.rda")
load(file = data_path)
data <- luquillo_tree6_1ha


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
#     type = "point",
#     country = NA_character_,
#     x = gx,
#     y = gy,
#     geometry = NA,
#     epsg = 4326,
#     area = NA_real_,
#     date = NA,
#     # year = year(ExactDate),
#     # month = month(ExactDate),
#     # day = day(ExactDate),
#     externalID = as.character(treeID),
#     externalValue = "Naturally Regenerating Forest", # clarificatian: "The sites are generally in old-growth or mature secondary forests and are commonly among the most intact, biodiverse, and well-protected forests within their region. They are subjected to a range of natural disturbances (Table 1), and a number of sites have experienced significant natural disturbances in recent years (e.g., fire at Yosemite, typhoons at Palanan). In addition, most sites have experienced some level of anthropogenic disturbance (discussed below; Table S5)."
#     irrigated = FALSE,
#     presence = FALSE,
#     sample_type = "field",
#     collector = "expert",
#     purpose = "monitoring") %>%
#   select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
#          externalID, externalValue, irrigated, presence,
#          sample_type, collector, purpose, everything())

temp <- reorganise(schema = schema_INSERT, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "Global change is impacting forests worldwide, threatening biodiversity and ecosystem services including climate regulation. Understanding how forests respond is critical to forest conservation and climate protection. This review describes an international network of 59 long-term forest dynamics research sites (CTFS-ForestGEO) useful for characterizing forest responses to global change. Within very large plots (median size 25 ha), all stems ≥1 cm diameter are identified to species, mapped, and regularly recensused according to standardized protocols. CTFS-ForestGEO spans 25°S–61°N latitude, is generally representative of the range of bioclimatic, edaphic, and topographic conditions experienced by forests worldwide, and is the only forest monitoring network that applies a standardized protocol to each of the world's major forest biomes. Supplementary standardized measurements at subsets of the sites provide additional information on plants, animals, and ecosystem and environmental variables. CTFS-ForestGEO sites are experiencing multifaceted anthropogenic global change pressures including warming (average 0.61 °C), changes in precipitation (up to ±30% change), atmospheric deposition of nitrogen and sulfur compounds (up to 3.8 g N m−2 yr−1 and 3.1 g S m−2 yr−1), and forest fragmentation in the surrounding landscape (up to 88% reduced tree cover within 5 km). The broad suite of measurements made at CTFS-ForestGEO sites makes it possible to investigate the complex ways in which global change is impacting forest dynamics. Ongoing research across the CTFS-ForestGEO network is yielding insights into how and why the forests are changing, and continued monitoring will provide vital contributions to understanding worldwide forest diversity and dynamics in an era of global change.",
           homepage = "https://doi.org/10.1111/gcb.12712",
           date = dmy("30-01-2022"),
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
