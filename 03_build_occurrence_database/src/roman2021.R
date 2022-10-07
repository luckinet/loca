# script arguments ----
#
thisDataset <- "Roman2021"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibentry(
  title = "Philadelphia land cover change data, 1970-2010",
  bibtype = "Misc",
  institution = "Forest Service Research Data Archive",
  url = "https://doi.org/10.2737/RDS-2021-0033",
  author = c(
    person("Lara", "Roman", role = "aut"),
    person("Indigo J.", "Catton", role = "aut"),
    person("Eric J.", "Greenfield", role = "aut"),
    person("Hamil", "Pearsall", role = "aut"),
    person("Theodore S.", "Eisenman", role = "aut"),
    person("Jason G.", "Henning", role = "aut")),
    year = "2021",
    address = "Fort Collins, CO")

regDataset(name = thisDataset,
           description = "These data represent land cover change in Philadelphia, Pennsylvania over 40 years, with land cover visually interpreted from aerial imagery in 1970, 1980, 1990, and 2000. Land cover classes were tree/shrub, herbaceous, other pervious, building, and other impervious at 10,000 random points.",
           url = "https://doi.org/10.2737/RDS-2021-0033",
           download_date = "2022-01-13",
           type = "static",
           licence = NA_character_,
           contact = NA_character_,
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Data/Philadelphia_land_cover_change_data.csv"))


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)
LC_Class <- bind_cols(LC_text = c("uninterpretable",
                                  "trees and shrubs",
                                  "turf, grass, and other herbaceous plants, including agricultural fields",
                                  "other pervious, including bare soil and water",
                                  "buildings",
                                  "other impervious, including roads, walkways, and parking lots"
                                  ),
                      LC = c(0, 1, 2, 3, 4, 5))


# harmonise data ----
#
a2010 <- data %>%
  select(-"2000", -"1990", -"1980", -"1970") %>%
  mutate(year = 2010) %>%
  rename(LC = "2010")

a2000 <- data %>%
  select(-"2010", -"1990", -"1980", -"1970") %>%
  mutate(year = 2000) %>%
  rename(LC = "2000")

a1990 <- data %>%
  select(-"2010", -"2000", -"1980", -"1970") %>%
  mutate(year = 1990) %>%
  rename(LC = "1990")

a1980 <- data %>%
  select(-"2010", -"2000", -"1990", -"1970") %>%
  mutate(year = 1980) %>%
  rename(LC = "1980")

a1970 <- data %>%
  select(-"2010", -"2000", -"1990", -"1980") %>%
  mutate(year = 1970) %>%
  rename(LC = "1970")

temp <- bind_rows(a2010, a2000, a1990, a1980, a1970) %>%
  left_join(., LC_Class, by = "LC")

temp <- temp %>%
  mutate(
    x = DecDegX,
    y = DecDegY,
    day = NA_real_,
    month = NA_real_,
    country = "United States of America",
    irrigated = NA_real_,
    externalID = NA_character_,
    datasetID = thisDataset,
    externalValue = NA_real_,
    LC1_orig = LC_text,
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
