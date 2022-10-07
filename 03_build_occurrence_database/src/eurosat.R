# author and date of creation ----
#
# Steffen Ehrmann, 17.12.2021
# Peter Pothmann,
# Konrad Adler,


# script description ----
#
# This document serves as a protocol, documenting the process of building the
# database of point data for LUCKINet. Don't run this script manually, as it is
# sourced from 'build_global_pointDB.R'.


# load packages ----
#


# script arguments ----
#
thisDataset <- ""
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- ris_reader(paste0(thisPath, ""))

regDataset(name = thisDataset,
           description = "",
           url = "", # ideally the doi, but if it doesn't have one, the main source of the database
           download_date = "", # YYYY-MM-DD
           type = "", # dynamic or static
           licence = "", # optional
           contact = "", # optional, if it's a paper that should be "see corresponding author"
           disclosed = "", # whether the data are freely available "yes"/"no"
           bibliography = bib,
           update = TRUE)

# preprocess data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#
data <- read_csv(paste0(thisPath, ""))# %>% as_tibble() in case this results not in a tibble (but, for example an sf object)

# harmonise data ----
#
add_concept(ontoDir = paste0(dataDir, "ontology.rds"),
            term = ,
            class = )

add_relation(ontoDir = paste0(dataDir, "ontology.rds"),

)


temp <- data %>%
  mutate(
    fid = row_number(),
    x = ,
    y = ,
    year = ,
    month = ,
    day = ,
    datasetID = thisDataset,
    country = NA_character_,
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = ,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "", # "field", "visual interpretation", "experience" or "meta study"
    collector = "", # "expert", "citizen scientist" or "student"
    purpose = "", # "monitoring", "validation", "study" or "map development"
    epsg = 4326) %>%   # see https://epsg.io for other codes
  select(fid, datasetID, x, y, epsg, country, year, month, day, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())

# before preparing data for storage, test that all variables are available
assertNames(x = names(temp),
            must.include = c("fid", "datasetID", "x", "y", "epsg", "country",
                             "year", "month", "day", "irrigated", "externalID",
                             "externalValue", "LC1_orig", "LC2_orig", "LC3_orig",
                             "sample_type", "collector", "purpose"))

# make points and attributes table
points <- temp %>%
  select(fid, x, y)

attributes <- temp %>%
  select(-x, -y)

# make a point geom and set the attribute table
geom <- points %>%
  gs_point() %>%
  setFeatures(table = attributes)


# write output ----
#
saveDataset(object = geom, dataset = thisDataset)
