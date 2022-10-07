# script arguments ----
#
thisDataset <- "Sankaran2007"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "850.bib"))

regDataset(name = thisDataset,
           description = "This data set includes the soil and vegetation characteristics, herbivore estimates, and precipitation measurement data for the 854 sites described and analyzed in Sankaran et al., 2005. Savannas are globally important ecosystems of great significance to human economies. In these biomes, which are characterized by the co-dominance of trees and grasses, woody cover is a chief determinant of ecosystem properties. The availability of resources (water, nutrients) and disturbance regimes (fire, herbivory) are thought to be important in regulating woody cover but perceptions differ on which of these are the primary drivers of savanna structure. Analyses of data from 854 sites across Africa (Figure 1) showed that maximum woody cover in savannas receiving a mean annual precipitation (MAP) of less than approximately 650 mm is constrained by, and increases linearly with, MAP. These arid and semi-arid savannas may be considered stable systems in which water constrains woody cover and permits grasses to coexist, while fire, herbivory and soil properties interact to reduce woody cover below the MAP-controlled upper bound. Above a MAP of approximately 650 mm, savannas are unstable systems in which MAP is sufficient for woody canopy closure, and disturbances (fire, herbivory) are required for the coexistence of trees and grass. These results provide insights into the nature of African savannas and suggest that future changes in precipitation may considerably affect their distribution and dynamics (Sankaran et al., 2005). This data set includes the site characteristics and measurement data for the 854 sites described and analyzed in Sankaran et al., 2005. The data are provided in two formats, *.xls and *.csv. See the data format section below for more information. ",
           url = "http://dx.doi.org/10.3334/ORNLDAAC/850",
           download_date = "2022-01-13",
           type = "static",
           licence = NA_character_,
           contact = NA_character_,
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#

data <- read_csv(paste0(thisPath, "gv_aws_850/data/woody_cover_20070206.csv"))
data <- data[-c(1),]


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)
match <- data %>%
  select(Site_Description) %>%
  distinct() %>%
  mutate(term = tolower(Site_Description)) %>%
  left_join(allConcepts, by = c("term"))

new <- match %>%
  filter(is.na(luckinetID)) %>%
  mutate(luckinetID = c(NA, NA, NA, NA, NA,
                        NA, NA, NA, NA, NA,
                        NA, NA, NA, NA, NA,
                        NA, NA, NA, NA, NA,
                        NA, NA, NA, NA, NA,
                        NA, NA, NA, NA, NA,
                        NA, NA, NA, NA, NA,
                        NA))

match <- match %>%
  filter(!is.na(luckinetID)) %>%
  bind_rows(new) %>%
  select(term, luckinetID)

## join tibble
temp <- temp %>%
  mutate(term = tolower(Site_Description)) %>%
  left_join(., match, by = "term")


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    x = Long,
    y = Lat,
    year = ,
    month = ,
    day = ,
    country = Country,
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = Site_Description,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = ,
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
