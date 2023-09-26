# script arguments ----
#
thisDataset <- "Nthiwa2020"
description <- ""
url <- "https://doi.org/ https://"
licence <- "CC BY 4.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "S0167587719305380.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-05-30"),
           type = NA_character_,
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "S3_Data.xlsx"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "kenya",
    x = eastings,
    y = southings,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = "9-2016_10-2016_11-2016_12-2016_1-2017_2-2017_3-2017_4-2017_5-2017_6-2017_8-2017",
    # month = NA_real_,
    # day = NA_integer_,
    externalID = NA_character_,
    externalValue = "cattle",
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_") %>%
  separate(year, into = c("month", "year")) %>%
  distinct(year, month, x, y, .keep_all = T) %>%
  mutate(year = as.numeric(year),
         month = as.numeric(month),
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
