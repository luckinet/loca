# script arguments ----
#
thisDataset <- ""
description <- ""
url <- "https://doi.org/ https://"
licence <- ""
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(onto_dir, "00_incoming/", thisDataset, "/", "")) # or bibtex_reader()

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd(),
           type = NA_character_,
           licence = licence,
           contact = NA_character_,
           disclosed = NA,
           bibliography = bib,
           path = onto_dir)


# read dataset ----
#
data <- read_csv(file = paste0(onto_dir, "00_incoming/", thisDataset, "/", ""))


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
    externalType = NA_character_,
    irrigated = NA,
    presence = NA,
    sample_type = NA_character_,
    collector = NA_character_,
    purpose = NA_character_) %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, externalType, irrigated, presence,
         sample_type, collector, purpose, everything())


# harmonize with ontology ----
#
new_source(name = thisDataset,
           description = description,
           homepage = url,
           date = Sys.Date(),
           license = licence,
           ontology = onto_path)

landcover <- temp %>%
  filter(externalType == "landcover") %>%
  rename(landcover = externalValue) %>%
  matchOntology(columns = "landcover",
                dataseries = thisDataset,
                ontology = onto_path)

landuse <- temp %>%
  filter(externalType == "landuse") %>%
  rename(landuse = externalValue) %>%
  matchOntology(columns = "landuse",
                dataseries = thisDataset,
                ontology = onto_path)

crop <- temp %>%
  filter(externalType == "crop") %>%
  rename(crop = externalValue) %>%
  matchOntology(columns = "crop",
                dataseries = thisDataset,
                ontology = onto_path)

animal <- temp %>%
  filter(externalType == "animal") %>%
  rename(animal = externalValue) %>%
  matchOntology(columns = "animal",
                dataseries = thisDataset,
                ontology = onto_path)

out <- bind_rows(landcover, landuse, crop, animal)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = occurr_dir, name = thisDataset)

# beep(sound = 10)
message("\n     ... done")



