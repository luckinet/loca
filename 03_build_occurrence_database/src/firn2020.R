# script arguments ----
#
thisDataset <- "Firn2020"
description <- "Leaf traits are frequently measured in ecology to provide a ‘common currency’ for predicting how anthropogenic pressures impact ecosystem function. Here, we test whether leaf traits consistently respond to experimental treatments across 27 globally distributed grassland sites across 4 continents. We find that specific leaf area (leaf area per unit mass)—a commonly measured morphological trait inferring shifts between plant growth strategies—did not respond to up to four years of soil nutrient additions. Leaf nitrogen, phosphorus and potassium concentrations increased in response to the addition of each respective soil nutrient. We found few significant changes in leaf traits when vertebrate herbivores were excluded in the short-term. Leaf nitrogen and potassium concentrations were positively correlated with species turnover, suggesting that interspecific trait variation was a significant predictor of leaf nitrogen and potassium, but not of leaf phosphorus concentration. Climatic conditions and pretreatment soil nutrient levels also accounted for significant amounts of variation in the leaf traits measured. Overall, we find that leaf morphological traits, such as specific leaf area, are not appropriate indicators of plant response to anthropogenic perturbations in grasslands. "
url <- "https://doi.org/10.5061/dryad.qp25093 https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_s41559-018-0790-1-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-06-01"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(path = paste0(thisPath, "foliar_cover_updated_2.xls"))


# harmonise data ----
#
temp <- data %>%
  mutate(fid = row_number())

temp <- temp %>%
  mutate(fid = row_number()) %>%
  transmute(fid, year = map2(first_nutrient_year, year, `:`)) %>%
  unnest %>%
  left_join(., data, by = "fid")temp <- data %>%
  distinct(longitude, latitude, year.x,  .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = case_when(country == "AU" ~ "Australia",
                        country == "PT" ~ "Portugal",
                        country == "CA" ~ "Canada",
                        country == "US" ~ "United States of America",
                        country == "CH" ~ "Switzerland",
                        country == "ZA" ~ "South Africa",
                        country == "UK" ~ "Unitedd Kingdom",
                        country == "DE" ~ "Germany"),
    x = longitude,
    y = latitude,
    geometry = NA,
    epsg = 4326,
    area = 25,
    date = dmy(paste0("01-01-", year.x)),
    externalID = NA_character_,
    externalValue = "Herbaceous associations",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated, presence,
         sample_type, collector, purpose, everything())


# harmonize with ontology ----
#
new_source(name = thisDataset,
           description = description,
           homepage = url,
           date = Sys.Date(),
           license = licence,
           ontology = ontoDir)

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
