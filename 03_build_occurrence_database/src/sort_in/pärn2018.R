# script arguments ----
#
thisDataset <- "Pärn2018"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


description <- "Locations, dates, measurements of soil chemistry and physics, and N2O fluxes used in the analyses for the paper 'Nitrogen-rich organic soils under warm, well-drained conditions are global nitrous oxide emission hotspots' submitted to Nature Communications . A'air_t_max', air temperature at the nearest weather station in the warmest month of the year (KNMI Climate Explorer http://climexp.knmi.nl). Nitrogen-rich organic soils under warm, well-drained conditions are global nitrous oxide emission hotspots. N2O is a powerful greenhouse gas and the main driver of stratospheric ozone depletion. Since soils are the largest source of N2O, predicting soil response to changes in climate or land use is central to understanding and managing N2O. In a global field survey of N2O emissions and potential driving factors across a wide range of organic soils, we find that N2O flux can be predicted by models incorporating soil nitrate concentration (NO3-), water content and temperature. N2O emissions increases asymptotically with NO3-and follows a bell-shaped distribution with water content. Combining the two functions explains 72% of N2O emission from all organic soils. Above 5 mg NO3--N kg-1, either draining wet soils or irrigating well-drained soils increases N2O emission by orders of magnitude. As soil temperature together with NO3- explains 69% of N2O emission, tropical wetlands should be a priority for N2O management."
url <- "https://doi.org/10.1594/PANGAEA.885897"
license <- "CC BY 3.0"

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Paern-etal_2018.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2022-01-09",
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_tsv(paste0(thisPath, "Paern-etal_2018.tab"), skip = 93)

# manage ontology ---
#
newConcepts <- tibble(target = c("Temporary grazing", "Temporary grazing", "Temporary cropland",
                                 "Permanent grazing", "Temporary cropland", "Forests",
                                 "Temporary grazing", "Inland wetlands", "Temporary grazing",
                                 "Temporary grazing", "Inland wetlands", "Temporary grazing",
                                 "Inland wetlands", "Fallow",
                                 "Temporary grazing", "Grass crops", "Grass crops",
                                 "Temporary grazing", "Permanent grazing", "Temporary grazing",
                                 "Temporary cropland", "Palm plantations", NA),
                      new = unique(tolower(paste(data$`Land use`, data$`Description (Agricultural intensity)`))),
                      class = c("land-use", "land-use", "landcover",
                                "land-use", "landcover", "landcover",
                                "land-use", "landcover", "land-use",
                                "land-use", "landcover", "land-use",
                                "landcover", "land-use",
                                "land-use", "class", "class",
                                "land-use", "land-use", "land-use",
                                "landcover", "land-use", NA),
                      description = NA,
                      match = "close",
                      certainty = 3)

luckiOnto <- new_source(name = thisDataset,
                        description = description,
                        date = Sys.Date(),
                        homepage = url,
                        license = license,
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = newConcepts$new,
                         target = get_concept(x = newConcepts %>% select(label = target), ontology = luckiOnto),
                         source = thisDataset,
                         description = newConcepts$description,
                         match = newConcepts$match,
                         certainty = newConcepts$certainty,
                         ontology = luckiOnto, matchDir = paste0(occurrenceDBDir, "01_concepts/"))



# harmonise data ----
#

temp <- data %>%
  separate(Event, sep = c(0, 5), into = c("a", "KMI", "country")) %>%
  separate(country, sep = "-", into = c("country", "rest"))

temp <- temp %>%
  distinct(Longitude, Latitude, `Sampling date`, `Land use`, .keep_all = T)
  mutate(
    fid = row_number(),
    x = Longitude,
    y = Latitude,
    type = "point",
    geometry = NA,
    area = NA_real_,
    presence = T,
    date = `Sampling date`,
    datasetID = thisDataset,
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = tolower(paste(data$`Land use`, data$`Description (Agricultural intensity)`)),
    LC1_orig = `Land use`,
    LC2_orig = `Description (Agricultural intensity)`,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
