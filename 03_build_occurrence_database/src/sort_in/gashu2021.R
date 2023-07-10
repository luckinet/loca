# script arguments ----
#
thisDataset <- "Gashu2021"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_s41586-021-03559-3-citation.ris"))

regDataset(name = thisDataset,
           description = "Micronutrient deficiencies (MNDs) remain widespread among people in sub-Saharan Africa, where access to sufficient food from plant and animal sources that is rich in micronutrients (vitamins and minerals) is limited due to socioeconomic and geographical reasons4,5,6. Here we report the micronutrient composition (calcium, iron, selenium and zinc) of staple cereal grains for most of the cereal production areas in Ethiopia and Malawi. We show that there is geospatial variation in the composition of micronutrients that is nutritionally important at subnational scales. Soil and environmental covariates of grain micronutrient concentrations included soil pH, soil organic matter, temperature, rainfall and topography, which were specific to micronutrient and crop type. For rural households consuming locally sourced food—including many smallholder farming communities—the location of residence can be the largest influencing factor in determining the dietary intake of micronutrients from cereals. Positive relationships between the concentration of selenium in grain and biomarkers of selenium dietary status occur in both countries. Surveillance of MNDs on the basis of biomarkers of status and dietary intakes from national- and regional-scale food-composition data could be improved using subnational data on the composition of grain micronutrients. Beyond dietary diversification, interventions to alleviate MNDs, such as food fortification8,9 and biofortification to increase the micronutrient concentrations in crops, should account for geographical effects that can be larger in magnitude than intervention outcomes.",
           url = "https://doi.org/10.1038/s41586-021-03559-3",
           download_date = "2022-02-22",
           type = "static",
           licence = "GPL-3.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_excel(paste0(thisPath, "Malawi_Grain.xlsx"))


# manage ontology ---
#
matches <- tibble(new = c(tolower(unique(data$Crop))[4:6]),
                  old = c("millet", "Mixed cereals", "millet"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    geometry = NA,
    x = Longitude,
    y = Latitude,
    year = "2017_2018",
    country = "Ethiopia_Malawi",
    irrigated = FALSE,
    area = NA_real_,
    presence = TRUE,
    externalID = NA_character_,
    externalValue = tolower(Crop),
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  separate_rows(country, sep = "_") %>%
  mutate(
    fid = row_number(),
    date = ymd(paste0(year, "-01-01"))) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
