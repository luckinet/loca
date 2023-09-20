# script arguments ----
#
thisDataset <- "Hilpold2018"
description = "Traditionally managed mountain grasslands are declining as a result of abandonment or intensification of management. Based on a common chronosequence approach we investigated species compositions of 16 taxonomic groups on traditionally managed dry pastures, fertilized and irrigated hay meadows, and abandoned grasslands (larch forests). We included faunal above- and below-ground biodiversity as well as species traits (mainly rarity and habitat specificity) in our analyses. The larch forests showed the highest species number (345 species), with slightly less species in pastures (290 species) and much less in hay meadows (163 species). The proportion of rare species was highest in the pastures and lowest in hay meadows. Similar patterns were found for specialist species, i.e. species with a high habitat specificity. After abandonment, larch forests harbor a higher number of pasture species than hay meadows. These overall trends were mainly supported by spiders and vascular plants. Lichens, bryophytes and carabid beetles showed partly contrasting trends. These findings stress the importance to include a wide range of taxonomic groups in conservation studies. All in all, both abandonment and intensification had similar negative impacts on biodiversity in our study, underlining the high conservation value of Inner- Alpine dry pastures."
url <- "https://doi.org/10.1594/PANGAEA.895988 https://"
licence <- "CC-BY-NC-SA-4.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Hilpold-etal_2018.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-05-29"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_tsv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Hilpold-etal_2018.tab"), skip = 664)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Italy",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = 2016,
    # month = 6,
    # day = NA_integer_,
    externalID = Event,
    externalValue = `Land use`,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = case_when(`Land use` == "intensive & irrigated" ~ T,
                          TRUE ~ F),
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

# matches <- tibble(new = c(unique(data$`Land use`)),
#                   old = c("Grass crops", "Temporally Unstocked Forest", "Permanent grazing"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
