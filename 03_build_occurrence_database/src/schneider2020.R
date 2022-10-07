# script arguments ----
#
thisDataset <- "Schneider2020"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibentry(
  bibtype = "Misc",
  title = "Southeast Alaska old-growth forest stem map data collected in 1964 on ten 1.42 hectare plots",
  year = "2020",
  url = "https://doi.org/10.2737/RDS-2020-0025",
  adress = "Fort Collins, CO",
  publisher = "Forest Service Research Data Archive",
  author = c(person("Eryn E.", "Schneider"),
             person("Justin S.", "Crotteau, "),
             person("Andrew J", "Larson")
    ))

regDataset(name = thisDataset,
           description = "This data publication includes data used in Spatial aspects of structural complexity in Sitka spruce – western hemlock forests, including evaluation of a new canopy gap delineation method by Schneider and Larson (2017). These data represent trees and plots from a study led by Vernon LaBau for his M.S. Thesis at Oregon State University, which he completed in 1967. Data were collected in 1964 on ten, 1.42 hectare plots (laid out as 5 by 7 chains). Data include tree location within subplots, tree species, diameter at breast height, and height in logs.",
           url = "https://doi.org/10.2737/RDS-2020-0025",
           type = "static",
           licence = "NA",
           bibliography = bib,
           download_date = "2021-12-17",
           contact = "see corresponding author",
           disclosed = "yes",
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Data/Plot_locations.csv"))


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
    x = Longitude,
    y = Latitude,
    month = NA_real_,
    day = NA_real_,
    year = 1964,
    country = "United States of America",
    irrigated = NA_real_,
    externalID = Plot,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326,
    datasetID = thisDataset,
    externalValue = NA_character_,
    luckinetID = 1136,
    fid = row_number()) %>%
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
