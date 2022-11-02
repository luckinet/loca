# script arguments ----
#
thisDataset <- "Lauenroth2019"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "agrisexport.txt"))

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
# contact        [character]   if it's a paper that should be "see corresponding author", otherwise some listed contact
#
# disclosed      [logical]
# bibliography   [handl]       bibliography object from the 'handlr' package
# path           [character]   the path to the occurrenceDB

description <- "This data package was produced by researchers working on the Shortgrass Steppe Long Term Ecological Research (SGS-LTER) Project, administered at Colorado State University. Long-term datasets and background information (proposals, reports, photographs, etc.) on the SGS-LTER project are contained in a comprehensive project collection within the Digital Collections of Colorado (http://digitool.library.colostate.edu/R/?func=collections&collection_id=...). The data table and associated metadata document, which is generated in Ecological Metadata Language, may be available through other repositories serving the ecological research community and represent components of the larger SGS-LTER project collection.
Six sites approximately 6 km apart were selected at the Central Plains Experimental Range in 1997. Within each site, there was a pair of adjacent ungrazed and moderately summer grazed (40-60% removal of annual aboveground production by cattle) locations. Grazed locations had been grazed from 1939 to present and ungrazed locations had been protected from 1991 to present by the establishment of exclosures. Within grazed and ungrazed locations, all tillers and root crowns of B. gracilis were removed from two treatment plots (3 m x 3 m) with all other vegetation undisturbed. Two control plots were established adjacent to the treatment plots. Plant density was measured annually by species in a fixed 1m x 1m quadrat in the center of treatment and control plots. For clonal species, an individual plant was defined as a group of tillers connected by a crown Coffin & Lauenroth 1988, Fair et al. 1999). Seedlings were counted as separate individuals. In the same quadrat, basal cover by species, bare soil, and litter were estimated annually using a point frame. A total of 40 points were read from four locations halfway between the center point and corners of the 1m x 1m quadrat. Density was measured from 1998 to 2005 and cover from 1997 to 2006. All measurements were taken in late June/early July."
url <- "https://doi.org/10.6073/pasta/d0272af6e402fe1fe0c5d218b06cfdcb"
license <- "Creative Commons Attribution"

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("1-06-2022"),
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
data <- read_delim(file = paste0(thisPath, "BOGRRmvlDnsty.txt"))



# manage ontology ---
#
newConcepts <- tibble(target = unique(data$Treatment_Control),
                      new = c("Temporary grazing", "Grass crops"),
                      class = c("land-use", "class"),
                      description = NA,
                      match = "close",
                      certainty = 2)

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
  distinct(Longitude, Latitude, Date, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "USA",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = 9,
    date = mdy(Date),
    externalID = NA_character_,
    externalValue = Treatment_Control,
    irrigated = NA,
    presence = F,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring") %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated,presence, LC1_orig, LC2_orig,
         LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(path = occurrenceDBDir, name = thisDataset)

write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
