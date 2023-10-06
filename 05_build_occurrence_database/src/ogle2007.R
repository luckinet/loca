# script arguments ----
#
thisDataset <- "Ogle2014"
description <- "This data set provides a bottom-up CO2 emissions inventory for the mid-continent region of the United States for the year 2007. The study was undertaken as part of the North American Carbon Program (NACP) Mid-Continent Intensive (MCI) campaign. Emissions for the MCI region were compiled from these resources into nine inventory sources (Table 1):(1) forest biomass and soil carbon, harvested woody products carbon, and agricultural soil carbon from the U.S. Greenhouse Gas (GHG) Inventory (EPA, 2010; Heath et al., 2011); (2) high resolution data on fossil and biofuel CO2 emissions from Vulcan (Gurney et al,. 2009); (3) CO2 uptake by agricultural crops, lateral transport in crop biomass harvest, and livestock CO2 emissions using USDA statistics (West et al., 2011); (4) agricultural residue burning (McCarty et al., 2011); (5) CO2 emissions from landfills (EPA, 2012); (6) and CO2 losses from human respiration using U.S. Census data (West et al., 2009). The CO2 inventory in the MCI region was dominated by fossil fuel combustion, carbon uptake during crop production, carbon export in biomass (commodities) from the region, and to a lesser extent, carbon sinks in forest growth and incorporation of carbon into timber products. "
url <- "https://doi.org/10.3334/ORNLDAAC/1205 https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "1205.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("10-01-2022"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_delim(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "NACP_MCI_CO2_INVENTORY_1205/NACP_MCI_CO2_INVENTORY_1205/data/NACPMCIEmissionsInventory_2007.txt"))


# harmonise data ----
#
temp <- data %>%
  distinct(LON, LAT, TYPE, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "USA",
    x = LON,
    y = LAT,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd("2007-01-01"),
    externalID = NA_character_,
    externalValue = TYPE,
    irrigated = NA,
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

# newConcepts <- tibble(target = c(NA, "Forests", "Temporary cropland",
#                                  NA, "UNGULATES", "Temporary cropland",
#                                  "Mine, dump and construction sites", "Temporary cropland", "Herbaceous associations"),
#                       new = unique(data$TYPE),
#                       class = c("", "landcover", "landcover",
#                                 NA, "group", "landcover",
#                                 "landcover", "landcover", "landcover"),
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
