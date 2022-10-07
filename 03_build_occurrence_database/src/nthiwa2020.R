# script arguments ----
#
thisDataset <- "Nthiwa2020"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "S0167587719305380.ris"))

regDataset(name = thisDataset,
           description = "",
           url = "",
           download_date = "2022-05-30",
           type = "",
           licence = "CC BY 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# pre-process data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#

data <- read_excel(paste0(thisPath, "S3_Data.xlsx"))

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

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    type = "point", # "point" or "areal" (such as plot, region, nation, etc)
    x = eastings, # x-value of centroid
    y = southings, # y-value of centroid
    geometry = NA,
    year = "9-2016_10-2016_11-2016_12-2016_1-2017_2-2017_3-2017_4-2017_5-2017_6-2017_8-2017",
    month = NA_real_,
    day = NA_integer_, # must be NA_integer_ if it's not given
    country = "kenya",
    irrigated = F, # in case the irrigation status is provided
    area = NA_real_, # in case the features are from plots and the table gives areas but no spatial object is available
    presence = F, # whether the data are 'presence' data (TRUE), or whether they are 'absence' data (i.e., that the data point indicates the value in externalValue is not present) (FALSE)
    externalID = NA_character_,
    externalValue = "cattle",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field", # "field", "visual interpretation", "experience", "meta study" or "modelled"
    collector = "expert", # "expert", "citizen scientist" or "student"
    purpose = "study", # "monitoring", "validation", "study" or "map development"
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  separate(year, into = c("month", "year")) %>%
  distinct(year, month, x, y, .keep_all = T) %>%
  mutate(year = as.numeric(year),
         month = as.numeric(month),
         fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
