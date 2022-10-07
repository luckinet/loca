# script arguments ----
#
thisDataset <- "biodivInternational"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1007_s10722-015-0231-9-citation.ris")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "Studying temporal changes in genetic diversity depends upon the availability of comparable time series data. Plant genetic resource collections provide snapshots of the diversity that existed at the time of collecting and provide a baseline against which to compare subsequent observations.",
           url = "https://doi.org/10.1007/s10722-015-0231-9",
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
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)


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
    externalID = NA_character_,
    externalValue = ,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = , # "field", "visual interpretation", "experience", "meta study" or "modelled"
    collector = , # "expert", "citizen scientist" or "student"
    purpose = , # "monitoring", "validation", "study" or "map development"
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
