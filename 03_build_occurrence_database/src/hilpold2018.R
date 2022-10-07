# script arguments ----
#
thisDataset <- "Hilpold2018"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "Hilpold-etal_2018.ris"))

regDataset(name = thisDataset,
           description = "Traditionally managed mountain grasslands are declining as a result of abandonment or intensification of management. Based on a common chronosequence approach we investigated species compositions of 16 taxonomic groups on traditionally managed dry pastures, fertilized and irrigated hay meadows, and abandoned grasslands (larch forests). We included faunal above- and below-ground biodiversity as well as species traits (mainly rarity and habitat specificity) in our analyses. The larch forests showed the highest species number (345 species), with slightly less species in pastures (290 species) and much less in hay meadows (163 species). The proportion of rare species was highest in the pastures and lowest in hay meadows. Similar patterns were found for specialist species, i.e. species with a high habitat specificity. After abandonment, larch forests harbor a higher number of pasture species than hay meadows. These overall trends were mainly supported by spiders and vascular plants. Lichens, bryophytes and carabid beetles showed partly contrasting trends. These findings stress the importance to include a wide range of taxonomic groups in conservation studies. All in all, both abandonment and intensification had similar negative impacts on biodiversity in our study, underlining the high conservation value of Inner- Alpine dry pastures.",
           url = "https://doi.org/10.1594/PANGAEA.895988",
           download_date = "2022-05-29",
           type = "static",
           licence = "CC-BY-NC-SA-4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# pre-process data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#

data <- read_tsv(file = paste0(thisPath, "Hilpold-etal_2018.tab"), skip = 664)



# manage ontology ---
#
matches <- tibble(new = c(unique(data$`Land use`)),
                  old = c("Grass crops", "Temporally Unstocked Forest", "Permanent grazing"))


getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)


# harmonise data ----
#

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    year = 2016,
    month = 6,
    day = NA_integer_,
    country = "Italy",
    irrigated = case_when(`Land use` == "intensive & irrigated" ~ T,
                          TRUE ~ F),
    area = NA_real_,
    presence = T,
    externalID = Event,
    externalValue = `Land use`,
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
