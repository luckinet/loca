# script arguments ----
#
thisDataset <- "Zhao2014"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "tandf_tres2035_4795.bib"))

regDataset(name = thisDataset,
           description = "Validating land-cover maps at the global scale is a significant challenge. We built a global validation data-set based on interpreting Landsat Thematic Mapper (TM) and Enhanced TM Plus (ETM+) images for a total of 38,664 sample units pre-determined with an equalarea stratified sampling scheme. This was supplemented by MODIS enhanced vegetation index (EVI) time series data and other high-resolution imagery on Google Earth. Initially designed for validating 30 m-resolution global land-cover maps in the Finer Resolution Observation and Monitoring of Global Land Cover (FROM-GLC) project, the data-set has been carefully improved through several rounds of interpretation and verification by different image interpreters, and checked by one quality controller. Independent test interpretation indicated that the quality control correctness level reached 90% at level 1 classes using selected interpretation keys from various parts of the USA. Fifty-nine per cent of the samples have been verified with high-resolution images on Google Earth. Uncertainty in interpretation was measured by the interpreter’s perceived confidence. Only less than 7% of the sample was perceived as low confidence at level 1 by interpreters. Nearly 42% of the sample units located within a homogeneous area could be applied to validating global land-cover maps whose resolution is 500 m or finer. Forty-six per cent of the sample whose EVI values are high or with little seasonal variation throughout the year can be applied to validate land-cover products produced from data acquired in different phenological stages, while approximately 76% of the remaining sample whose EVI values have obvious seasonal variation was interpreted from images acquired within the growing season. While the improvement is under way, some of the homogeneous sample units in the data-set have already been used in assessing other classification results or as training data for land-cover mapping with coarser-resolution data.",
           url = "https://doi.org/10.1080/01431161.2014.930202",
           download_date = "2022-01-13",
           type = "static",
           licence = NA_character_,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

https://git.idiv.de/mas/projects/luckinet/02_data_processing/01_build_point_database/-/issues/11

# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "/GlobalLandCoverValidationSampleSet_v1.xlsx"), sheet = 1, col_names = TRUE)
labels <- read_csv(paste0(DBDir, "/", thisDataset, "/LC_label.csv")) %>%
  separate(`LC Label`, sep = " ", into = c("LC Label", "Name"), extra = "merge")


# manage ontology ---
#
# define labels in the new dataset and their matching already harmonised labels
matches <- tibble(new = c(unique(labels$Name)),
                  old = c("Shrubland", "Herbaceous associations",
                          "Shrubland", "Urban fabric",
                          "Industrial, commercial and transport units", "Urban fabric",
                          "rice", "AGRICULTURAL AREAS",
                          "AGRICULTURAL AREAS", "AGRICULTURAL AREAS",
                          "Forests", "Forests",
                          "Forests", "Forests",
                          "Tree orchards", NA,
                          "Fallow", "Open spaces with little or no vegetation",
                          "Open spaces with little or no vegetation", "AGRICULTURAL AREAS",
                          "Open spaces with little or no vegetation", "Permanent grazing",
                          "Grass and fodder crops", "Grass and fodder crops",
                          "Shrubland", "Inland waters",
                          "Inland waters", "Inland waters",
                          NA, "Marine wetlands",
                         "Inland wetlands", "Marine wetlands",
                         "Inland waters", "WATER BODIES",
                         "Inland waters", "Inland waters",
                         "Marine waters"))

getConcept(label_en = matches$old) %>%
  # ... %>% apply some additional filters (optional)
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close", # in most cases that should be "close", see ?newMapping
             source = thisDataset,
             certainty = 3) # value from 1:3


# harmonise data ----
#
##

## join data with labels
temp <- labels %>% mutate(`LC Label` = as.numeric(`LC Label`)) %>%
  left_join(., data, by = "LC Label")

temp <- temp %>%
  distinct(Lat, Lon, .keep_all = TRUE) %>%
  mutate(
    x = Lon,
    y = Lat,
    year = NA_real_,
    month = NA_real_,
    day = NA_integer_,
    irrigated = F,
    country = NA_character_,
    externalID = as.character(ID),
    datasetID = thisDataset,
    externalValue = Name,
    presence = T,
    type = "point",
    area = NA_real_,
    LC1_orig = Name,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "visual interpretation",
    collector = "expert",
    purpose = "study",
    fid = row_number(),
    epsg = 4326)%>%
  select(datasetID, fid, country, x, y, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())

# In case we are dealing with areal data, build object that contains polygons
# temp_sf <- temp %>%
#   mutate(geom = ) %>% # select the geometry object
#   select(datasetID, fid, geom)


# write output ----
#
validateFormat(object = temp, type = "in-situ point") %>%
  saveDataset(dataset = thisDataset)

# validateFormat(object = temp_sf, type = "in-situ areal") %>%
#   write_sf(dsn = paste0(thisDataset, "_sf.gpkg"), delete_layer = TRUE)

message("\n---- done ----")
