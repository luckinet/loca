# script arguments ----
#
thisDataset <- "Sanches2018"
description <- "The monitoring of agricultural activities at a regular basis is crucial to assure that the food production meets the world population demands, which is increasing yearly. Such information can be derived from remote sensing data. In spite of topic’s relevance, not enough efforts have been invested to exploit modern pattern recognition and machine learning methods for agricultural land-cover mapping from multi-temporal, multi-sensor earth observation data. Furthermore, only a small proportion of the works published on this topic relates to tropical/subtropical regions, where crop dynamics is more complicated and difficult to model than in temperate regions. A major hindrance has been the lack of accurate public databases for the comparison of different classification methods. In this context, the aim of the present paper is to share a multi-temporal and multi-sensor benchmark database that can be used by the remote sensing community for agricultural land-cover mapping. Information about crops in situ was collected in Luís Eduardo Magalhães (LEM) municipality, which is an important Brazilian agricultural area, to create field reference data including information about first and second crop harvests. Moreover, a series of remote sensing images was acquired and pre-processed, from both active and passive orbital sensors (Sentinel-1, Sentinel-2/MSI, Landsat-8/OLI), correspondent to the LEM area, along the development of the main annual crops. In this paper, we describe the LEM database (crop field boundaries, land use reference data and pre-processed images) and present the results of an experiment conducted using the Sentinel-1 and Sentinel-2 data."
url <- "https://doi.org/10.5194/isprs-archives-XLII-1-387-2018"
license <- "CC BY 4.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "isprs-archives-XLII-1-387-2018.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-10-27"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- st_read(dsn = paste0(thisPath, "classes_mensal_LEM_buffer_cut_v2"))


# pre-process data ----
#
data <- data %>%
  pivot_longer(cols = c(3:15)) %>%
  st_cast(., "POLYGON") %>%
  separate_rows(value, sep = "[+]")

data <- data %>%
  st_centroid(.) %>%
  st_transform(., crs = 4326) %>%
  mutate(x = st_coordinates(.)[,1],
         y = st_coordinates(.)[,2]) %>%
  bind_cols(data)


# harmonise data ----
#
temp <- data %>%
  distinct(x,y, value...11, name...10, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = NA_character_,
    x = x,
    y = y,
    geometry = geometry...12,
    epsg = 4326,
    area = area_ha...2,
    date = dmy(paste0("01_", name...10)),
    externalID = NA_character_,
    externalValue = value...11,
    irrigated = NA,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "validation") %>%
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

# newConcepts <- tibble(target = c("Fallow", "soybean", "sorghum",
#                                  "millet", "maize", "Heterogeneous semi-natural areas",
#                                  "Other Wooded Areas", NA, "cotton",
#                                  NA, "coffee", "Grass crops",
#                                  "bean", "Temporary grazing", "eucalyptus",
#                                  "Grass crops", "wheat", "Grass crops"),
#                       new = unique(data$value),
#                       class = c("land-use", "commodity", "commodity",
#                                 "commodity", "commodity", "landcover",
#                                 "landcover", NA, "commodity",
#                                 NA, "commodity", "class",
#                                 "commodity", "land-use", "commodity",
#                                 "class", "commodity", "class"),
#                       description = NA,
#                       match = "close",
#                       certainty = 3)

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
