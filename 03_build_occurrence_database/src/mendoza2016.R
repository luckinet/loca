# script arguments ----
#
thisDataset <- "Mendoza2016"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "Mendoza_2016.ris"))

regDataset(name = thisDataset,
           description = "Changes in the life cycle of organisms (i.e. phenology) are one of the most widely used early-warning indicators of climate change, yet this remains poorly understood throughout the tropics. We exhaustively reviewed any published and unpublished study on fruiting phenology carried out at the community level in the American tropics and subtropics (latitudinal range: 26°N?26°S) to (1) provide a comprehensive overview of the current status of fruiting phenology research throughout the Neotropics; (2) unravel the climatic factors that have been widely reported as drivers of fruiting phenology; and (3) provide a preliminary assessment of the potential phenological responses of plants under future climatic scenarios. Despite the large number of phenological datasets uncovered (218), our review shows that their geographic distribution is very uneven and insufficient for the large surface of the Neotropics (~ 1 dataset per ~ 78,000 km2). Phenological research is concentrated in few areas with many studies (state of São Paulo, Brazil, and Costa Rica), whereas vast regions elsewhere are entirely unstudied. Sampling effort in fruiting phenology studies was generally low: the majority of datasets targeted fewer than 100 plant species (71%), lasted 2 years or less (72%), and only 10.4% monitored > 15 individuals per species. We uncovered only 10 sites with ten or more years of phenological monitoring. The ratio of numbers of species sampled to overall estimates of plant species richness was wholly insufficient for highly diverse vegetation types such as tropical rainforests, seasonal forest and cerrado, and only slightly more robust for less diverse vegetation types, such as deserts, arid shrublands and open grassy savannas. Most plausible drivers of phenology extracted from these datasets were environmental (78.5%), whereas biotic drivers were rare (6%). Among climatic factors, rainfall was explicitly included in 73.4% of cases, followed by air temperature (19.3%). Other environmental cues such as water level (6%), solar radiation or photoperiod (3.2%), and ENSO events (1.4%) were rarely addressed. In addition, drivers were analyzed statistically in only 38% of datasets and techniques were basically correlative, with only 4.8% of studies including any consideration of the inherently autocorrelated character of phenological time series. Fruiting peaks were significantly more often reported during the rainy season both in rainforests and cerrado woodlands, which is at odds with the relatively aseasonal character of the former vegetation type. Given that climatic models predict harsh future conditions for the tropics, we urgently need to determine the magnitude of changes in plant reproductive phenology and distinguish those from cyclical oscillations. Long-term monitoring and herbarium data are therefore key for detecting these trends. Our review shows that the unevenness in geographic distribution of studies, and diversity of sampling methods, vegetation types, and research motivation hinder the emergence of clear general phenological patterns and drivers for the Neotropics. We therefore call for prioritizing research in unexplored areas, and improving the quantitative component and statistical design of reproductive phenology studies to enhance our predictions of climate change impacts on tropical plants and animals.",
           url = "https://doi.org/10.1594/PANGAEA.869646", # ideally the doi, but if it doesn't have one, the main source of the database
           download_date = "2022-05-11", # YYYY-MM-DD
           type = "static", # dynamic or static
           licence = "CC-BY-3.0",
           contact = "see corresponding author", # optional, if it's a paper that should be "see corresponding author"
           disclosed = "yes", # whether the data are freely available "yes"/"no"
           bibliography = bib,
           update = TRUE)


# pre-process data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#
data <- read_tsv(file = paste0(thisPath, "Mendoza_2016.tab"), skip = 207)

# manage ontology ---
#
# define labels in the new dataset and their matching already harmonised labels
matches <- tibble(new = c(...),
                  old = c(...))
# getConcept(label_en = matches$old, missing = TRUE)

newConcept(new = c(),
           broader = c(), # the labels 'new' should be nested into
           class = , # try to keep that as conservative as possible and only come up with new classes, if really needed
           source = thisDataset)

getConcept(label_en = matches$old) %>%
  # ... %>% apply some additional filters (optional)
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = , # in most cases that should be "close", see ?newMapping
             source = thisDataset,
             certainty = ) # value from 1:3


# harmonise data ----
#
# carry out optional corrections and validations ...


# ... and then reshape the input data into the harmonised format
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = , # "point" or "areal" (such as plot, region, nation, etc)
    x = , # x-value of centroid
    y = , # y-value of centroid
    geometry = NA,
    year = ,
    month = , # must be NA_real_ if it's not given
    day = , # must be NA_integer_ if it's not given
    country = NA_character_,
    irrigated = , # in case the irrigation status is provided
    area = , # in case the features are from plots and the table gives areas but no spatial object is available
    presence = , # whether the data are 'presence' data (TRUE), or whether they are 'absence' data (i.e., that the data point indicates the value in externalValue is not present) (FALSE)
    externalID = NA_character_,
    externalValue = ,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = , # "field", "visual interpretation", "experience", "meta study" or "modelled"
    collector = , # "expert", "citizen scientist" or "student"
    purpose = , # "monitoring", "validation", "study" or "map development"
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
