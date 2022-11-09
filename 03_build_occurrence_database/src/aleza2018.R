# script arguments ----
#
thisDataset <- "Aleza2018"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1371_journal.pone.0190234.ris"))

regDataset(name = thisDataset,
           description = "Vitellaria paradoxa (Gaertn C. F.), or shea tree, remains one of the most valuable trees for farmers in the Atacora district of northern Benin, where rural communities depend on shea products for both food and income. To optimize productivity and management of shea agroforestry systems, or parklands, accurate and up-to-date data are needed. For this purpose, we monitored120 fruiting shea trees for two years under three land-use scenarios and different soil groups in Atacora, coupled with a farm household survey to elicit information on decision making and management practices. To examine the local pattern of shea tree productivity and relationships between morphological factors and yields, we used a randomized branch sampling method and applied a regression analysis to build a shea yield model based on dendrometric, soil and land-use variables. We also compared potential shea yields based on farm household socio-economic characteristics and management practices derived from the survey data. Soil and land-use variables were the most important determinants of shea fruit yield. In terms of land use, shea trees growing on farmland plots exhibited the highest yields (i.e., fruit quantity and mass) while trees growing on Lixisols performed better than those of the other soil group. Contrary to our expectations, dendrometric parameters had weak relationships with fruit yield regardless of land-use and soil group. There is an inter-annual variability in fruit yield in both soil groups and land-use type. In addition to observed inter-annual yield variability, there was a high degree of variability in production among individual shea trees. Furthermore, household socioeconomic characteristics such as road accessibility, landholding size, and gross annual income influence shea fruit yield. The use of fallow areas is an important land management practice in the study area that influences both conservation and shea yield.",
           url = "https://doi.org/10.1371/journal.pone.0190234",
           download_date = "2020-10-29",
           type = "static",
           licence = "",
           contact = "see corresponding author",
           disclosed = "no",
           bibliography = bib,
           update = TRUE)



# read dataset ----
#

data <- read_excel(path = paste0(thisPath, "Benin Agroforetry LU GPS Coordinate.xlsx"))



# manage ontology ---
#
# define labels in the new dataset and their matching already harmonised labels
temp <- data %>% dplyr::filter( `Species name` == "Vitellaria paradoxa" | `Species name` == "Vitellaria paradoxa coupe")

matches <- tibble(new = c(unique(temp$`Species name`)),
                  old = c("shea nut", "shea nut"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)


# harmonise data ----
#
temp <- temp %>%
  st_as_sf(., coords = c("Longitude", "Latitude"), crs = CRS("EPSG:32631")) %>%
  st_transform(., crs = "EPSG:4326") %>%
  mutate(lon = st_coordinates(.)[,1],
         lat = st_coordinates(.)[,2]) %>%
  as.data.frame()

temp <- temp %>%
  mutate(
    datasetID = thisDataset,
    type = "point",
    x = lon,
    y = lat,
    geometry = NA,
    year = 2013,
    month = "9_10_11",
    day = NA_integer_,
    country = "benin",
    irrigated = F,
    area = NA_real_,
    presence = T,
    externalID = NA_character_,
    externalValue = `Species name`,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(month, sep = "_") %>%
  mutate(month = as.numeric(month),
         fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
