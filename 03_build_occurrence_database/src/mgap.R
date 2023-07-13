# script arguments ----
#
thisDataset <- "MGAP"
description <- "The set has the different Layers that make up the National Forest Cartography; Planted Forest- Native Forest- Palm Groves - Environment Cartography of Planted Forest: Information from the Evaluation and Information Division of the General Forestry Directorate - MGAP. Two layers are presented: Planted Forest Layer: Prepared based on digital processing and interpretation of Sentinel 2 images (2017 and 2018). Nine strata of the main planted species are presented. Forest Use Layer: Prepared by comparing Sentinel 2 images with a difference of 2 years (December 2015 to December 2017). Three strata are presented (Harvested Areas, New Plantations and Reforested Areas). Complements the Planted Forest Layer. Native Forest Cartography: Prepared based on digital processing and interpretation of Sentinel 2 images (2016). REDD+ Uruguay Project (MGAP-MVOTMA). Palm grove concentration area cartography: Information from the Evaluation and Information Division of the General Forestry Directorate - MGAP. Prepared based on the visual interpretation and subsequent digitization of the concentration areas of palm groves (more than 40 individuals/ha.) On high-resolution images from Google Earth."
url <- "https://doi.org/ https://catalogodatos.gub.uy/dataset/4591483a-0ee3-4346-8b93-f24e12195e84/resource/c28078da-b6f5-4469-bd59-26d965bf8d0d/download/palmares_final_enero2019_kml.kml"
licence <- ""


# reference ----
#
bib <- bibentry(bibtype = "Misc",
                title = "Palmares Concentration Area - 2019",
                year = "2019",
                author = "General Forestry Directorate Uruguay",
                url = "https://catalogodatos.gub.uy/dataset/4591483a-0ee3-4346-8b93-f24e12195e84/resource/c28078da-b6f5-4469-bd59-26d965bf8d0d/download/palmares_final_enero2019_kml.kml")

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2020-07-11"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- st_read(paste0(thisPath, "palmares_final_enero2019_kml.kml"))


# pre-process data ----
#
temp <- data %>%
  mutate(TID = row_number(),
                area = st_area(.)) %>%
  st_centroid() %>%
  mutate(lon = st_coordinates(.)[,1],
         lat = st_coordinates(.)[,2])

data <- data %>%
  as.data.frame() %>%
  mutate(TID = row_number()) %>%
  left_join(., temp, by = "TID")


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Uruguay",
    x = lon,
    y = lat,
    geometry = geometry.x,
    epsg = 4326,
    area = as.numeric(area),
    year = dmy(paste0("01-01-2019")),
    externalID = NA_character_,
    externalValue = "Palm plantations",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "visual interpretation",
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
