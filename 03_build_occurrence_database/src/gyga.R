# script arguments ----
#
thisDataset <- "gyga"
description <- ""
url <- "https://doi.org/ https://"
licence <- "CC BY-NC-SA 3.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "")) # or bibtex_reader()

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd(),
           type = "static",
           licence = licence,
           contact = NA_character_,
           disclosed = NA,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
if(!"full_dataset.rds" %in% list.files(occurrenceDBDir, "00_incoming/", thisDataset, "/")){
  gygaFiles <- list.files(occurrenceDBDir, "00_incoming/", thisDataset, "/", pattern = "xlsx", full.names = TRUE)
  map(.x = seq_along(gygaFiles), .f = function(ix){
    read_excel(path = gygaFiles[ix], sheet = 2)
  }) %>%
    bind_rows() %>%
    saveRDS(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "/full_dataset.rds"))
}

data <- read_rds(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "full_dataset.rds"))


# harmonise data ----
#
temp <- data %>%
  separate(CROP,sep = " ", into = c("irrigated", "crop"), extra = "merge") %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = NA_character_,
    country = COUNTRY,
    x = LONGITUDE,
    y = LATITUDE,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = crop,
    irrigated = case_when(irrigated == "Irrigated" ~ T,
                          irrigated == "Rainfed" ~ F),
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
