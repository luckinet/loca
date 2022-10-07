# script arguments ----
#
thisDataset <- "Pärn2018"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Paern-etal_2018.bib"))

regDataset(name = thisDataset,
           description = "Locations, dates, measurements of soil chemistry and physics, and N2O fluxes used in the analyses for the paper 'Nitrogen-rich organic soils under warm, well-drained conditions are global nitrous oxide emission hotspots' submitted to Nature Communications . A'air_t_max', air temperature at the nearest weather station in the warmest month of the year (KNMI Climate Explorer http://climexp.knmi.nl). Nitrogen-rich organic soils under warm, well-drained conditions are global nitrous oxide emission hotspots. N2O is a powerful greenhouse gas and the main driver of stratospheric ozone depletion. Since soils are the largest source of N2O, predicting soil response to changes in climate or land use is central to understanding and managing N2O. In a global field survey of N2O emissions and potential driving factors across a wide range of organic soils, we find that N2O flux can be predicted by models incorporating soil nitrate concentration (NO3-), water content and temperature. N2O emissions increases asymptotically with NO3-and follows a bell-shaped distribution with water content. Combining the two functions explains 72% of N2O emission from all organic soils. Above 5 mg NO3--N kg-1, either draining wet soils or irrigating well-drained soils increases N2O emission by orders of magnitude. As soil temperature together with NO3- explains 69% of N2O emission, tropical wetlands should be a priority for N2O management.",
           url = "https://doi.org/10.1594/PANGAEA.885897",
           download_date = "2022-01-09",
           type = "static",
           licence = "CC BY 3.0",
           contact = "jaan.parn@ut.ee",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_tsv(paste0(thisPath, "Paern-etal_2018.tab"), skip = 93)
# preprocess


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)


data <- data %>%
  separate(Event, sep = c(0, 5), into = c("a", "KMI", "country")) %>%
  separate(country, sep = "-", into = c("country", "rest"))

data$LandUseDes <- paste(data$`Land use`, data$`Description (Agricultural intensity)`)
# add luckinetID

allConcepts <- readRDS(file = paste0(dataDir, "run/global_0.1.0/tables/ids_all_global_0.1.0.rds"))

match <- data %>%
  select(LandUseDes) %>%
  distinct() %>%
  mutate(term = tolower(LandUseDes)) %>%
  left_join(allConcepts, by = c("term"))

new <- match %>%
  filter(is.na(luckinetID)) %>%
  mutate(luckinetID = c(1125, 1134, # check first value with solution of git lab Issue Quisehuatl-Medina2020
                        NA,   1129,
                        NA, 1136,
                        1134, NA,
                        1134, 1136,
                        NA, 1134,
                        NA, NA,
                        1134, 1134,
                        1129, 1129,
                        1129, 1134,
                        1119, 1127,
                        NA))

match <- match %>%
  filter(!is.na(luckinetID)) %>%
  bind_rows(new) %>%
  select(term, luckinetID)

## join tibble
data <- data %>%
  mutate(term = tolower(LandUseDes)) %>%
  left_join(., match, by = "term")


# harmonise data ----
#
temp <- data %>%
  mutate(
    fid = row_number(),
    x = Longitude,
    y = Latitude,
    luckinetID = ,
    year = year(`Sampling date`),
    month = month(`Sampling date`),
    day = day(`Sampling date`),
    datasetID = thisDataset,
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = LandUseDes,
    LC1_orig = `Land use`,
    LC2_orig = `Description (Agricultural intensity)`,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, year, month, day, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
