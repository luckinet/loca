# script arguments ----
#
thisDataset <- "Caughlin2016"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "")) # or bibtex_reader()

regDataset(name = thisDataset,
           description = "",
           url = "", # ideally the doi, but if it doesn't have one, the main source of the database
           download_date = "", # YYYY-MM-DD
           type = "", # dynamic or static
           licence = "",
           contact = "", # optional, if it's a paper that should be "see corresponding author"
           disclosed = "", # whether the data are freely available "yes"/"no"
           bibliography = bib,
           update = TRUE)


# pre-process data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#
# (unzip/tar)
# unzip(exdir = thisPath, zipfile = paste0(thisPath, ""))
# untar(exdir = thisPath, tarfile = paste0(thisPath, ""))

# (make sure the result is a data.frame)
data <- read_csv(file = paste0(thisPath, ""))
# data <- read_tsv(file = paste0(thisPath, ""))
# data <- st_read(dsn = paste0(thisPath, "")) %>% as_tibble()
# data <- read_excel(path = paste0(thisPath, ""))


# manage ontology ---
#
# define labels in the new dataset and their matching already harmonised labels
matches <- tibble(new = c(...),
                  old = c(...))
# getConcept(label_en = matches$old, missing = TRUE)

newConcept(new = c(),
           broader = c(), # the labels 'new' should be nested into
           class = , # try to keep that as conservative as possible and only come up with new classes, if really needed
           source = thisDataset)

getConcept(label_en = matches$old) %>%
  # ... %>% apply some additional filters (optional)
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = , # in most cases that should be "close", see ?newMapping
             source = thisDataset,
             certainty = ) # value from 1:3


# harmonise data ----
#
# carry out optional corrections and validations ...


# ... and then reshape the input data into the harmonised format
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = , # "point" or "areal" (such as plot, region, nation, etc)
    x = , # x-value of centroid
    y = , # y-value of centroid
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
