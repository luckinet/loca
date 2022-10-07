# script arguments ----
#
thisDataset <- "Bosch2008"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibentry(
  bibtype = "misc",
  title = "SMEX03 Vegetation Data: Georgia, Version 1",
  author = as.person("D. Bosch [aut], L. Marshall [aut], D. Rowland [aut], J. Jacobs [aut]"),
  year = "2008",
  organization = "NASA National Snow and Ice Data Center Distributed Active Archive Center",
  address = "Boulder, Colorado USA",
  doi = "https://doi.org/10.5067/UAPN8GAYSU83",
  url = "https://nsidc.org/data/NSIDC-0298/versions/1",
  type = "data set"
)

regDataset(name = thisDataset,
           description = "This data set includes data collected over the Soil Moisture Experiment 2003 (SMEX03) area of Georgia, USA.",
           url = "https://nsidc.org/data/NSIDC-0298/versions/1",
           type = "static",
           licence = "",
           bibliography = bib,
           download_date = "2021-09-13",
           contact = "see corresponding author",
           disclosed = "yes",
           update = TRUE)


# read dataset ----
#
data <- read_tsv(paste0(DBDir, thisDataset, "/GA_SMEX03_vegetation_raw.txt"), skip =  1)
data <- data[-1,]

# manage ontology ---
#
matches <- tibble(new = c(unique(data$Crop)),
                  old = c("cotton", "peanut", "Permanent grazing", "cotton"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)

# harmonise data ----
#
unique_data <- data %>%
  mutate_if(is.double,~na_if(.,-99.000)) %>%
  filter(!is.na(Longitude) | !is.na(Latitude)) %>%
  distinct(Site, Crop, Date, Latitude, Longitude, .keep_all = T)

temp <- unique_data %>%
  mutate(fid = row_number(),
         date = mdy(Date),
         x = Longitude,
         y = Latitude,
         country = "United States",
         irrigated = FALSE,
         presence = TRUE,
         area = NA_real_,
         type = "point",
         geometry = NA,
         datasetID = thisDataset,
         geometry = NA,
         LC1_orig = NA_character_,
         LC2_orig = NA_character_,
         LC3_orig = NA_character_,
         externalID = Site,
         externalValue = Crop,
         sample_type = "field",
         collector = "expert",
         purpose = "study",
         epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())

# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")

