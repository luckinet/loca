h# script arguments ----
#
thisDataset <- "cropHarvest"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "cropHarvest.bib")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "CropHarvest is an open source remote sensing dataset for agriculture with benchmarks. It collects data from a variety of agricultural land use datasets and remote sensing products.",
           url = "https://github.com/nasaharvest/cropharvest",
           download_date = "2021-09-17",
           type = "dynamic",
           licence = " CC-BY-SA-4.0",
           contact = "see repository maintainer",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- st_read(paste0(thisPath, "labels.geojson"))


# manage ontology ---
#
i <- 8
matches[c((i*8+1) : (i*8+8)),]
matches <- tibble(new = unique(data$label),
                  old = c(NA, "Cerrado", "Permanent grazing", "coffee", "Fallow", "Temporary grazing", NA, "eucalyptus",
                          "Permanent grazing", "cotton", "wheat", "rice", "Tree orchards", "alfalfa", "maize", "grape",
                          "cassava", "sorghum", "bean", "peanut", "Fallow", "millet", "tomato", "sugarcane",
                          "sweet potato", "banana", "soybean", "cabbage", "bean", "sunflower", "string bean", "safflower",
                          "sorghum", "maize", "oil palm", "potato", "peanut", "barley", "Leguminous crops", "wheat",
                          "maize", "Fallow", "Permanent grazing", "barley", "Fallow", "barley", "rapeseed", "potato",
                          "Fallow", "clover", "Temporary grazing", "Temporary grazing", "sugarbeet", "alfalfa", "linseed", "Temporary grazing",
                          NA, "pea", "triticale", "soybean", "oat", "Tree orchards", "Temporary grazing", "onion",
                          "", "", "", "", "", "", "", "",
                          "", "", "", "", "", "", "", "",
                          "", "", "", "", "", "", "", "",
                          "", "", "", "rye", "", "", "", "",
                          "", "", "", "", "", "", "", "",
                          "Root or Bulb vegetables", "", "", "", "", "", "", "",
                          "", "", "", "", "", "", "", "",
                          "", "", "", "", "", "", "", "",
                          "", "", "", "", "", "", "", "",
                          "", "", "", "", "", "", "", "",
                          "", "", "", "", "celery", "", "", "",
                          "", "", "", "", "", "", "", "",
                          "bean", "", "", "", "", "", "", "",
                          "", "", "", "", "", "", "", "melon",
                          "", "", "", "", "", "", "", "",
                          "", "", "", "", "", "", "", "",
                          "", "", "", "", "", "Medicinal crops", "", "Protective cover",
                          "banana", "", "", "sugarcane", "sugarcane", "banana", "avocado", "",
                          "banana", "", "", "", "", "", "banana", "banana",
                          "banana", "banana", "", "", "peanut", "bean", "potato", "sesame",
                          "WETLANDS", "Herbaceous associations", "", "Shrubland", "", "Permanent grazing", "", "CEREALS",
                          "Barley", "maize", "Permanent grazing", "wheat", "soybean", "Forests", NA, "barley",
                          "rapeseed", "wheat", "Permanent grazing", "Woody plantation", "Protective cover", "rye", "Permanent grazing", "clover",
                          "Shrubland", NA, "Fallow", "Herbaceous associations", "Open spaces with little or no vegetation", "WATER BODIES", "oat", "Coniferous Forest",
                          "clover", "Broad-leaved Forest", "clover", "sunflower", "Grass and fodder crops", "bean", "apple", "VEGETABLES",
                          "raspberry", "FRUIT", "strawberry", "onion", "broccoli", "cauliflower", "pea", "pea",
                          "sugarbeet", "ginseng", "rye", "cherry", "cucumber", "tomato", "squash", "carrot",
                          "tobacco", "asparagus", "Other crops", "lettuce", "pumpkin", "brussels sprout", "lavendar", "maize",
                          "peach", "pepper", "pear", "miscanthus", "", "blueberry", "broad bean", "Mixed Forest",
                          "hop", "buckwheat", "rye", NA, "blueberry", "triticale", "Permanent grazing", "linseed",
                          "Grass and fodder crops", "", "plum", "apricot", "barley", "clover", "Wheat", "Grass and fodder crops",
                          "sugarbeet", "triticale", "wheat", "eggplant", "blueberry", "cranberry", "mustard", "hemp",
                          "raspberry", "Other stimulants", "Other stimulants", NA, "hazelnut", "Other vegetables", "Treenuts", "Temporally Unstocked Forest",
                          "CEREALS", NA, "Oilseed crops", "Leguminous crops", "triticale", "poplar", "celery", "honeyberry",
                          "walnut", "Berries", "Open spaces with little or no vegetation", "NUTS", "wheat", "BIOENERGY CROPS", "artichoke", "Grass and fodder crops",
                          "vetch", "lentil", "quinoa", "Tree orchards"))
# getConcept(label_en = matches$old, missing = TRUE)

newConcept(new = c("Cerrado", "Coniferous Forest", "Broad-leaved Forest", "Mixed Forest"),
           broader = c("Other Wooded Areas", "Forests", "Forests", "Forests"),
           class = "forest type",
           source = thisDataset)

newConcept(new = c("clover", "honeyberry", "celery"),
           broader = c("Grass and fodder crops", "Berries", "Leafy or stem vegetables"),
           class = "commodity",
           source = thisDataset)

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = ., external = matches$new, match = "close",
             source = thisDataset, certainty = 3)


# harmonise data ----
#
temp <- data %>%
  filter(st_geometry_type(data) == "MULTIPOLYGON") %>%
  st_cast("POLYGON") %>%
  bind_rows(data %>% filter(st_geometry_type(data) == "POLYGON")) %>%
  st_boundary() %>%
  st_centroid() %>%
  bind_rows(data %>% filter(st_geometry_type(data) %in% c("POINT", "MULTIPOINT"))) %>%
  st_cast("POINT")

centroid <-temp  %>%
  st_coordinates() %>%
  as_tibble()

temp <- temp %>%
  as_tibble() %>%
  mutate(
    fid = row_number(),
    type = "point",
    x = centroid$X,
    y = centroid$Y,
    year = year(collection_date),
    month = month(collection_date),
    day = day(collection_date),
    datasetID = thisDataset,
    country = dataset,
    irrigated = NA,
    area = NA_real_,
    presence = TRUE,
    externalID = NA_character_,
    externalValue = label,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "validation",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
