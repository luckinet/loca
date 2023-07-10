# script arguments ----
#
thisDataset <- "infys"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibentry(bibtype = "Misc",
                title = "National Inventory Forest and Soil - Mexico",
                author = "Jose Armando Alanis de la Rosa",
                year = "2022",
                institution = "Gobierno de Mexico")

regDataset(name = thisDataset,
           description = "The INFyS is considered as Information of National Interest (IIN) by the National System of Statistics and Geography (LSNIEG). Its main objective is to have cartographic and statistical information on ecosystems and their associated resources, to serve as support for planning and sustainable forestry development in the country. For field data collection, it is based on systematic sampling stratified by conglomerates, where each conglomerate is located equidistantly based on the ecosystem. It has a sampling grid of 26,220 primary sampling units (clusters), in which about 390 variables grouped into sections with information on: species composition, tree characteristics and regeneration, forest health and soil condition are collected. The survey of all the data in the field is carried out in five-year cycles, for which 20% of the annual sample is systematically distributed, in such a way that representative information of all ecosystems is available in a systematic way. timely. In this section you can consult: INFyS sampling grid, Sampling status per cycle and per year, Clusters sampled by section ",
           url = "https://snmf.cnf.gob.mx/datos-del-inventario/#",
           download_date = "2022-06-08",
           type = "static",
           licence = "",
           contact = "jalanis@conafor.gob.mx",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# pre-process data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#

data <- read_excel(path = paste0(thisPath, "new/INFyS_Secciones_2004_2007_7VCcv7Y.xlsx"), sheet = 1) %>%
  mutate_all(as.character)
data1 <- read_excel(path = paste0(thisPath, "new/INFyS_Secciones_2009_2014_w18bSF1.xlsx"), sheet = 1) %>%
  mutate_all(as.character)
data2 <- read_excel(path = paste0(thisPath, "new/INFyS_Secciones_2015-2020_23IpTrY.xlsx"), sheet = 2) %>%
  mutate_all(as.character) %>%
  mutate(Formato = Formacion_S6,
         X = X_Levantada,
         Y = Y_Levantada)

temp <- bind_rows(data, data1, data2)




# manage ontology ---
#
matches <- tibble(new = c(unique(temp$Formato)),
                  old = c("Forests", "Forests", NA,
                          NA, "Marine wetlands", NA,
                          "Other Wooded Areas", "Forests", "Forests",
                          "Forests", "Forests", "Forests",
                          "Forests", NA, NA,
                          NA, NA))


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
  dplyr::mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = as.numeric(X),
    y = as.numeric(Y),
    geometry = NA,
    year = as.numeric(Anio),
    month = NA_real_,
    day = NA_integer_,
    country = "Mexico",
    irrigated = F,
    area = 400,
    presence = T,
    externalID = Conglomerado,
    externalValue = Formato,
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
