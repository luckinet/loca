# script arguments ----
#
thisDataset <- "Bastin2017"
description <- "The extent of forest in dryland biomes"
url <- "https://doi.org/10.1126/science.aam6527" # doi, in case this exists and/or download url separated by empty space
licence <- ""


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "csp_356_.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           type = "static",
           licence = licence,
           bibliography = bib,
           download_date = dmy("15-12-2021"),
           contact = "see corresponding author",
           disclosed = TRUE,
           path = occurrenceDBDir)


# read dataset ----
#
unzip(exdir = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/"),
      zipfile = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "aam6527_Bastin_Database-S1.csv.zip"))
data <- read_delim(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "aam6527_Bastin_Database-S1.csv"), delim = ";")


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = dryland_assessment_region,
    x = location_x,
    y = location_y,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd("2015", truncated = 2),
    externalID = NA_character_,
    externalValue = land_use_category,
    irrigated = FALSE,
    presence = if_else(land_use_category == "forest", TRUE, FALSE),
    sample_type = "visual interpretation",
    collector = "citizen scientist",
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
