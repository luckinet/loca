# script arguments ----
#
thisDataset <- "Ogle2014"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "1205.bib"))

# column         type            description
# name
# description    [character]   description of the data-set
# url            [character]   ideally the doi, but if it doesn't have one, the
#                              main source of the database
# donwload_date  [POSIXct]     the date (DD-MM-YYYY) on which the data-set was
#                              downloaded
# type           [character]   "dynamic" (when the data-set updates regularly)
#                              or "static"
# license        [character]   abbreviation of the license under which the
#                              data-set is published
# contact        [character]   if it's a paper that should be "see corresponding
#                              author", otherwise some listed contact
# disclosed      [logical]
# bibliography   [handl]       bibliography object from the 'handlr' package
# path           [character]   the path to the occurrenceDB

description <- "This data set provides a bottom-up CO2 emissions inventory for the mid-continent region of the United States for the year 2007. The study was undertaken as part of the North American Carbon Program (NACP) Mid-Continent Intensive (MCI) campaign. Emissions for the MCI region were compiled from these resources into nine inventory sources (Table 1):(1) forest biomass and soil carbon, harvested woody products carbon, and agricultural soil carbon from the U.S. Greenhouse Gas (GHG) Inventory (EPA, 2010; Heath et al., 2011); (2) high resolution data on fossil and biofuel CO2 emissions from Vulcan (Gurney et al,. 2009); (3) CO2 uptake by agricultural crops, lateral transport in crop biomass harvest, and livestock CO2 emissions using USDA statistics (West et al., 2011); (4) agricultural residue burning (McCarty et al., 2011); (5) CO2 emissions from landfills (EPA, 2012); (6) and CO2 losses from human respiration using U.S. Census data (West et al., 2009). The CO2 inventory in the MCI region was dominated by fossil fuel combustion, carbon uptake during crop production, carbon export in biomass (commodities) from the region, and to a lesser extent, carbon sinks in forest growth and incorporation of carbon into timber products. "
url <- "https://doi.org/10.3334/ORNLDAAC/1205"
license <- ""

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("10-01-2022"),
           type = "static",
           licence = license,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           path = occurrenceDBDir)


# pre-process data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#

data <- read_delim(file = paste0(thisPath, "NACP_MCI_CO2_INVENTORY_1205/NACP_MCI_CO2_INVENTORY_1205/data/NACPMCIEmissionsInventory_2007.txt"))


# manage ontology ---
#
newConcepts <- tibble(target = c(NA, "Forests", "Temporary cropland",
                                 NA, "UNGULATES", "Temporary cropland",
                                 "Mine, dump and construction sites", "Temporary cropland", "Herbaceous associations"),
                      new = unique(data$TYPE),
                      class = c("", "landcover", "landcover",
                                NA, "group", "landcover",
                                "landcover", "landcover", "landcover"),
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
# carry out optional corrections and validations ...


# ... and then reshape the input data into the harmonised format
#
# column         type            description
# type           [character]  *  "point" or "areal" (when its from a plot,
#                                region, nation, etc)
# country        [character]  *  the country of observation
# x              [numeric]    *  x-value of centroid
# y              [numeric]    *  y-value of centroid
# geometry       [sf]            in case type = "areal", this should be the
#                                geometry column
# epsg           [numeric]    *  the EPSG code of the coordinates or geometry
# area           [numeric]       in case the features are from plots and the
#                                table gives areas but no 'geometry' is
#                                available
# date           [POSIXct]    *  see lubridate-package. These can be very easily
#                                created for instance with dmy(SURV_DATE), if
#                                its in day/month/year format
# externalID     [character]     the external ID of the input data
# externalValue  [character]  *  the external target label
# irrigated      [logical]       the irrigation status, in case it is provided
# presence       [logical]       whether the data are 'presence' data (TRUE), or
#                                whether they are 'absence' data (i.e., that the
#                                data point indicates the value in externalValue
#                                is not present) (FALSE)
# LC1/2/3_orig   [character]     if externalValue is associated with one or more
#                                landcover values, provide them here
# sample_type    [character]  *  "field", "visual interpretation", "experience",
#                                "meta study" or "modelled"
# collector      [character]  *  "expert", "citizen scientist" or "student"
# purpose        [character]  *  "monitoring", "validation", "study" or
#                                "map development"
#
# - columns with a * are obligatory, i.e., their default value below needs to be
# replaced

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
    presence = T,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated,presence, LC1_orig, LC2_orig,
         LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(path = occurrenceDBDir, name = thisDataset)

write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
