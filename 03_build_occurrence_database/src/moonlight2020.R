# script arguments ----
#
thisDataset <- "Moonlight2020"
description <- "Data package of Nordeste Brazilian Caatinga Long-term Inventory plots."
url <- "https://doi.org/10.5521/forestplots.net/2020_7 https://"
license <- "CC BY-SA 4.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "ref.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-08-06"),
           type = "dynamic",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "forestPlots_Moonlight.xlsx"), sheet = 3)


# pre-process data ----
#
data <- data %>%
  mutate(
    `Forest Status` = case_when(`Forest Status` == "Grazed" ~ paste0("Grazed_Forest"),
                                TRUE ~ as.character(`Forest Status`))) %>%
  separate_rows(`Forest Status`, sep = "_")


# harmonise data ----
#
temp <- data %>%
  separate(`Last Census Date`, into = c("year", "rest"))

temp <- temp %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = tolower(Country),
    x = `Longitude Decimal`,
    y = `Latitude Decimal`,
    geometry = NA,
    epsg = 4326,
    area = `Ground Area (ha)` * 10000,
    date = ymd(paste0(year, "-01-01")),
    externalID = `Plot Code`,
    externalValue = `Forest Status`,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring") %>%
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

# newConcepts <- tibble(target = c("Undisturbed Forest", "Naturally Regenerating Forest", "Naturally Regenerating Forest",
#                                  "Naturally Regenerating Forest", "Temporary grazing", "Forests"),
#                       new =  unique(data$`Forest Status`),
#                       class = c("land-use", "land-use", "land-use",
#                                 "land-use", "land-use", "landcover"),
#                       description = NA,
#                       match = "close",
#                       certainty = 3)

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
