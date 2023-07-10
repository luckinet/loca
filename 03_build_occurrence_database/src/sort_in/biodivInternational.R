# script arguments ----
#
thisDataset <- "biodivInternational"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

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

description <- "Studying temporal changes in genetic diversity depends upon the availability of comparable time series data. Plant genetic resource collections provide snapshots of the diversity that existed at the time of collecting and provide a baseline against which to compare subsequent observations."
url <- "https://doi.org/10.1007/s10722-015-0231-9"
license <- ""

# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1007_s10722-015-0231-9-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2020-10-27",
           type = "static",
           licence = "",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#
data <- read_csv(paste0(thisPath, "export_1603813703.csv")) %>%
  bind_rows(read_csv(paste0(thisPath, "export_1603813923.csv"))) %>%
  bind_rows(read_csv(paste0(thisPath, "export_1603813979.csv")))


# manage ontology ---
#
newConcepts <- tibble(target = c("VEGETABLES", "Tree orchards", "Leguminous crops",
                                 NA, "Spice crops", "Planted Forest",
                                 "Oilseed crops", "Roots and Tubers", "Leguminous crops",
                                 "CEREALS", NA, "Grass crops",
                                 "Fibre crops", "Heterogeneous semi-natural areas", "Spice crops",
                                 NA, NA, NA,
                                 "Grass crops", "Herbaceous associations", "cocoa beans",
                                 NA, "Other fodder crops", "FRUIT",
                                 "Tree orchards", "SUGAR CROPS", "Medicinal crops",
                                 NA, NA, NA),
                      new = unique(data$Speciestype),
                      class = c("group", "land-use", "class",
                                NA, "class", "land-use",
                                "class", "class", "class",
                                "group", NA, "class",
                                "class", "landcover", "class",
                                NA, NA, NA,
                                "class", "landcover", "commodity",
                                NA, "class", "group",
                                "class", "group", "class",
                                NA, NA, NA),
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
  select(-End_Date) %>%
  separate(Start_Date, sep = "/", into = c("year", "month")) %>%
  mutate(month = replace(month, is.na(month), "01"))

temp <- data %>%
  select(-Start_Date) %>%
  separate(End_Date, sep = "/", into = c("year", "month")) %>%
  mutate(month = replace(month, is.na(month), "01")) %>%
  bind_rows(temp)

temp <- temp %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = tolower(Country_Name),
    x = LONGITUDEdecimal,
    y = LATITUDEdecimal,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = paste0(year, "-", month, "-01"),
    externalID = as.character(ID_SUB_MISSION),
    externalValue = Speciestype,
    irrigated = NA,
    presence = T,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated,presence, LC1_orig, LC2_orig,
         LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(path = occurrenceDBDir, name = thisDataset)

write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")

