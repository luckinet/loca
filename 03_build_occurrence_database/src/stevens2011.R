# script arguments ----
#
thisDataset <- "Stevens2011"
description <- ""
url <- "https://doi.org/10.6084/m9.figshare.c.3304065.v1 https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "pericles_1939917092.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-06-08"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "environmentaldata.csv"))
data[,34:43] <- NULL

# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = Country,
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = `Survey year`,
    # month = NA_real_,
    # day = NA_integer_,
    externalID = NA_character_,
    externalValue = paste(data$`Mangement type`, data$`Grazing intensity`, sep = "_"),
    irrigated = FALSE,
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

# matches <- tibble(new = c(unique(paste(data$`Mangement type`, data$`Grazing intensity`, sep = "_"))),
#                   old = c("Grass crops", "Temporary grazing", "Temporary grazing", "Permanent grazing", "Herbaceous associations"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
