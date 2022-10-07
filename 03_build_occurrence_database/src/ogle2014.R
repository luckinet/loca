# script arguments ----
#
thisDataset <- "Ogle2014"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "1205.bib")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "The NACP (Denning et al., 2005; Wofsy and Harriss, 2002) is a multidisciplinary research program to obtain scientific understanding of North America's carbon sources and sinks and of changes in carbon stocks needed to meet societal concerns and to provide tools for decision makers. Successful execution of the NACP has required an unprecedented level of coordination among observational, experimental, and modeling efforts regarding terrestrial, oceanic, atmospheric, and human components. The project has relied upon a rich and diverse array of existing observational networks, monitoring sites, and experimental field studies in North America and its adjacent oceans. It is supported by a number of different federal agencies through a variety of intramural and extramural funding mechanisms and award instruments. Recently, NACP organized several synthesis activities to evaluate and inter-compare biosphere model outputs and observation data at local to continental scales for the time period of 2000 through 2005. The synthesis activities have included three component studies, each conducted on different spatial scales and producing numerous data products: (1) site-level synthesis that examined process-based model estimates and observations at over 30 AmeriFlux and Fluxnet-Canada tower sites across North America; (2) a regional, mid-continent intensive study centered in the agricultural regions of the United States and focused on comparing inventory-based estimates of net carbon exchange with those from atmospheric inversions; and (3) a regional and continental synthesis evaluating model estimates against each other and available inventory-based estimates across North America. A number of other NACP syntheses are underway, including ones focusing on non-CO2 greenhouse gases, the impact of disturbance on carbon exchange, and coastal carbon dynamics. The Oak Ridge National Laboratory (ORNL) Distributed Active Archive Center (DAAC) is the archive for the NACP synthesis data products.",
           url = "http://dx.doi.org/10.3334/ORNLDAAC/1205",
           download_date = "2022-01-13",
           type = "static",
           licence = NA_character_,
           contact = "stephen.ogle@colostate.edu",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
dataForest <- read_delim(paste0(thisPath, "NACP_MCI_CO2_INVENTORY_1205/NACP_MCI_CO2_INVENTORY_1205/data/NACPMCIEmissionsInventory_2007_FOREST.txt"), delim = " ")
dataHarvest <-read_delim(paste0(thisPath, "NACP_MCI_CO2_INVENTORY_1205/NACP_MCI_CO2_INVENTORY_1205/data/NACPMCIEmissionsInventory_2007_HARVEST.txt"), delim = " ")
dataLive <-read_delim(paste0(thisPath, "NACP_MCI_CO2_INVENTORY_1205/NACP_MCI_CO2_INVENTORY_1205/data/NACPMCIEmissionsInventory_2007_LIVESTOCK.txt"), delim = " ")
dataCrop <-read_delim(paste0(thisPath, "NACP_MCI_CO2_INVENTORY_1205/NACP_MCI_CO2_INVENTORY_1205/data/NACPMCIEmissionsInventory_2007_SOILC_CROP.txt"), delim = " ")
dataGrass <-read_delim(paste0(thisPath, "NACP_MCI_CO2_INVENTORY_1205/NACP_MCI_CO2_INVENTORY_1205/data/NACPMCIEmissionsInventory_2007_SOILC_GRASS.txt"), delim = " ")

data <- bind_rows(dataForest, dataHarvest, dataLive, dataCrop, dataGrass)


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)
allConcepts <- readRDS(file = paste0(dataDir, "run/global_0.1.0/tables/ids_all_global_0.1.0.rds"))

match <- data %>%
  select(TYPE) %>%
  distinct() %>%
  mutate(term = tolower(TYPE)) %>%
  left_join(allConcepts, by = c("term"))

new <- match %>%
  filter(is.na(luckinetID)) %>%
  mutate(luckinetID = c(1122, 1120,
                        NA, 1120,
                        NA))

match <- match %>%
  filter(!is.na(luckinetID)) %>%
  bind_rows(new) %>%
  select(term, luckinetID)

## join tibble
data <- data %>%
  mutate(term = tolower(TYPE)) %>%
  left_join(., match, by = "term")


# harmonise data ----
#
temp <- data %>%
  mutate(
    fid = row_number(),
    type = "point",
    x = LON,
    y = LAT,
    year = 2007,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    country = "United States of America",
    irrigated = NA_character_,
    presence = TRUE,
    externalID = NA_character_,
    externalValue = TYPE,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp, type = "in-situ point") %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
