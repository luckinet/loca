# script arguments ----
#
thisDataset <- "Moghaddam2014"
description <- "This data set contains in situ vegetation data collected at several forest sites as a part of the Soil Moisture Active Passive Validation Experiment 2012 (SMAPVEX12)."
url <- "https://doi.org/10.5067/ZOBW4CNJZAW1 https://"
licence <- ""


# reference ----
#
bib <- bibentry(
  title = "SMAPVEX12 In Situ Vegetation Data for Forest Area, Version 1",
  bibtype = "Misc",
  doi = "https://doi.org/10.5067/ZOBW4CNJZAW1",
  institution = "NASA National Snow and Ice Data Center Distributed Active Archive Center",
  author = person(c("Mahta", "Moghaddam"))
)

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-11"),
           type = "static",
           licence = licence,
           contact = "mmoghadd@umich.edu",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Field_Sites_ver4_coords.csv"))


# pre-process data ----
#
temp <- data %>%
  st_as_sf(., coords = c("X", "Y"), crs = 32614) %>%
  st_transform(., crs = 4326)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "USA",
    x = st_coordinates(.)[,1],
    y = st_coordinates(.)[,2],
    geometry = geometry,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = 2012,
    # month = "6_7",
    externalID = as.character(OBJECTID),
    externalValue = "Naturally Regenerating Forest",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(month, sep = "_") %>%
  mutate(
    date = ymd(paste0(year, "-", month, "-01")),
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
