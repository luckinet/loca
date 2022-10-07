# script arguments ----
#
thisDataset <- "Seo2014"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "essd-6-339-2014.bib"))

regDataset(name = thisDataset,
           description = "Detailed data on land use and land cover constitute important information for Earth system models, environmental monitoring and ecosystem services research. Global land cover products are evolving rapidly; however, there is still a lack of information particularly for heterogeneous agricultural landscapes. We censused land use and land cover field by field in the agricultural mosaic catchment Haean in South Korea. We recorded the land cover types with additional information on agricultural practice. In this paper we introduce the data, their collection and the post-processing protocol. Furthermore, because it is important to quantitatively evaluate available land use and land cover products, we compared our data with the MODIS Land Cover Type product (MCD12Q1). During the studied period, a large portion of dry fields was converted to perennial crops. Compared to our data, the forested area was underrepresented and the agricultural area overrepresented in MCD12Q1. In addition, linear landscape elements such as waterbodies were missing in the MODIS product due to its coarse spatial resolution. The data presented here can be useful for earth science and ecosystem services research. The data are available at the public repository Pangaea (doi:110.1594/PANGAEA.823677).",
           url = "http://dx.doi.org/10.1594/PANGAEA.823677",
           download_date = "2022-06-08",
           type = "static",
           licence = "CC-BY-NC-3.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#

data <- st_read(dsn = paste0(thisPath, "HaeanCover_30Sep2014_V5_essd-6-339-2014/v5_essd/HaeanCover_shapefile"))


# preprocess ----
#

data1 <- data %>% select(matches("2009")) %>%
  mutate(year = 2009)
names(data1) <- sub("2009", "", names(data1))

data2 <- data %>% select(matches("2010")) %>%
  mutate(year = 2010)
names(data2) <- sub("2010", "", names(data2))

data3 <- data %>% select(matches("2011")) %>%
  mutate(year = 2011)
names(data3) <- sub("2011", "", names(data3))

temp <- bind_rows(data1, data2, data3)


# manage ontology ---
#
# define labels in the new dataset and their matching already harmonised labels
matches <- read_csv(paste0(thisPath, "Seo_ontology.csv"))

newConcept(new = "radish",
           broader = "Root or Bulb vegetables",
           class = "commoditiy",
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

# break MULTIPOLYGON into POLYGON, transform crs
temp <- temp %>%
  st_make_valid() %>%
  st_transform(., crs = "EPSG:4326") %>%
  st_cast(., "POLYGON")

# get area and coordinates
temp1 <- temp %>%
  st_make_valid() %>%
  mutate(area = st_area(.)) %>%
  st_centroid() %>%
  mutate(x = st_coordinates(.)[,1],
         y = st_coordinates(.)[,2])

temp <- bind_cols(temp, temp1)

temp <- temp %>%
  separate_rows(LULC...1, sep = ",") %>%
  dplyr::mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = x,
    y = y,
    geometry = geometry...8,
    year = year...7,
    month = NA_real_,
    day = NA_integer_,
    country = "South Korea",
    irrigated = F,
    area = as.numeric(area),
    presence = T,
    externalID = NA_character_,
    externalValue = LULC...1,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
