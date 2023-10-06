# script arguments ----
#
thisDataset <- "Jackson2007"
description <- "This data set contains various vegetation parameters for several locations from Oklahoma North (ON) and Oklahoma South (OS)."
url <- "https://doi.org/10.5067/A1E1EWIHPHAO https://"
licence <- ""


# reference ----
#
bib <- bibentry(
  bibtype = "Misc",
  title = "SMEX03 Vegetation Data: Oklahoma, Version 1",
  year = "2007",
  institution = "NASA National Snow and Ice Data Center Distributed Active Archive Center",
  doi = "https://doi.org/10.5067/A1E1EWIHPHAO",
  author = c(
    person(c("T.", "Jackson")),
    person(c("L.", "McKee"))))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-22"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_delim(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "SMEX03_Raw_MSR_Overpass.txt"), delim = "\t", skip = 2)
data <- data[-1,]


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "USA",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = mdy(X3),
    externalID = NA_character_,
    externalValue = X2,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
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

# matches <- tibble(new = c(tolower(unique(data$X2))),
#                   old = c("Permanent grazing", NA, "maize", NA,
#                           "Inland waters", "alfalfa", NA, "soybean"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
