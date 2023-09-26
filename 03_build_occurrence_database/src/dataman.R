# script arguments ----
#
thisDataset <- "DATAMAN"
description <- "The DATAMAN is a database of greenhouse gas emissions from manure management."
url <- "https://doi.org/ https://www.dataman.co.nz/Home/About"
licence <- "https://www.dataman.co.nz/Home/TermsOfUse"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "pericles_1537253750.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-05"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "DataManField_All_20220105010955.csv"))


# pre-process data ----
#
data <- data %>%
  drop_na(Latitude, Longitude)

start <- data %>%
  select(-StartGasMeasurements, -EndGasMeasurements) %>%
  rename(date = ApplicStartDate)
middle <-  data %>%
  select(-ApplicStartDate, -EndGasMeasurements) %>%
  rename(date = StartGasMeasurements)
end <- data %>%
  select(-ApplicStartDate, -StartGasMeasurements) %>%
  rename(date = EndGasMeasurements)

temp <- bind_rows(start, middle, end)

# harmonise data ----
#
temp <- data %>%
  distinct(TrialDescription, CropType, Latitude, Longitude, date, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = Country,
    x = Latitude,
    y = Longitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = dmy_hms(date),
    externalID = as.character(Id),
    externalValue = CropType,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "meta study",
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

# matches <- tibble(new = c(unique(data$CropType)),
#                   old = c("Grass and fodder crops", "Permanent cropland", "Permanent cropland", "Open spaces with little or no vegetation", "Mixed cereals",
#                           "maize", "Permanent cropland", NA, NA))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
