# script arguments ----
#
thisDataset <- "Hudson2016"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Hudson_cit-bib"))

regDataset(name = thisDataset,
           description = "The PREDICTS project—Projecting Responses of Ecological Diversity In Changing Terrestrial Systems (www.predicts.org.uk)—has collated from published studies a large, reasonably representative database of comparable samples of biodiversity from multiple sites that differ in the nature or intensity of human impacts relating to land use. We have used this evidence base to develop global and regional statistical models of how local biodiversity responds to these measures. We describe and make freely available this 2016 release of the database, containing more than 3.2 million records sampled at over 26,000 locations and representing over 47,000 species. We outline how the database can help in answering a range of questions in ecology and conservation biology. To our knowledge, this is the largest and most geographically and taxonomically representative database of spatial comparisons of biodiversity that has been collated to date; it will be useful to researchers and international efforts wishing to model and understand the global status of biodiversity.",
           url = "https://doi.org/10.5519/0066354",
           download_date = "2022-06-02",
           type = "static",
           licence = "CC-BY-4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#

data <- read_csv(file = paste0(thisPath, "database.csv"))

# manage ontology ---
#
matches <- tibble(new = c(unique(data$Biome)),
                  old = c("Forests", "Forests",
                          "Forests", "Shrubland",
                          "Forests", "Shrubland",
                          "Shrubland", "Marine wetlands",
                          "Forests", "Herbaceous associations",
                          "Forests", "Forests",
                          "Inland wetlands", "Shrubland"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = c(1, 1, 2, 2, 1, 2, 2, 1, 1, 2, 1, 1, 1, 2))


# harmonise data ----
#
data <- data %>% dplyr::mutate(Tid = row_number())

temp <- data %>%
  dplyr::mutate(start = year(Sample_start_earliest),
         end = year(Sample_end_latest),
         Tid = row_number())

temp <- temp %>%
  transmute(Tid , year = map2(start, end, `:`)) %>%
  unnest %>%
  left_join(., data, by = "Tid")


temp <- temp %>%
  distinct(Biome, Longitude, Latitude, year, .keep_all = T) %>%
  dplyr::mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    year = as.numeric(year),
    month = NA_real_,
    day = NA_integer_,
    country = Country,
    irrigated = F,
    area = Habitat_patch_area_square_metres,
    presence = T,
    externalID = NA_character_,
    externalValue = Biome,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "meta study",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
