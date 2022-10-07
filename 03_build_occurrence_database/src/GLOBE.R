# script arguments ----
#
thisDataset <- "GLOBE"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibentry(bibtype = "Misc",
                title = "Global Learning and Observations to Benefit the Environment (GLOBE) Program",
                url = "https://www.globe.gov/",
                note = "'Filter by Protocol' == 'Land Cover'")

regDataset(name = thisDataset,
           description = "This tool allows you to find and retrieve GLOBE data using several different search parameters.You will be presented a summary of sites that have data available based on your search parameters.From those sites you can further refine your search and or download the data into a CSV file for detailed analysis.A summary CSV file is also available that summarizes the amount of data available for each site.",
           url = "https://datasearch.globe.gov/",
           download_date = "2022-05-30",
           type = "dynamic",
           licence = "",
           contact = "",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# pre-process data ----
#


# read dataset ----
#

data <- read_csv(file = paste0(thisPath, "GLOBEMeasurementData-17618.csv"))
data <- data[-1,]


# manage ontology ---
#
matches <- read_csv(file = paste0(thisPath, "GLOBE_ontology.csv"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)


# harmonise data ----
#

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = as.numeric(longitude),
    y = as.numeric(latitude),
    geometry = NA,
    year = year(measured_on),
    month = month(measured_on),
    day = day(measured_on),
    country = NA_character_,
    irrigated = F,
    area = NA_real_,
    presence = T,
    externalID = NA_character_,
    externalValue = `land covers:muc description`,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "citizen scientist",
    purpose = "monitoring",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
