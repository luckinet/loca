# script arguments ----
#
thisDataset <- ""
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- ""
url <- ""    # ideally the doi, but if it doesn't have one, the main source of the database
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
    type = ,                    # [character] "point" or "areal" (when its from
                                #   a plot, region, nation, etc)
    country = NA_character_,    # [character] the country of observation
    x = ,                       # [numeric] x-value of centroid
    y = ,                       # [numeric] y-value of centroid
    geometry = NA,              # [sf] in case type = "areal", this should be
                                #   the geometry column
    epsg = 4326,                # [numeric] the EPSG code of the coordinates or
                                #   geometry
    area = ,                    # [numeric] in case the features are from plots
                                #   and the table gives areas but no 'geometry'
                                #   is available
    date = ,                    # [POSIXct] see lubridate-package. These can be
                                #   very easily created for instance with
                                #   dmy(SURV_DATE), if its in day/month/year
                                #   format
    externalID = NA_character_, # [character] the external ID of the input data
    externalValue = ,           # [character] the external target label
    irrigated = NA,             # [logical] the irrigation status, in case it is
                                #   provided
    presence = ,                # [logical] whether the data are 'presence' data
                                #   (TRUE), or whether they are 'absence' data
                                #   (i.e., that the data point indicates the
                                #   value in externalValue is not present)
                                #   (FALSE)
    LC1_orig = NA_character_,   # [character] if externalValue is associated
    LC2_orig = NA_character_,   #    with one or more landcover values, provide
    LC3_orig = NA_character_,   #    them here
    sample_type = ,             # [character] "field", "visual interpretation",
                                #   "experience", "meta study" or "modelled"
    collector = ,               # [character] "expert", "citizen scientist" or
                                #   "student"
    purpose = ) %>%             # [character] "monitoring", "validation",
                                #   "study" or "map development"
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated,presence, LC1_orig, LC2_orig,
         LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(path = occurrenceDBDir, name = thisDataset)

write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
