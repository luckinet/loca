# script arguments ----
#
thisDataset <- "Stephens2017"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibentry(
    bibtype = "Misc",
    title = "Timber survey data from 1911 in the Greenhorn Mountains, Sequoia National Forest",
    author = c(
      person("Scott L." ,"Stephens",  role = "aut", email = "fsrda@fs.fed.us"),
      person("Jamie M.", "Lydersen",  role = "aut"),
      person("Brandon M.", "Collins",  role = "aut"),
      person("Danny L.", "Fry",  role = "aut"),
      person("Marc D.", "Meyer",  role = "aut")),
    doi = "https://doi.org/10.2737/RDS-2017-0064",
    publisher = "Forest Service Research Data Archive",
    address = "Fort Collins, CO",
    year = 2017
)

regDataset(name = thisDataset,
           description = "This data publication contains tabular data with measurements of tree and shrub data for a set of transects located in the Greenhorn Mountains, Sequoia National Forest in California. The transects represent a systematic timber inventory collected across a large mixed-conifer and ponderosa pine dominated landscape by the U.S. Forest Service in 1911. Trees were tallied by species and diameter within 20 x 400 meter strips that spanned the center of quarter-quarter sections (QQs) delineated by the Public Land Survey System. Shrub cover was determined using an ocular estimate and recorded qualitatively by species. Tabular data specifically include cover estimates for Chamaebatia foliolosa and an estimate for all other species as a whole; basal area for the following live trees ≥ 30.5 centimeters (cm) at diameter at breast height (dbh): Abies concolor, Calocedrus decurrens, Pinus lambertiana, Pinus ponderosa, and all conifer trees; as well as density of live conifer trees in three different dbh classes. Also included in this publication are scans of the original data collection sheets recorded in 1911.",
           url = "https://doi.org/10.2737/RDS-2017-0064",
           download_date = "",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Data/Kern1911_TransectData.csv"))


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
    day = NA_real_,
    month = NA_real_,
    year = 1911,
    country = "United States of America",
    irrigated = NA_real_,
    externalID = Lot_id,
    externalLC = NA_character_,
    datasetID = thisDataset,
    externalValue = NA_real_,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = , # "monitoring", "validation", "study" or "map development"
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
