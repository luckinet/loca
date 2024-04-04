# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : https://doi.org/10.1016/0378-4290(91)90041-S
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : crop, wheat
# ----

thisDataset <- "Amir1991"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, "037842909190041S.bib"))

data_path <- paste0(dir_input, "Amir1991.csv")
data <- read_csv2(file = data_path)


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
#     country = "Israel",
#     y = 31.35,
#     x = 34.7,
#     geometry = NA,
#     epsg = 4326,
#     area = NA_real_,
#     date = NA,
#     externalID = NA_character_,
#     externalValue = commodities,
#     irrigated = NA,
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
           description = "The objective of this study was to evaluate management practices which may improve the water use efficiency (wue) of spring wheat (Triticum aestivum L.) in an arid Mediterranean-type environment. Multifactorial experiments were performed for ten years at Gilat in the Negev Desert of Israel, where the average annual rainfall was 231 ± 70 mm, all of which fell during the growing season (December to April), and an average growing-season Class-A pan evaporation of 504 ± 62 mm. Basic management treatments were: (1) continuous wheat, disk-tillage (CD); (2) continuous wheat, plowing-tillage (CP); (3) wheat after fallow, disking as preparative tillage (FD); and (4) wheat after fallow, plowing as preparative tillage (FP). Three additional continuous wheat disk-tillage treatments were examined for chemical control of soil pathogens and weed-control treatments. The experiment also included four nitrogen-level treatments (0, 5, 10, and 15 g N m−2) and two water regimes, one rainfed and the other fully irrigated. In both contrasting water regimes, grain-yield was not significantly influenced by preparative tillage treatments. Profitable grain yields (> 100 g m−2) and profitable response to nitrogen (> 4 g grain per g N added) were obtained with continuous wheat management in only five out of ten years, when the rainfall was above 250 mm. A highly significant increase in yield and wue for grain production, compared with CD management, was obtained for the same N and water regime, with the wheat-after-fallow management practice (FD). Profitable grain-yield was obtained with wheat-after-fallow management in nine out of ten years. In eight out of the ten years there was no plant-available stored soil water at sowing in FD management, and therefore the significant increase in wue for the ‘dry’ fallow treatment could not be ascribed to stored water. Water-use efficiency and productivity were similarly increased in the CD management by a broad-spectrum biocide applied to the soil, suggesting that yield increase after ‘dry’ fallow is through soil sanitation improvement. The significant increase in grain production in wheat after ‘dry’ fallow management resulted from a marked elevation in the transpiration/evapotranspiration ratio, due to a significant enhancement in root-length density. In rainy years when water supply increased above 250 mm, the advantage of the wheat after ‘dry’ fallow management disappeared. It is concluded that, under arid conditions, improvement of the root density by chemical, cultural or breeding techniques is a feasible strategy for counteracting limited water supply.",
           homepage = "https://doi.org/10.1016/0378-4290(91)90041-S",
           date = dmy("15-12-2021"),
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
