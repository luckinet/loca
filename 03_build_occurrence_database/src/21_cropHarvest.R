# script arguments ----
#
thisDataset <- "cropHarvest"
description <- "CropHarvest is an open source remote sensing dataset for agriculture with benchmarks. It collects data from a variety of agricultural land use datasets and remote sensing products."
url <- "https://doi.org/ https://github.com/nasaharvest/cropharvest"
licence <- "CC-BY-SA-4.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "cropHarvest.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("17-09-2021"),
           type = "dynamic",
           licence = licence,
           contact = "see repository maintainer",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- st_read(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "labels.geojson"))


# harmonise data ----
#
data <- data %>%
  filter(st_geometry_type(data) == "MULTIPOLYGON") %>%
  st_cast("POLYGON") %>%
  bind_rows(data %>% filter(st_geometry_type(data) == "POLYGON")) %>%
  st_boundary() %>%
  st_centroid() %>%
  bind_rows(data %>% filter(st_geometry_type(data) %in% c("POINT", "MULTIPOINT"))) %>%
  st_cast("POINT")

centroid <- data  %>%
  st_coordinates() %>%
  as_tibble()

temp <- data %>%
  as_tibble() %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = dataset,
    x = centroid$X,
    y = centroid$Y,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = dmy(collection_date),
    externalID = NA_character_,
    externalValue = label,
    irrigated = NA,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "validation") %>%
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

# matches <- tibble(new = unique(data$label),
#                   old = c(NA, "Cerrado", "Permanent grazing", "coffee", "Fallow", "Temporary grazing", NA, "eucalyptus",
#                           "Permanent grazing", "cotton", "wheat", "rice", "Tree orchards", "alfalfa", "maize", "grape",
#                           "cassava", "sorghum", "bean", "peanut", "Fallow", "millet", "tomato", "sugarcane",
#                           "sweet potato", "banana", "soybean", "cabbage", "bean", "sunflower", "string bean", "safflower",
#                           "sorghum", "maize", "oil palm", "potato", "peanut", "barley", "Leguminous crops", "wheat",
#                           "maize", "Fallow", "Permanent grazing", "barley", "Fallow", "barley", "rapeseed", "potato",
#                           "Fallow", "clover", "Temporary grazing", "Temporary grazing", "sugarbeet", "alfalfa", "linseed", "Temporary grazing",
#                           NA, "pea", "triticale", "soybean", "oat", "Tree orchards", "Temporary grazing", "onion",
#                           "", "", "", "", "", "", "", "",
#                           "", "", "", "", "", "", "", "",
#                           "", "", "", "", "", "", "", "",
#                           "", "", "", "rye", "", "", "", "",
#                           "", "", "", "", "", "", "", "",
#                           "Root or Bulb vegetables", "", "", "", "", "", "", "",
#                           "", "", "", "", "", "", "", "",
#                           "", "", "", "", "", "", "", "",
#                           "", "", "", "", "", "", "", "",
#                           "", "", "", "", "", "", "", "",
#                           "", "", "", "", "celery", "", "", "",
#                           "", "", "", "", "", "", "", "",
#                           "bean", "", "", "", "", "", "", "",
#                           "", "", "", "", "", "", "", "melon",
#                           "", "", "", "", "", "", "", "",
#                           "", "", "", "", "", "", "", "",
#                           "", "", "", "", "", "Medicinal crops", "", "Protective cover",
#                           "banana", "", "", "sugarcane", "sugarcane", "banana", "avocado", "",
#                           "banana", "", "", "", "", "", "banana", "banana",
#                           "banana", "banana", "", "", "peanut", "bean", "potato", "sesame",
#                           "WETLANDS", "Herbaceous associations", "", "Shrubland", "", "Permanent grazing", "", "CEREALS",
#                           "Barley", "maize", "Permanent grazing", "wheat", "soybean", "Forests", NA, "barley",
#                           "rapeseed", "wheat", "Permanent grazing", "Woody plantation", "Protective cover", "rye", "Permanent grazing", "clover",
#                           "Shrubland", NA, "Fallow", "Herbaceous associations", "Open spaces with little or no vegetation", "WATER BODIES", "oat", "Coniferous Forest",
#                           "clover", "Broad-leaved Forest", "clover", "sunflower", "Grass and fodder crops", "bean", "apple", "VEGETABLES",
#                           "raspberry", "FRUIT", "strawberry", "onion", "broccoli", "cauliflower", "pea", "pea",
#                           "sugarbeet", "ginseng", "rye", "cherry", "cucumber", "tomato", "squash", "carrot",
#                           "tobacco", "asparagus", "Other crops", "lettuce", "pumpkin", "brussels sprout", "lavendar", "maize",
#                           "peach", "pepper", "pear", "miscanthus", "", "blueberry", "broad bean", "Mixed Forest",
#                           "hop", "buckwheat", "rye", NA, "blueberry", "triticale", "Permanent grazing", "linseed",
#                           "Grass and fodder crops", "", "plum", "apricot", "barley", "clover", "Wheat", "Grass and fodder crops",
#                           "sugarbeet", "triticale", "wheat", "eggplant", "blueberry", "cranberry", "mustard", "hemp",
#                           "raspberry", "Other stimulants", "Other stimulants", NA, "hazelnut", "Other vegetables", "Treenuts", "Temporally Unstocked Forest",
#                           "CEREALS", NA, "Oilseed crops", "Leguminous crops", "triticale", "poplar", "celery", "honeyberry",
#                           "walnut", "Berries", "Open spaces with little or no vegetation", "NUTS", "wheat", "BIOENERGY CROPS", "artichoke", "Grass and fodder crops",
#                           "vetch", "lentil", "quinoa", "Tree orchards"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
