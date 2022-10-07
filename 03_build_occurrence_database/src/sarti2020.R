# script arguments ----
#
thisDataset <- "Sarti2020"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "sarti.bib"))

regDataset(name = thisDataset,
           description = "This dataset is used in the article Trees Outside Forest in Italian agroforestry landscapes: detection and mapping using Sentinel-2 imagery, to be submitted to the European Journal of Remote Sensing https://www.tandfonline.com/toc/tejr20/current.",
           url = "https://doi.org/10.5281/zenodo.4395833",
           download_date = "2022-04-13",
           type = "static",
           licence = "Attribution 4.0 International",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# preprocess data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#

data1 <- st_read(paste0(thisPath, "data.gpkg"), layer = "Woods1")
data2 <- st_read(paste0(thisPath, "data.gpkg"), layer = "Woods2")

data <- bind_rows(data1, data2)

# harmonise data ----
#
data1 <- data %>%
  as.data.frame() %>%
  dplyr::mutate(FID = row_number())

temp <- data %>%
  mutate(area = st_area(.)) %>%
  st_centroid() %>%
  st_transform(., crs = "EPSG:4326") %>%
  st_make_valid(.) %>%
  dplyr::mutate(x = st_coordinates(.)[,1],
         y = st_coordinates(.)[,2],
         FID = row_number()) %>%
  as.data.frame() %>%
  left_join(., data1, by = "FID")

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = x,
    y = y,
    geometry = NA,
    year = ,
    month = NA_real_,
    day = NA_integer_,
    country = NA_character_,
    irrigated = F,
    area = area,
    presence = F,
    externalID = NA_character_,
    externalValue = "Forests",
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
