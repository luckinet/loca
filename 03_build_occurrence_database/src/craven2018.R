# script arguments ----
#
thisDataset <- "Craven2018"
description <- "OpenNahele is the first database that compiles data from a large number of forest plots across the Hawaiian archipelago to allow broad and high resolution studies of biodiversity patterns."
url <- "https://doi.org/10.3897/BDJ.6.e28406 https://"
licence <- "CC-Zero"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Bibtex.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-20"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "OpenNahele_Tree_Data.csv"))


# harmonise data ----
#
temp <- data %>%
  distinct(Longitude, Latitude, Year, Plot_Area, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "United States",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = Plot_Area,
    date = NA,
    # year = Year,
    # month = NA_real_,
    # day = NA_integer_,
    externalID = NA_character_,
    externalValue = "Forests",
    irrigated = NA,
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

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
