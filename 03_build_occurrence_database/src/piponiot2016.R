# script arguments ----
#
thisDataset <- "Piponiot2016"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "21394.bib"))

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

description <- "When 2 Mha of Amazonian forests are disturbed by selective logging each year, more than 90 Tg of carbon (C) is emitted to the atmosphere. Emissions are then counterbalanced by forest regrowth. With an original modelling approach, calibrated on a network of 133 permanent forest plots (175 ha total) across Amazonia, we link regional differences in climate, soil and initial biomass with survivors’ and recruits’ C fluxes to provide Amazon-wide predictions of post-logging C recovery. We show that net aboveground C recovery over 10 years is higher in the Guiana Shield and in the west (21 ±3 Mg C ha−1) than in the south (12 ±3 Mg C ha−1) where environmental stress is high (low rainfall, high seasonality). We highlight the key role of survivors in the forest regrowth and elaborate a comprehensive map of post-disturbance C recovery potential in Amazonia."
url <- "https://doi.org/10.7554/eLife.21394.001"
license <- "CC0 1.0"

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2022-01-09",
           type = "static",
           licence = licence,
           contact = "camille.piponiot@gmail.com",
           disclosed = "no",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_delim(paste0(thisPath, "sites_clim_soil.csv"),
                   delim = ";",
                   locale = locale(decimal_mark = ","))


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)


# harmonise data ----
#
data$years <- paste(data$first_census, data$last_census, sep="_")
data <- data %>% separate_rows(years, sep="_")
temp <- data %>%
  mutate(
    fid = row_number(),
    x = longitude,
    y = latitude,
    luckinetID = 1125,
    year = years,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    country = NA_character_,
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = NA_character_,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, year, month, day, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())

# before preparing data for storage, test that all required variables are available
assertNames(x = names(temp),
            must.include = c("datasetID", "fid", "country", "x", "y", "epsg",
                             "year", "month", "day", "irrigated",
                             "externalID", "externalValue", "LC1_orig", "LC2_orig", "LC3_orig",
                             "sample_type", "collector", "purpose"))


# write output ----
#
saveDataset(object = temp, dataset = thisDataset)
