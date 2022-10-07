# script arguments ----
#
thisDataset <- "Moonlight2020"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "ref.bib"))


regDataset(name = thisDataset,
           description = "Data package of Nordeste Brazilian Caatinga Long-term Inventory plots.",
           url = "http://dx.doi.org/https://doi.org/10.5521/forestplots.net/2020_7",
           download_date = "2021-08-06",
           type = "dynamic",
           licence = "CC BY-SA 4.0",
           contact = NA_character_,
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "forestPlots_Moonlight.xlsx"), sheet = 3)


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)
allConcepts <- readRDS(file = paste0(dataDir, "run/global_0.1.0/tables/ids_all_global_0.1.0.rds"))

match <- data %>%
  select(`Forest Status`) %>%
  distinct() %>%
  mutate(term = tolower(`Forest Status`)) %>%
  left_join(allConcepts, by = c("term"))

new <- match %>%
  filter(is.na(luckinetID)) %>%
  mutate(luckinetID = c(1136, 1132, 1132, 1125, 1118))

match <- match %>%
  filter(!is.na(luckinetID)) %>%
  bind_rows(new) %>%
  select(term, luckinetID)

## join tibble
data <- data %>%
  mutate(term = tolower(`Forest Status`)) %>%
  left_join(., match, by = "term")


# harmonise data ----
#
data <- data %>%
  separate(`Last Census Date`, sep= 4, into = c("year", "rest"))

temp <- data %>%
  mutate(
    fid = row_number(),
    x = `Longitude Decimal`,
    y = `Latitude Decimal`,
    luckinetID = ,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    country = tolower(Country),
    irrigated = NA_character_,
    externalID = `Plot Code`,
    externalValue = `Forest Status`,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring",
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
