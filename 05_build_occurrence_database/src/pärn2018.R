# script arguments ----
#
thisDataset <- "Pärn2018"
description <- "Locations, dates, measurements of soil chemistry and physics, and N2O fluxes used in the analyses for the paper 'Nitrogen-rich organic soils under warm, well-drained conditions are global nitrous oxide emission hotspots' submitted to Nature Communications . A'air_t_max', air temperature at the nearest weather station in the warmest month of the year (KNMI Climate Explorer http://climexp.knmi.nl). Nitrogen-rich organic soils under warm, well-drained conditions are global nitrous oxide emission hotspots. N2O is a powerful greenhouse gas and the main driver of stratospheric ozone depletion. Since soils are the largest source of N2O, predicting soil response to changes in climate or land use is central to understanding and managing N2O. In a global field survey of N2O emissions and potential driving factors across a wide range of organic soils, we find that N2O flux can be predicted by models incorporating soil nitrate concentration (NO3-), water content and temperature. N2O emissions increases asymptotically with NO3-and follows a bell-shaped distribution with water content. Combining the two functions explains 72% of N2O emission from all organic soils. Above 5 mg NO3--N kg-1, either draining wet soils or irrigating well-drained soils increases N2O emission by orders of magnitude. As soil temperature together with NO3- explains 69% of N2O emission, tropical wetlands should be a priority for N2O management."
url <- "https://doi.org/10.1594/PANGAEA.885897"
license <- "CC BY 3.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Paern-etal_2018.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-09"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_tsv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Paern-etal_2018.tab"), skip = 93)


# pre-process data ----
#
data <- data %>%
  separate(Event, sep = c(0, 5), into = c("a", "KMI", "country")) %>%
  separate(country, sep = "-", into = c("country", "rest"))


# harmonise data ----
#
temp <- data %>%
  distinct(Longitude, Latitude, `Sampling date`, `Land use`, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = `Sampling date`,
    externalID = NA_character_,
    externalValue = tolower(paste(data$`Land use`, data$`Description (Agricultural intensity)`)),
    attr_1 = `Land use`,
    attr_1_typ = "landused",
    attr_2 = `Description (Agricultural intensity)`,
    attr_2_type = "landuse intensity",
    irrigated = NA,
    presence = NA,
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


# newConcepts <- tibble(target = c("Temporary grazing", "Temporary grazing", "Temporary cropland",
#                                  "Permanent grazing", "Temporary cropland", "Forests",
#                                  "Temporary grazing", "Inland wetlands", "Temporary grazing",
#                                  "Temporary grazing", "Inland wetlands", "Temporary grazing",
#                                  "Inland wetlands", "Fallow",
#                                  "Temporary grazing", "Grass crops", "Grass crops",
#                                  "Temporary grazing", "Permanent grazing", "Temporary grazing",
#                                  "Temporary cropland", "Palm plantations", NA),
#                       new = unique(tolower(paste(data$`Land use`, data$`Description (Agricultural intensity)`))),
#                       class = c("land-use", "land-use", "landcover",
#                                 "land-use", "landcover", "landcover",
#                                 "land-use", "landcover", "land-use",
#                                 "land-use", "landcover", "land-use",
#                                 "landcover", "land-use",
#                                 "land-use", "class", "class",
#                                 "land-use", "land-use", "land-use",
#                                 "landcover", "land-use", NA),
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
