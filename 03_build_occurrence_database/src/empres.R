# script arguments ----
#
thisDataset <- "empress"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- ""
url <- "https://empres-i.apps.fao.org/"    # ideally the doi, but if it doesn't have one, the main source of the database
license <- ""


# reference ----
#
bib <- ris_reader(paste0(thisPath, "")) # or bibtex_reader()

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "", # YYYY-MM-DD
           type = "", # dynamic or static
           licence = license,
           contact = "", # optional, if it's a paper that should be "see corresponding author"
           disclosed = "", # whether the data are freely available "yes"/"no"
           bibliography = bib,
           path = occurrenceDBDir)


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
newConcepts <- tibble(target = ,
                      new = ,
                      class = ,
                      description = ,
                      match = ,
                      certainty = )

luckiOnto <- new_source(name = thisDataset,
                        description = description,
                        date = Sys.Date(),
                        homepage = url,
                        license = license,
                        ontology = luckiOnto)

# in case new harmonised concepts appear here (avoid if possible)
# luckiOnto <- new_concept(new = , broader = , class = , description = ,
#                          ontology = luckiOnto)

luckiOnto <- new_mapping(new = newConcepts$new,
                         target = get_concept(x = newConcepts %>% select(label = target), ontology = luckiOnto),
                         source = thisDataset,
                         description = newConcepts$description,
                         match = newConcepts$match,
                         certainty = newConcepts$certainty,
                         ontology = luckiOnto, matchDir = paste0(occurrenceDBDir, "01_concepts/"))


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
    date = , # must be 'POSIXct' object, see lubridate-package. These can be very easily created for instance with dmy(SURV_DATE), if its in day/month/year format
    country = NA_character_, # the country of each observation/row
    irrigated = , # in case the irrigation status is provided
    area = , # in case the features are from plots and the table gives areas but no spatial object is available
    presence = , # whether the data are 'presence' data (TRUE), or whether they are 'absence' data (i.e., that the data point indicates the value in externalValue is not present) (FALSE)
    externalID = NA_character_, # the external ID of the input data
    externalValue = , # the column of the land use classification
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = , # "field", "visual interpretation", "experience", "meta study" or "modelled"
    collector = , # "expert", "citizen scientist" or "student"
    purpose = , # "monitoring", "validation", "study" or "map development"
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
