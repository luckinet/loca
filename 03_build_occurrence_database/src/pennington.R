# script arguments ----
#
thisDataset <- "Pennington2018"
description <- "Forest plot inventory data from seasonally dry and moist Atlantic forest in Rio de Janeiro State"
url <- "http://dx.doi.org/10.5521/forestplots.net/2018_3"
license <- "CC-BY-SA 4"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Pennington.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-08-06"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "forestPlots_Pennington.csv"))


# pre-process data ----
#
data <- data %>%
  separate(`Last Census Date`, into = c("yearL", "rest"))
data <- data %>%
  separate(`Date Established`, into = c("yearF", "rest"))
data$year <- paste(data$yearL, data$yearF, sep = "_")
data <- data %>%
  separate_rows(year, sep = "_")


# harmonise data ----
#
temp <- data %>%
  distinct(year, `Longitude Decimal`, `Latitude Decimal`, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = tolower(Country),
    x = `Longitude Decimal`,
    y = `Latitude Decimal`,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(paste0(year, "-01-01")),
    externalID = `Plot Code`,
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
