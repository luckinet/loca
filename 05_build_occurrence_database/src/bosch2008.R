# script arguments ----
#
thisDataset <- "Bosch2008"
description <- "This data set includes data collected over the Soil Moisture Experiment 2003 (SMEX03) area of Georgia, USA."
url <- "https://nsidc.org/data/NSIDC-0298/versions/1 https://"
licence <- ""


# reference ----
#
bib <- bibentry(
  bibtype = "misc",
  title = "SMEX03 Vegetation Data: Georgia, Version 1",
  author = as.person("D. Bosch [aut], L. Marshall [aut], D. Rowland [aut], J. Jacobs [aut]"),
  year = "2008",
  organization = "NASA National Snow and Ice Data Center Distributed Active Archive Center",
  address = "Boulder, Colorado USA",
  doi = "https://doi.org/10.5067/UAPN8GAYSU83",
  url = "https://nsidc.org/data/NSIDC-0298/versions/1",
  type = "data set"
)

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-09-13"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_tsv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/GA_SMEX03_vegetation_raw.txt"), skip =  1)


# pre-process data ----
#
data <- data[-1,]
data <- data %>%
  mutate_if(is.double,~na_if(.,-99.000)) %>%
  filter(!is.na(Longitude) | !is.na(Latitude)) %>%
  distinct(Site, Crop, Date, Latitude, Longitude, .keep_all = T)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "United States",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = mdy(Date),
    externalID = Site,
    externalValue = Crop,
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

# matches <- tibble(new = c(unique(data$Crop)),
#                   old = c("cotton", "peanut", "Permanent grazing", "cotton"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
