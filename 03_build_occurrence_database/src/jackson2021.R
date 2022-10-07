# script arguments ----
#
thisDataset <- "Jackson2007"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

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
           description = "This data set contains various vegetation parameters for several locations from Oklahoma North (ON) and Oklahoma South (OS).",
           url = "https://doi.org/10.5067/A1E1EWIHPHAO",
           download_date = "2022-01-22",
           type = "static",
           licence = NA_character_,
           contact = NA_character_,
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_delim(paste0(thisPath, "SMEX03_Raw_MSR_Overpass.txt"), delim = "\t", skip = 2)
data <- data[-1,]

# manage ontology ---
#
matches <- tibble(new = c(tolower(unique(data$X2))),
                  old = c("Permanent grazing", NA, "maize", NA,
                          "Inland waters", "alfalfa", NA, "soybean"))

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
    fid = row_number(),
    x = Longitude,
    y = Latitude,
    date = mdy(X3),
    datasetID = thisDataset,
    country = "USA",
    irrigated = F,
    type = "point",
    geometry = NA,
    area = NA_real_,
    presence = TRUE,
    externalID = NA_character_,
    externalValue = X2,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")

