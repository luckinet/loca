# script arguments ----
#
thisDataset <- "Firn2020"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_s41559-018-0790-1-citation.ris"))

regDataset(name = thisDataset,
           description = "Leaf traits are frequently measured in ecology to provide a ‘common currency’ for predicting how anthropogenic pressures impact ecosystem function. Here, we test whether leaf traits consistently respond to experimental treatments across 27 globally distributed grassland sites across 4 continents. We find that specific leaf area (leaf area per unit mass)—a commonly measured morphological trait inferring shifts between plant growth strategies—did not respond to up to four years of soil nutrient additions. Leaf nitrogen, phosphorus and potassium concentrations increased in response to the addition of each respective soil nutrient. We found few significant changes in leaf traits when vertebrate herbivores were excluded in the short-term. Leaf nitrogen and potassium concentrations were positively correlated with species turnover, suggesting that interspecific trait variation was a significant predictor of leaf nitrogen and potassium, but not of leaf phosphorus concentration. Climatic conditions and pretreatment soil nutrient levels also accounted for significant amounts of variation in the leaf traits measured. Overall, we find that leaf morphological traits, such as specific leaf area, are not appropriate indicators of plant response to anthropogenic perturbations in grasslands. ",
           url = "https://doi.org/10.5061/dryad.qp25093",
           download_date = "2022-06-01",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#

data <- read_excel(path = paste0(thisPath, "foliar_cover_updated_2.xls"))


# harmonise data ----
#
temp <- data %>% dplyr::mutate(fid = dplyr::row_number())

temp <- temp %>%
  dplyr:: mutate(fid = dplyr::row_number()) %>%
  transmute(fid, year = map2(first_nutrient_year, year, `:`)) %>%
  unnest %>%
  left_join(., data, by = "fid")

temp <- temp %>%
  distinct(longitude, latitude, year.x,  .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = longitude,
    y = latitude,
    geometry = NA,
    year = year.x,
    month = NA_real_,
    day = NA_integer_,
    country = case_when(country == "AU" ~ "Australia",
                        country == "PT" ~ "Portugal",
                        country == "CA" ~ "Canada",
                        country == "US" ~ "United States of America",
                        country == "CH" ~ "Switzerland",
                        country == "ZA" ~ "South Africa",
                        country == "UK" ~ "Unitedd Kingdom",
                        country == "DE" ~ "Germany"),
    irrigated = F,
    area = 25,
    presence = F,
    externalID = NA_character_,
    externalValue = "Herbaceous associations",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
