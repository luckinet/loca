# script arguments ----
#
thisDataset <- "vanHooft2015"
description <- ""
url <- "https://doi.org/ https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "10.1371_journal.pone.0111778.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd(),
           type = NA_character_,
           licence = licence,
           contact = NA_character_,
           disclosed = NA,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Ecological data Van Hooft et al. 2014.csv"))


# harmonise data ----
#
temp <- data %>%
  distinct(`longitude (degrees, dec.)`, `latitude (degrees, dec.)`, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "South Africa",
    x = `longitude (degrees, dec.)`,
    y = `latitude (degrees, dec.)`,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = "9-1998_10-1998_11-1998",
    # month = NA_real_,
    # day = NA_integer_,
    externalID = NA_character_,
    externalValue = "buffalo",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_") %>%
  separate(year, sep = "-", into = c("month", "year")) %>%
  mutate(year = as.numeric(year),
         month = as.numeric(month),
         fid = row_number()) %>%
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
