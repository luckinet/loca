# script arguments ----
#
thisDataset <- "Perrino2012"
description <- "A phytosociological study was conducted in the National Park of Alta Murgia in the Apulia region (Southern Italy) to determine the adverse effects of metal contamination of soils on the distribution of plant communities. The phytosociological analyses have shown a remarkable biodiversity of vegetation on non-contaminated soils, while biodiversity appeared strongly reduced on metal-contaminated soils. The area is naturally covered by a wide steppic grassland dominated by Stipa austroitalica Martinovsky subsp. austroitalica. Brassicaceae such as Sinapis arvensis L. are the dominating species on moderated contaminated soils, whereas spiny species of Asteraceae such as Silybum marianum (L.) Gaertn. and Carduus pycnocephalus L. subsp. pycnocephalus are the dominating vegetation on heavily metal-contaminated soils. The presence of these spontaneous species on contaminated soils suggest their potential for restoration of degraded lands by phytostabilization strategy."
url <- "https://doi.org/10.1594/PANGAEA.789801, https://doi.org/10.1080/15226514.2013.798626"
license <- "CC-BY-3.0"


# reference ----
#
bib <- ris_reader(paste0(thisPath, "Perrino_2012.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-02-20"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_tsv(file = paste0(thisPath, "Perrino_2012.tab"), skip = 36)


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
    date = ymd(`Date/Time`),
    externalID = `Sample label`,
    externalValue = "Herbaceous associations",
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring") %>%
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
