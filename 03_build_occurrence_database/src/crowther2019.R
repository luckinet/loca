# script arguments ----
#
thisDataset <- "Crowther2019"
description <- "Soil stores approximately twice as much carbon as the atmosphere and fluctuations in the size of the soil carbon pool directly influence climate conditions. We used the Nutrient Network global change experiment to examine how anthropogenic nutrient enrichment might influence grassland soil carbon storage at a global scale. In isolation, enrichment of nitrogen and phosphorous had minimal impacts on soil carbon storage. However, when these nutrients were added in combination with potassium and micronutrients, soil carbon stocks changed considerably, with an average increase of 0.04 KgCm−2 year−1 (standard deviation 0.18 KgCm−2 year−1). These effects did not correlate with changes in primary productivity, suggesting that soil carbon decomposition may have been restricted. Although nutrient enrichment caused soil carbon gains most dry, sandy regions, considerable absolute losses of soil carbon may occur in high‐latitude regions that store the majority of the world's soil carbon. These mechanistic insights into the sensitivity of grassland carbon stocks to nutrient enrichment can facilitate biochemical modelling efforts to project carbon cycling under future climate scenarios."
url <- "https://doi.org/10.5061/dryad.0dt27vb https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- ris_reader(paste0(thisPath, "pericles_1461024822.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-06-01"),
           type = NA_character_,
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(thisPath, "Nutrient_Enrichment_Dataset.csv.csv"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = long,
    y = llat,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = NA_character_,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = NA,
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
