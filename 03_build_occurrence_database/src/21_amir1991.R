# script arguments ----
#
thisDataset <- "Amir1991"
description <- "The objective of this study was to evaluate management practices which may improve the water use efficiency (wue) of spring wheat (Triticum aestivum L.) in an arid Mediterranean-type environment. Multifactorial experiments were performed for ten years at Gilat in the Negev Desert of Israel, where the average annual rainfall was 231 ± 70 mm, all of which fell during the growing season (December to April), and an average growing-season Class-A pan evaporation of 504 ± 62 mm. Basic management treatments were: (1) continuous wheat, disk-tillage (CD); (2) continuous wheat, plowing-tillage (CP); (3) wheat after fallow, disking as preparative tillage (FD); and (4) wheat after fallow, plowing as preparative tillage (FP). Three additional continuous wheat disk-tillage treatments were examined for chemical control of soil pathogens and weed-control treatments. The experiment also included four nitrogen-level treatments (0, 5, 10, and 15 g N m−2) and two water regimes, one rainfed and the other fully irrigated. In both contrasting water regimes, grain-yield was not significantly influenced by preparative tillage treatments. Profitable grain yields (> 100 g m−2) and profitable response to nitrogen (> 4 g grain per g N added) were obtained with continuous wheat management in only five out of ten years, when the rainfall was above 250 mm. A highly significant increase in yield and wue for grain production, compared with CD management, was obtained for the same N and water regime, with the wheat-after-fallow management practice (FD). Profitable grain-yield was obtained with wheat-after-fallow management in nine out of ten years. In eight out of the ten years there was no plant-available stored soil water at sowing in FD management, and therefore the significant increase in wue for the ‘dry’ fallow treatment could not be ascribed to stored water. Water-use efficiency and productivity were similarly increased in the CD management by a broad-spectrum biocide applied to the soil, suggesting that yield increase after ‘dry’ fallow is through soil sanitation improvement. The significant increase in grain production in wheat after ‘dry’ fallow management resulted from a marked elevation in the transpiration/evapotranspiration ratio, due to a significant enhancement in root-length density. In rainy years when water supply increased above 250 mm, the advantage of the wheat after ‘dry’ fallow management disappeared. It is concluded that, under arid conditions, improvement of the root density by chemical, cultural or breeding techniques is a feasible strategy for counteracting limited water supply."
url <- "https://doi.org/10.1016/0378-4290(91)90041-S https://"
licence <- "CC-BY"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "037842909190041S.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("15-12-2021"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)

# read dataset ----
#
data <- read_csv2(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Amir1991.csv"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Israel",
    y = 31.35,
    x = 34.7,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = commodities,
    irrigated = NA,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated, presence,
         sample_type, collector, purpose, everything())


# harmonize with ontology ----
#
new_source(name = thisDataset,
           description = description,
           homepage = url,
           date = Sys.Date(),
           license = licence,
           ontology = ontoDir)

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)

# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
