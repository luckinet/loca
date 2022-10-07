# script arguments ----
#
thisDataset <- "Tateishi2014"
thisPath <- paste0(DBDir, thisDataset)
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "citation-273996029.ris"))

regDataset(name = thisDataset,
           description = "A fifteen-second global land cover dataset –– GLCNMO2008 (or GLCNMO version 2) was produced by the authors in the Global Mapping Project coordinated by the International Steering Committee for Global Mapping (ISCGM). The primary source data of this land cover mapping were 23-period, 16-day composite, 7-band, 500-m MODIS data of 2008. GLCNMO2008 has 20 land cover classes, within which 14 classes were mapped by supervised classification. Training data for supervised classification consisting of about 2,000 polygons were collected globally using Google Earth and regional existing maps with reference of this study’s original potential land cover map created by existing six global land cover products. The remaining six land cover classes were classified independently: Urban, Tree Open, Mangrove, Wetland, Snow/Ice, and Water. They were mapped by improved methods from GLCNMO version 1. The overall accuracy of GLCNMO2008 is 77.9% by 904 validation points and the overall accuracy with the weight of the mapped area coverage is 82.6%. The GLCNMO2008 product, land cover training data, and reference regional maps are available through the internet.",
           url = "http://dx.doi.org/10.5539/jgg.v6n3p99",
           download_date = "2022-08-17",
           type = "static",
           licence = "CC BY 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#

data <- read_sf(dsn = paste0(thisPath))

# manage ontology ---
#
newConcepts <- tibble(label = ,
                      class = ,
                      description = ,
                      match = ,
                      certainty = )

luckiOnto <- new_source(name = thisDataset,
                        description = "",
                        homepage = "",
                        license = "",
                        ontology = luckiOnto)

# in case new harmonised concepts appear here (avoid if possible)
# luckiOnto <- new_concept(new = , broader = , class = , description = ,
#                          ontology = luckiOnto)

luckiOnto <- new_mapping(new = newConcepts$new,
                         target = newConcepts %>% select(class, desription, ...),
                         source = thisDataset,
                         description = newConcepts$description,
                         match = newConcepts$match,
                         certainty = newConcepts$certainty,
                         ontology = luckiOnto, matchDir = paste0(DBDir, "concepts/"))


# harmonise data ----
#

temp <- data %>%
  st_make_valid() %>%
  mutate(valid = st_is_valid(.)) %>%
  filter(., valid == TRUE) %>%
  drop_na(g_lc_type) %>%
  st_as_sf() %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = st_coordinates(.)[1],
    y = st_coordinates(.)[2],
    geometry = geometry,
    date = ymd("2008-01-01"),
    country = place,
    irrigated = F,
    area = as.numeric(st_area(.)),
    presence = T,
    externalID = as.character(cartodb_id),
    externalValue = in_lc_type, # make ontology
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "validation",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
