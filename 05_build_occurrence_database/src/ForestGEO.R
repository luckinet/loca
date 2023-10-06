# script arguments ----
#
thisDataset <- "ForestGEO"
description <- "ForestGEO is a network of scientists and long-term forest dynamics plots (FDPs) spanning the Earth's major forest types. ForestGEO's mission is to advance understanding of the diversity and dynamics of forests and to strengthen global capacity for forest science research. ForestGEO is unique among forest plot networks in its large-scale plot dimensions, censusing of all stems ≥1 cm in diameter, inclusion of tropical, temperate and boreal forests, and investigation of additional biotic (e.g., arthropods) and abiotic (e.g., soils) drivers, which together provide a holistic view of forest functioning. The 71 FDPs in 27 countries include approximately 7.33 million living trees and about 12,000 species, representing 20% of the world's known tree diversity. With >1300 published papers, ForestGEO researchers have made significant contributions in two fundamental areas: species coexistence and diversity, and ecosystem functioning. Specifically, defining the major biotic and abiotic controls on the distribution and coexistence of species and functional types and on variation in species' demography has led to improved understanding of how the multiple dimensions of forest diversity are structured across space and time and how this diversity relates to the processes controlling the role of forests in the Earth system. Nevertheless, knowledge gaps remain that impede our ability to predict how forest diversity and function will respond to climate change and other stressors. Meeting these global research challenges requires major advances in standardizing taxonomy of tropical species, resolving the main drivers of forest dynamics, and integrating plot-based ground and remote sensing observations to scale up estimates of forest diversity and function, coupled with improved predictive models. However, they cannot be met without greater financial commitment to sustain the long-term research of ForestGEO and other forest plot networks, greatly expanded scientific capacity across the world's forested nations, and increased collaboration and integration among research networks and disciplines addressing forest science."
url <- "https://doi.org/10.1016/j.biocon.2020.108907 https://"
licence <- ""


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "S0006320720309654.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-10-27"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "forestgeo_global.csv"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = country,
    x = x,
    y = y,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(paste0(year, "-01-01")),
    externalID = NA_character_,
    externalValue = "Forests",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring") %>%
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
