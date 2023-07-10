# script arguments ----
#
thisDataset <- "DATAMAN"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1537253750.bib"))

regDataset(name = thisDataset,
           description = "The DATAMAN is a database of greenhouse gas emissions from manure management.",
           url = "https://www.dataman.co.nz/Home/About",
           download_date = "2022-01-05",
           type = "static",
           licence = "https://www.dataman.co.nz/Home/TermsOfUse",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#
data <- read_csv(paste0(thisPath, "DataManField_All_20220105010955.csv"))


# manage ontology ---
#
matches <- tibble(new = c(unique(data$CropType)),
                  old = c("Grass and fodder crops", "Permanent cropland", "Permanent cropland", "Open spaces with little or no vegetation", "Mixed cereals",
                          "maize", "Permanent cropland", NA, NA))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = c(3, 1, 2, 2, 3, 3, 2, 3, 3))


# harmonise data ----
#
data <- data %>% drop_na(Latitude, Longitude)

# preprocess - make it tidy
start <- data %>% select(-StartGasMeasurements, -EndGasMeasurements) %>%
  rename(date = ApplicStartDate)
middle <-  data %>% select(-ApplicStartDate, -EndGasMeasurements) %>%
  rename(date = StartGasMeasurements)
end <- data %>% select(-ApplicStartDate, -StartGasMeasurements) %>%
  rename(date =EndGasMeasurements)

temp <- bind_rows(start, middle, end)

temp <- temp %>%
  distinct(TrialDescription, CropType, Latitude, Longitude, date, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = Latitude,
    y = Longitude,
    date = dmy_hms(date),
    country = Country,
    irrigated = FALSE,
    area = NA_real_,
    presence = TRUE,
    externalID = as.character(Id),
    externalValue = CropType,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    geometry = NA,
    sample_type = "meta study",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())

# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
