# script arguments ----
#
thisDataset <- "Lamond2014"
description <- "CAFNET research has elicited local agro-ecological knowledge from coffee growing areas within the vicinity of forest reserves in Kenya, Uganda and Rwanda. Knowledge was acquired from over 200 farmers in a stratified purposive sample, using a knowledge based systems approach. Ranking and phenology survey Building on the local knowledge studies and on-farm tree inventories, we designed a ranking and phenology survey to be applied across the 100 farms in the three counties to test consistency of farmer knowledge about physical attributes and phenology of trees found in coffee plots and along coffee plot boundaries. (2014-03) "
url <- "https://doi.org/10.34725/DVN/25331 https://"
licence <- "CC BY-NC-SA 3.0"


# reference ----
#
bib <- ris_reader(paste0(thisPath, "doi 10.34725_DVN_25331.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-05-31"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
dataK <- read_tsv(file = paste0(thisPath, "Farm_GPS_data_Kenya.tab"))
dataR <- read_tsv(file = paste0(thisPath, "Farm_GPS_data_Rwanda.tab"))
dataU <- read_excel(paste0(thisPath, "Farm_GPS_data_Uganda.xlsx"))


# pre-process data ----
#
dataK <- dataK %>%
  mutate(country = "Kenya",
         Farm_number = Farm,
         Cooperative = Factory)

dataR <- dataR %>%
  mutate(country = "Rwanda")

dataU <- dataU %>%
  mutate(country = "Uganda",
         "Lat(S)" = `Lat (S)`,
         "Long(E)" = `Long (E)`)

data <- bind_rows(dataR, dataU, dataK)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = `Lat(S)`,
    y = `Long(E)`,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = "2009_2010_2011",
    # month = NA_real_,
    # day = NA_integer_,
    externalID = NA_character_,
    externalValue = "coffee",
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = as.numeric(year),
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
