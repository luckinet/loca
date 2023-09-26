# script arguments ----
#
thisDataset <- "Gashu2021"
description <- "Micronutrient deficiencies (MNDs) remain widespread among people in sub-Saharan Africa, where access to sufficient food from plant and animal sources that is rich in micronutrients (vitamins and minerals) is limited due to socioeconomic and geographical reasons4,5,6. Here we report the micronutrient composition (calcium, iron, selenium and zinc) of staple cereal grains for most of the cereal production areas in Ethiopia and Malawi. We show that there is geospatial variation in the composition of micronutrients that is nutritionally important at subnational scales. Soil and environmental covariates of grain micronutrient concentrations included soil pH, soil organic matter, temperature, rainfall and topography, which were specific to micronutrient and crop type. For rural households consuming locally sourced food—including many smallholder farming communities—the location of residence can be the largest influencing factor in determining the dietary intake of micronutrients from cereals. Positive relationships between the concentration of selenium in grain and biomarkers of selenium dietary status occur in both countries. Surveillance of MNDs on the basis of biomarkers of status and dietary intakes from national- and regional-scale food-composition data could be improved using subnational data on the composition of grain micronutrients. Beyond dietary diversification, interventions to alleviate MNDs, such as food fortification8,9 and biofortification to increase the micronutrient concentrations in crops, should account for geographical effects that can be larger in magnitude than intervention outcomes."
url <- "https://doi.org/10.1038/s41586-021-03559-3 https://"
licence <- "GPL-3.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "10.1038_s41586-021-03559-3-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-02-22"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Malawi_Grain.xlsx"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Ethiopia_Malawi",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = "2017_2018",
    externalID = NA_character_,
    externalValue = tolower(Crop),
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_") %>%
  separate_rows(country, sep = "_") %>%
  mutate(
    fid = row_number(),
    date = ymd(paste0(year, "-01-01"))) %>%
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

# matches <- tibble(new = c(tolower(unique(data$Crop))[4:6]),
#                   old = c("millet", "Mixed cereals", "millet"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
