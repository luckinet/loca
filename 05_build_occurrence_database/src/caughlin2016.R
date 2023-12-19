# script arguments ----
#
thisDataset <- "Caughlin2016"
description <- ""
url <- "https://doi.org/10.1002/eap.1436 https://doi.org/10.5061/dryad.t6md2"
licence <- ""


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "pericles_1939558226.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-06-04"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- st_read(dsn = paste0(occurrenceDBDir, "00_incoming/", thisDataset))


# pre-process data ----
#
temp <- data %>%
  select(Name,geometry) %>%
  as_tibble()

data <- data %>%
  st_make_valid() %>%
  mutate(area = st_area(.)) %>%
  st_centroid() %>%
  mutate(x = st_coordinates(.)[,1],
         y = st_coordinates(.)[,2]) %>%
  left_join(temp, by = "Name")


# harmonise data ----
#
temp <- data %>%
  mutate(date = "01-01-2008_01-01-2009_01-01-2010_01-01-2011_01-01-2012_01-12-2013_01-12-2014") %>%
  separate_rows(date, sep = "_") %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Panama",
    x = x,
    y = y,
    geometry = geometry.y,
    epsg = 4326,
    area = as.numeric(area),
    date = dmy(date),
    externalID = as.character(Name),
    externalValue = "Forests",
    irrigated = FALSE,
    presence = FALSE,
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
