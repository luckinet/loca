# script arguments ----
#
thisDataset <- "Pennington2018"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Pennington.bib"))

regDataset(name = thisDataset,
           description = ,
           url = "http://dx.doi.org/10.5521/forestplots.net/2018_3",
           download_date = "2021-08-06",
           type = "static",
           licence = "CC-BY-SA 4",
           contact = NA_character_,
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "forestPlots_Pennington.csv"))


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)


# harmonise data ----
#
data <- data %>%
  separate(`Last Census Date`, into = c("yearL", "rest"))
data <- data %>%
  separate(`Date Established`, into = c("yearF", "rest"))
data$year <- paste(data$yearL, data$yearF, sep = "_")
data <- data %>%
  separate_rows(year, sep = "_")

temp <- data %>%
  mutate(
    fid = row_number(),
    x = `Longitude Decimal`,
    y = `Latitude Decimal`,
    luckinetID = 1122,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    country = tolower(Country),
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = NA_character_,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, year, month, day, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())

# before preparing data for storage, test that all required variables are available
assertNames(x = names(temp),
            must.include = c("datasetID", "fid", "country", "x", "y", "epsg",
                             "year", "month", "day", "irrigated",
                             "externalID", "externalValue", "LC1_orig", "LC2_orig", "LC3_orig",
                             "sample_type", "collector", "purpose"))


# write output ----
#
saveDataset(object = temp, dataset = thisDataset)
