# script arguments ----
#
thisDataset <- "See2016a"
occurrenceDBDir, "00_incoming/", thisDataset, "/" <- paste0(DBDir, thisDataset, "/")
# assertDirectoryExists(x = occurrenceDBDir, "00_incoming/", thisDataset, "/", access = "rw")
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Control_1.ris"))

regDataset(name = thisDataset,
           description = "Global land cover is an essential climate variable and a key biophysical driver for earth system models. While remote sensing technology, particularly satellites, have played a key role in providing land cover datasets, large discrepancies have been noted among the available products. Global land use is typically more difficult to map and in many cases cannot be remotely sensed. In-situ or ground-based data and high resolution imagery are thus an important requirement for producing accurate land cover and land use datasets and this is precisely what is lacking. Here we describe the global land cover and land use reference data derived from the Geo-Wiki crowdsourcing platform via four campaigns.",
           url = "https://doi.org/10.1594/PANGAEA.869660",
           download_date = "2021-09-13",
           type = "static",
           licence = "CC-BY-3.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_tsv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Control_1.tab"), col_types = "", skip = 17)


# manage ontology ---
#
# define labels in the new dataset and their matching already harmonised labels
matches <- tibble(new = c(as.character(unique(data$`LCC (LC1 - This is the choice for ...)`))),
                  old = c("Herbaceous associations", 'Forests',
                          "Shrubland", "Heterogeneous semi-natural areas",
                          "AGRICULTURAL AREAS", "Inland waters",
                          "Open spaces with little or no vegetation"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close", # in most cases that should be "close", see ?newMapping
             source = thisDataset,
             certainty = 3) # value from 1:3


# harmonise data ----
#
# carry out optional corrections and validations ...


# ... and then reshape the input data into the harmonised format
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point", # "point" or "areal" (such as plot, region, nation, etc)
    x = Longitude, # x-value of centroid
    y = Latitude, # y-value of centroid
    geometry = NA,
    year = ,
    month = , # must be NA_real_ if it's not given
    day = , # must be NA_integer_ if it's not given
    country = NA_character_,
    irrigated = , # in case the irrigation status is provided
    area = , # in case the features are from plots and the table gives areas but no spatial object is available
    presence = , # whether the data are 'presence' data (TRUE), or whether they are 'absence' data (i.e., that the data point indicates the value in externalValue is not present) (FALSE)
    externalID = NA_character_,
    externalValue = ,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = , # "field", "visual interpretation", "experience", "meta study" or "modelled"
    collector = , # "expert", "citizen scientist" or "student"
    purpose = , # "monitoring", "validation", "study" or "map development"
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
