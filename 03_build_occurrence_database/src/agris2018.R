# script arguments ----
#
thisDataset <- "agris2018"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "agrisexport.ris"))

# column         type            description
# name
# description    [character]   description of the data-set
# url            [character]   ideally the doi, but if it doesn't have one, the
#                              main source of the database
# donwload_date  [POSIXct]     the date (DD-MM-YYYY) on which the data-set was
#                              downloaded
# type           [character]   "dynamic" (when the data-set updates regularly)
#                              or "static"
# license        [character]   abbreviation of the license under which the
#                              data-set is published
# contact        [character]   if it's a paper that should be "see corresponding
#                              author", otherwise some listed contact
# disclosed      [logical]
# bibliography   [handl]       bibliography object from the 'handlr' package
# path           [character]   the path to the occurrenceDB

description <- "This point feature class contains the locations of all 87 experimental forests, ranges and watersheds, including cooperating experimental areas."
url <- "https://data.amerigeoss.org/tl/dataset/experimental-forest-and-range-locations-feature-layer"
license <- ""

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("28-10-2020"),
           type = "static",
           licence = license,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           path = occurrenceDBDir)


# pre-process data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#

data <- read_csv(file = paste0(thisPath, "Experimental_Forest_and_Range_Locations__Feature_Layer_.csv"))

# manage ontology ---
#
newConcepts <- tibble(target = c("Forests", "Inland waters", "Herbaceous associations",
                                 "FOREST AND SEMI-NATURAL AREAS"),
                      new = unique(data$TYPE),
                      class = "landcover",
                      description = NA,
                      match = "close",
                      certainty = 3)

luckiOnto <- new_source(name = thisDataset,
                        description = description,
                        date = Sys.Date(),
                        homepage = url,
                        license = license,
                        ontology = luckiOnto)

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
#
# column         type            description
# type           [character]  *  "point" or "areal" (when its from a plot,
#                                region, nation, etc)
# country        [character]  *  the country of observation
# x              [numeric]    *  x-value of centroid
# y              [numeric]    *  y-value of centroid
# geometry       [sf]            in case type = "areal", this should be the
#                                geometry column
# epsg           [numeric]    *  the EPSG code of the coordinates or geometry
# area           [numeric]       in case the features are from plots and the
#                                table gives areas but no 'geometry' is
#                                available
# date           [POSIXct]    *  see lubridate-package. These can be very easily
#                                created for instance with dmy(SURV_DATE), if
#                                its in day/month/year format
# externalID     [character]     the external ID of the input data
# externalValue  [character]  *  the external target label
# irrigated      [logical]       the irrigation status, in case it is provided
# presence       [logical]       whether the data are 'presence' data (TRUE), or
#                                whether they are 'absence' data (i.e., that the
#                                data point indicates the value in externalValue
#                                is not present) (FALSE)
# LC1/2/3_orig   [character]     if externalValue is associated with one or more
#                                landcover values, provide them here
# sample_type    [character]  *  "field", "visual interpretation", "experience",
#                                "meta study" or "modelled"
# collector      [character]  *  "expert", "citizen scientist" or "student"
# purpose        [character]  *  "monitoring", "validation", "study" or
#                                "map development"
#
# - columns with a * are obligatory, i.e., their default value below needs to be
# replaced

temp <- data %>%
  rowwise() %>%
  mutate(
    year = paste0(seq(from = ESTABLISHED, to = year(Sys.Date()), 1), collapse = "_") # check if the to year is still correct
  )

temp <- temp %>%
  separate_rows(year, sep = "_") %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "USA",
    x = X,
    y = Y,
    geometry = NA,
    epsg = 4326,
    area = HECTARES * 10000,
    date = ymd(paste0(year, "-01-01")),
    externalID = as.character(OBJECTID),
    externalValue = TYPE,
    irrigated = NA,
    presence = T,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "map development") %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated,presence, LC1_orig, LC2_orig,
         LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(path = occurrenceDBDir, name = thisDataset)

write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
