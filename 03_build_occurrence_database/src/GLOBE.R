# script arguments ----
#
thisDataset <- "GLOBE"
description <- "This tool allows you to find and retrieve GLOBE data using several different search parameters.You will be presented a summary of sites that have data available based on your search parameters.From those sites you can further refine your search and or download the data into a CSV file for detailed analysis.A summary CSV file is also available that summarizes the amount of data available for each site."
url <- "https://doi.org/ https://datasearch.globe.gov/"
licence <- ""


# reference ----
#
bib <- bibentry(bibtype = "Misc",
                title = "Global Learning and Observations to Benefit the Environment (GLOBE) Program",
                url = "https://www.globe.gov/",
                note = "'Filter by Protocol' == 'Land Cover'")

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-05-30"),
           type = "dynamic",
           licence = licence,
           contact = NA_character_,
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "GLOBEMeasurementData-17618.csv"))
data <- data[-1,]


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = as.numeric(longitude),
    y = as.numeric(latitude),
    geometry = NA,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = year(measured_on),
    # month = month(measured_on),
    # day = day(measured_on),
    externalID = NA_character_,
    externalValue = `land covers:muc description`,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "field",
    collector = "citizen scientist",
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

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
