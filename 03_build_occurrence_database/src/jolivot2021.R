# script arguments ----
#
thisDataset <- "Jolivot2021"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "essd-13-5951-2021.bib"))

regDataset(name = thisDataset,
           description = "The availability of crop type reference datasets for satellite image classification is very limited for complex agricultural systems as observed in developing and emerging countries. Indeed, agricultural land use is very dynamic, agricultural censuses are often poorly georeferenced and crop types are difficult to interpret directly from satellite imagery. In this paper, we present a database made of 24 datasets collected in a standardized manner over nine sites within the framework of the international JECAM (Joint Experiment for Crop Assessment and Monitoring) initiative; the sites were spread over seven countries of the tropical belt, and the number of data collection years depended on the site (from 1 to 7 years between 2013 and 2020). These quality-controlled datasets are distinguished by in situ data collected at the field scale by local experts, with precise geographic coordinates, and following a common protocol. Altogether, the datasets completed 27 074 polygons (20 257 crops and 6817 noncrops, ranging from 748 plots in 2013 (one site visited) to 5515 in 2015 (six sites visited)) documented by detailed keywords. These datasets can be used to produce and validate agricultural land use maps in the tropics. They can also be used to assess the performances and robustness of classification methods of cropland and crop types/practices in a large range of tropical farming systems. The dataset is available at https://doi.org/10.18167/DVN1/P7OLAP (Jolivot et al., 2021).",
           url = "https://doi.org/10.5194/essd-13-5951-2021",
           download_date = "2022-01-22",
           type = "static",
           licence = "CC BY 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- st_read(paste0(thisPath, "BD_JECAM_CIRAD_2021_dec_centroid.shp"))
data1 <- st_coordinates(data) %>% as_tibble()
data <- data %>%
  st_drop_geometry() %>%
  as_tibble() %>%
  bind_cols(data1)


# manage ontology ---
#
matches <- tibble(new = unique(c(data$CropType1, data$CropType2, data$CropType3, data$LandCover)),
                  old = c("Fallow", "Fallow", "cow pea", "peanut", "sorghum",
                          "maize", "sesame", "rice", NA, "jatropha", "Fallow",
                          "cotton", "Fallow", "millet", "soybean", "eucalyptus",
                          "pea", "mango", NA, "Mixed cereals", "hibiscus",
                          "okra", "cashew", NA, "FRUIT", NA, "ROOTS AND TUBERS",
                          "VEGETABLES", "Fallow", "taro", "sapodilla", "tea",
                          "coffee", "macadamia", "Flower herbs", "banana",
                          "nappier grass", "Root or Bulb vegetables",
                          "Woody flower crops", "Other Wooded Areas", "avocado",
                          NA, NA, NA, NA, NA, NA, NA,
                          NA, NA, "papaya", "sugarcane", "sunflower", "Grass and fodder crops",
                          "sweet potato", "cassava", "Leafy or stem vegetables",
                          "potato", "tomato", NA, "carrot", "bean", "cabbage",
                          "oat", "onion", "Woody plantation", "Medicinal crops",
                          "asparagus", "Sugar beet", "squash", "cucumber gherkin",
                          "cucumber", "pineapple", "apple", "barley", "Oilseed crops",
                          "pear", "Root or Bulb vegetables", "Fruit-bearing vegetables",
                          "grape", "Mosaic of agricultural-uses", "peach", "Leguminous crops", "CEREALS",
                          "orange", NA, "wheat", "Other vegetables", "watermelon", NA,
                          "Citrus Fruit", "cauliflower broccoli", "Roots and Tubers",
                          "eggplant", "guava", "Tree orchards", "cassava", NA,
                          "Grass and fodder crops", "millet", "natural rubber",
                          "hibiscus", "cashew", "Fibre crops", "Palm plantations",
                          "mango", "Citrus Fruit", "lettuce", "cotton", "oil palm",
                          NA, "Temporary cropland", "Permanent grazing",
                          "Heterogeneous semi-natural areas", "Heterogeneous semi-natural areas",
                          "ARTIFICIAL SURFACES", "Open spaces with little or no vegetation",
                          "Forests", "WATER BODIES", "Heterogeneous semi-natural areas",
                          "Heterogeneous semi-natural areas", "Open spaces with little or no vegetation",
                          "Forests", "Shrubland", "Herbaceous associations",
                          "Urban fabric", "Open spaces with little or no vegetation",
                          "Herbaceous associations", "Open spaces with little or no vegetation",
                          "WETLANDS", "FOREST AND SEMI-NATURAL AREAS"))

newConcept(new = c("jatropha", "macadamia", "sapodilla", "nappier grass", "hibiscus"),
           broader = c("Oilseed crops", "Treenuts", "Pome Fruit", "Bioenergy herbaceous", "Stimulant crops"),
           class = "commodity",
           source = thisDataset)

newConcept(new = c("svanna"),
           broader = c("Forests"),
           class = "forest type",
           source = thisDataset)

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)


# harmonise data ----
#
temp <- data %>%
  mutate(
    fid = row_number(),
    type = "point",
    x = X,
    y = Y,
    geometry = NA,
    year = year(AcquiDate),
    month = month(AcquiDate),
    day = day(AcquiDate),
    datasetID = thisDataset,
    country = Country,
    irrigated = as.logical(Irrigated),
    area = NA_real_,
    presence = TRUE,
    externalID = as.character(Id),
    externalValue = CropType1,
    LC1_orig = LandCover,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
