# script arguments ----
#
thisDataset <- "Grump"
description <- "The Global Rural-Urban Mapping Project, Version 1 (GRUMPv1): Settlement Points, Revision 01 is an updated version of the Settlement Points, Version 1 (v1) used in the original population reallocation. Revision 01 includes improved geospatial location for selected settlements, as well as new georeferenced settlements. Revision 01 was produced by the Columbia University Center for International Earth Science Information Network (CIESIN) in collaboration with the CUNY Institute for Demographic Research (CIDR)."
url <- "https://doi.org/10.7927/H4BC3WG1 https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(thisPath, "grump-v1-settlement-points-rev01-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-11-15"),
           type = "static",
           licence = licence,
           contact = "Center for International Earth Science Information Network - CIESIN - Columbia University",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "grump-v1-settlement-points-rev01.csv"))


# harmonise data ----
#
temp <- data %>%
  na_if(., -999) %>%
  distinct(Latitude, Longitude, Year, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = Country,
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(paste0(Year, "-01-01")),
    externalID = OBJECTID,
    externalValue = "Urban fabric",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "visual interpretation",
    collector = "expert",
    purpose = "map development") %>%
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
