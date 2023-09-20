# script arguments ----
#
thisDataset <- "See2022"
occurrenceDBDir, "00_incoming/", thisDataset, "/" <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = occurrenceDBDir, "00_incoming/", thisDataset, "/")
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "")) # or bibtex_reader()

regDataset(name = thisDataset,
           description = "",
           url = "",
           download_date = "",
           type = "",
           licence = ,
           contact = "",
           disclosed = "",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
# (unzip/tar)
# unzip(exdir = occurrenceDBDir, "00_incoming/", thisDataset, "/", zipfile = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", ""))
# untar(exdir = occurrenceDBDir, "00_incoming/", thisDataset, "/", tarfile = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", ""))

# (make sure the result is a data.frame)
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", ""))
# data <- read_tsv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", ""))
# data <- st_read(dsn = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "")) %>% as_tibble()
# data <- read_excel(path = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", ""))


# manage ontology ---
#
matches <- tibble(new = c(...)),
                  old = c(...))

newConcept(new = c(),
           broader = c(),
           class = ,
           source = thisDataset)

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = ,
             source = thisDataset,
             certainty = )


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    x = ,
    y = ,
    year = ,
    month = ,
    day = ,
    country = NA_character_,
    irrigated = NA_character_,
    presence = ,
    externalID = NA_character_,
    externalValue = ,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = , # "field", "visual interpretation", "experience", "meta study" or "modelled"
    collector = , # "expert", "citizen scientist" or "student"
    purpose = , # "monitoring", "validation", "study" or "map development"
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, year, month, day, irrigated, presence,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())

# before preparing data for storage, test that all required variables are available
assertNames(x = names(temp),
            must.include = c("datasetID", "fid", "country", "x", "y", "epsg",
                             "year", "month", "day", "irrigated", "presence",
                             "externalID", "externalValue", "LC1_orig", "LC2_orig", "LC3_orig",
                             "sample_type", "collector", "purpose"))


# write output ----
#
saveDataset(object = temp, dataset = thisDataset)
message("\n---- done ----")
