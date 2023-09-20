# script arguments ----
#
thisDataset <- "Aleza2018"
description <- "Vitellaria paradoxa (Gaertn C. F.), or shea tree, remains one of the most valuable trees for farmers in the Atacora district of northern Benin, where rural communities depend on shea products for both food and income. To optimize productivity and management of shea agroforestry systems, or parklands, accurate and up-to-date data are needed. For this purpose, we monitored120 fruiting shea trees for two years under three land-use scenarios and different soil groups in Atacora, coupled with a farm household survey to elicit information on decision making and management practices. To examine the local pattern of shea tree productivity and relationships between morphological factors and yields, we used a randomized branch sampling method and applied a regression analysis to build a shea yield model based on dendrometric, soil and land-use variables. We also compared potential shea yields based on farm household socio-economic characteristics and management practices derived from the survey data. Soil and land-use variables were the most important determinants of shea fruit yield. In terms of land use, shea trees growing on farmland plots exhibited the highest yields (i.e., fruit quantity and mass) while trees growing on Lixisols performed better than those of the other soil group. Contrary to our expectations, dendrometric parameters had weak relationships with fruit yield regardless of land-use and soil group. There is an inter-annual variability in fruit yield in both soil groups and land-use type. In addition to observed inter-annual yield variability, there was a high degree of variability in production among individual shea trees. Furthermore, household socioeconomic characteristics such as road accessibility, landholding size, and gross annual income influence shea fruit yield. The use of fallow areas is an important land management practice in the study area that influences both conservation and shea yield."
url <- "https://doi.org/10.1371/journal.pone.0190234 https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "10.1371_journal.pone.0190234.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("29-10-2020"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = FALSE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(path = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Benin Agroforetry LU GPS Coordinate.xlsx"))


# harmonise data ----
#
temp <- data %>% dplyr::filter( `Species name` == "Vitellaria paradoxa" | `Species name` == "Vitellaria paradoxa coupe")

temp <- temp %>%
  st_as_sf(., coords = c("Longitude", "Latitude"), crs = CRS("EPSG:32631")) %>%
  st_transform(., crs = "EPSG:4326") %>%
  mutate(lon = st_coordinates(.)[,1],
         lat = st_coordinates(.)[,2]) %>%
  as.data.frame()

temp <- temp %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Benin",
    x = lon,
    y = lat,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA, # 2013 - month 9_10_11
    externalID = NA_character_,
    externalValue = `Species name`,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(month, sep = "_") %>%
  mutate(month = as.numeric(month),
         fid = row_number()) %>%
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
