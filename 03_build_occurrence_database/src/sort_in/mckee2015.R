# script arguments ----
#
thisDataset <- "McKee2015"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "")) # or bibtex_reader()

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

description <- "This data set includes in situ vegetation data collected during the Soil Moisture Active Passive Validation Experiment 2008 (SMAPVEX08) campaign. Sampling was designed to coincide with satellite overpasses, such as Landsat's Thematic Mapper (TM) 5 and the Moderate Resolution Imaging Spectroradiometer (MODIS) sensor on NASA's Terra satellite (MODIS/Terra), which can be then used to estimate vegetation water content on the regional scale."
url <- "https://doi.org/10.5067/US4X5QPYH6DB"
license <- ""

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("2022-11-01"),
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

data <- read_excel(path = paste0(thisPath, "SV08V_Sum_VEG_SMAPVEX.xls"), skip = 5)

# manage ontology ---
#
newConcepts <- tibble(target = case_when(str_match(unique(data$Crop), pattern = "SB") == "SB" ~ "soybean",
                                         is.character(unique(data$Crop)) ~ "maize"),
                      new = unique(data$Crop),
                      class = "commodity",
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
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "USA",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(Date),
    externalID = Field,
    externalValue = Crop,
    irrigated = NA,
    presence = T,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "validation") %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated,presence, LC1_orig, LC2_orig,
         LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(path = occurrenceDBDir, name = thisDataset)

write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
