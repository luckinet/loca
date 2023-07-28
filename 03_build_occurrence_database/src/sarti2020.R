# script arguments ----
#
thisDataset <- "Sarti2020"
description <- "This dataset is used in the article Trees Outside Forest in Italian agroforestry landscapes: detection and mapping using Sentinel-2 imagery, to be submitted to the European Journal of Remote Sensing https://www.tandfonline.com/toc/tejr20/current."
url <- "https://doi.org/10.5281/zenodo.4395833 https://"
licence <- "Attribution 4.0 International"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "sarti.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-04-13"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data1 <- st_read(paste0(thisPath, "data.gpkg"), layer = "Woods1")
data2 <- st_read(paste0(thisPath, "data.gpkg"), layer = "Woods2")

data <- bind_rows(data1, data2)


# pre-process data ----
#
data1 <- data %>%
  as.data.frame() %>%
  mutate(FID = row_number())

temp <- data %>%
  mutate(area = st_area(.)) %>%
  st_centroid() %>%
  st_transform(., crs = "EPSG:4326") %>%
  st_make_valid(.) %>%
  mutate(x = st_coordinates(.)[,1],
         y = st_coordinates(.)[,2],
         FID = row_number()) %>%
  as.data.frame() %>%
  left_join(., data1, by = "FID")


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = NA_character_,
    x = x,
    y = y,
    geometry = NA,
    epsg = 4326,
    area = area,
    date = NA,
    externalID = NA_character_,
    externalValue = "Forests",
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = FALSE,
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
