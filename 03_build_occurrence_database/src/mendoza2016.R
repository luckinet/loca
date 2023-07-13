# script arguments ----
#
thisDataset <- "Mendoza2016"
description <- "Changes in the life cycle of organisms (i.e. phenology) are one of the most widely used early-warning indicators of climate change, yet this remains poorly understood throughout the tropics. We exhaustively reviewed any published and unpublished study on fruiting phenology carried out at the community level in the American tropics and subtropics (latitudinal range: 26°N?26°S) to (1) provide a comprehensive overview of the current status of fruiting phenology research throughout the Neotropics; (2) unravel the climatic factors that have been widely reported as drivers of fruiting phenology; and (3) provide a preliminary assessment of the potential phenological responses of plants under future climatic scenarios. Despite the large number of phenological datasets uncovered (218), our review shows that their geographic distribution is very uneven and insufficient for the large surface of the Neotropics (~ 1 dataset per ~ 78,000 km2). Phenological research is concentrated in few areas with many studies (state of São Paulo, Brazil, and Costa Rica), whereas vast regions elsewhere are entirely unstudied. Sampling effort in fruiting phenology studies was generally low: the majority of datasets targeted fewer than 100 plant species (71%), lasted 2 years or less (72%), and only 10.4% monitored > 15 individuals per species. We uncovered only 10 sites with ten or more years of phenological monitoring. The ratio of numbers of species sampled to overall estimates of plant species richness was wholly insufficient for highly diverse vegetation types such as tropical rainforests, seasonal forest and cerrado, and only slightly more robust for less diverse vegetation types, such as deserts, arid shrublands and open grassy savannas. Most plausible drivers of phenology extracted from these datasets were environmental (78.5%), whereas biotic drivers were rare (6%). Among climatic factors, rainfall was explicitly included in 73.4% of cases, followed by air temperature (19.3%). Other environmental cues such as water level (6%), solar radiation or photoperiod (3.2%), and ENSO events (1.4%) were rarely addressed. In addition, drivers were analyzed statistically in only 38% of datasets and techniques were basically correlative, with only 4.8% of studies including any consideration of the inherently autocorrelated character of phenological time series. Fruiting peaks were significantly more often reported during the rainy season both in rainforests and cerrado woodlands, which is at odds with the relatively aseasonal character of the former vegetation type. Given that climatic models predict harsh future conditions for the tropics, we urgently need to determine the magnitude of changes in plant reproductive phenology and distinguish those from cyclical oscillations. Long-term monitoring and herbarium data are therefore key for detecting these trends. Our review shows that the unevenness in geographic distribution of studies, and diversity of sampling methods, vegetation types, and research motivation hinder the emergence of clear general phenological patterns and drivers for the Neotropics. We therefore call for prioritizing research in unexplored areas, and improving the quantitative component and statistical design of reproductive phenology studies to enhance our predictions of climate change impacts on tropical plants and animals.",
url <- "https://doi.org/10.1594/PANGAEA.869646 https://"
licence <- "CC-BY-3.0"


# reference ----
#
bib <- ris_reader(paste0(thisPath, "Mendoza_2016.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-05-11"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_tsv(file = paste0(thisPath, "Mendoza_2016.tab"), skip = 207)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = NA_character_,
    country = NA_character_,
    x = NA_real_,
    y = NA_real_,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = NA_character_,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = NA,
    sample_type = NA_character_,
    collector = NA_character_,
    purpose = NA_character_) %>%
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
