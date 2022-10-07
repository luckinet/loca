# script arguments ----
#
thisDataset <- "Crowther2019"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "pericles_1461024822.ris"))

regDataset(name = thisDataset,
           description = "Soil stores approximately twice as much carbon as the atmosphere and fluctuations in the size of the soil carbon pool directly influence climate conditions. We used the Nutrient Network global change experiment to examine how anthropogenic nutrient enrichment might influence grassland soil carbon storage at a global scale. In isolation, enrichment of nitrogen and phosphorous had minimal impacts on soil carbon storage. However, when these nutrients were added in combination with potassium and micronutrients, soil carbon stocks changed considerably, with an average increase of 0.04 KgCm−2 year−1 (standard deviation 0.18 KgCm−2 year−1). These effects did not correlate with changes in primary productivity, suggesting that soil carbon decomposition may have been restricted. Although nutrient enrichment caused soil carbon gains most dry, sandy regions, considerable absolute losses of soil carbon may occur in high‐latitude regions that store the majority of the world's soil carbon. These mechanistic insights into the sensitivity of grassland carbon stocks to nutrient enrichment can facilitate biochemical modelling efforts to project carbon cycling under future climate scenarios. ",
           url = "https://doi.org/10.5061/dryad.0dt27vb",
           download_date = "2022-06-01",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


data <- read_csv(file = paste0(thisPath, "Nutrient_Enrichment_Dataset.csv.csv"))



# manage ontology ---
#
matches <- tibble(new = c(...),
                  old = c(...))

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

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = long,
    y = llat,
    geometry = NA,
    year = ,
    month = ,
    day = ,
    country = NA_character_,
    irrigated = F, # in case the irrigation status is provided
    area = , # in case the features are from plots and the table gives areas but no spatial object is available
    presence = , # whether the data are 'presence' data (TRUE), or whether they are 'absence' data (i.e., that the data point indicates the value in externalValue is not present) (FALSE)
    externalID = NA_character_,
    externalValue = ,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
