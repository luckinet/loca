# script arguments ----
#
thisDataset <- "Gibson2011"
description <- "Primary tropical forests sustain the majority of Earth's terrestrial biodiversity, but they have faced considerable degradation, and in many locations have been replaced by agriculture, plantations and secondary forests. A meta-analysis of the biodiversity consequences of such changes in land use suggests that with the possible exception of selective logging, all changes from primary forest cause substantial falls in biodiversity, and secondary forests are poor substitutes for primary forest."
url <- "https://doi.org/10.1038/nature10425 https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "10.1038_nature10425-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-25"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xls(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "41586_2011_BFnature10425_MOESM254_ESM.xls"), sheet = 1) %>%
  left_join(read_xls(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "41586_2011_BFnature10425_MOESM254_ESM.xls"), sheet = 2), by = "study.ID")


# harmonise data ----
#
temp <- data %>%
  separate(latitude, c("y","y_direction"), sep = " ") %>%
  separate(longitude, c("x","x_direction"), sep = " ") %>%
  mutate(y = as.double(y),
         x = as.double(x)) %>%
  mutate(y = case_when(y_direction == "S" ~ y * -1,
                       y_direction == "N" ~ y),
         x = case_when(x_direction == "W" ~ x * -1,
                       TRUE ~ x)) %>%
  distinct(x, y, study.ID, disturbance.specific, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = x,
    y = y,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = as.character(row.ID),
    externalValue = disturbance.specific,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "meta study",
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

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
