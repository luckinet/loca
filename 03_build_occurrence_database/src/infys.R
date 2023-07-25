# script arguments ----
#
thisDataset <- "infys"
description <- "The INFyS is considered as Information of National Interest (IIN) by the National System of Statistics and Geography (LSNIEG). Its main objective is to have cartographic and statistical information on ecosystems and their associated resources, to serve as support for planning and sustainable forestry development in the country. For field data collection, it is based on systematic sampling stratified by conglomerates, where each conglomerate is located equidistantly based on the ecosystem. It has a sampling grid of 26,220 primary sampling units (clusters), in which about 390 variables grouped into sections with information on: species composition, tree characteristics and regeneration, forest health and soil condition are collected. The survey of all the data in the field is carried out in five-year cycles, for which 20% of the annual sample is systematically distributed, in such a way that representative information of all ecosystems is available in a systematic way. timely. In this section you can consult: INFyS sampling grid, Sampling status per cycle and per year, Clusters sampled by section "
url <- "https://doi.org/ https://snmf.cnf.gob.mx/datos-del-inventario/#"
licence <- ""


# reference ----
#
bib <- bibentry(bibtype = "Misc",
                title = "National Inventory Forest and Soil - Mexico",
                author = "Jose Armando Alanis de la Rosa",
                year = "2022",
                institution = "Gobierno de Mexico")

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-06-08"),
           type = "static",
           licence = licence,
           contact = "jalanis@conafor.gob.mx",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


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


# pre-process data ----
#
temp <- bind_rows(data, data1, data2)

# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Mexico",
    x = as.numeric(X),
    y = as.numeric(Y),
    geometry = NA,
    epsg = 4326,
    area = 400,
    date = NA,
    # year = as.numeric(Anio),
    # month = NA_real_,
    # day = NA_integer_,
    externalID = Conglomerado,
    externalValue = Formato,
    irrigated = FALSE,
    presence = TRUE,
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

# matches <- tibble(new = c(unique(temp$Formato)),
#                   old = c("Forests", "Forests", NA,
#                           NA, "Marine wetlands", NA,
#                           "Other Wooded Areas", "Forests", "Forests",
#                           "Forests", "Forests", "Forests",
#                           "Forests", NA, NA,
#                           NA, NA))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
