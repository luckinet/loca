# script arguments ----
#
thisDataset <- "ForestGEO"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "ForestGEO is a network of scientists and long-term forest dynamics plots (FDPs) spanning the Earth's major forest types. ForestGEO's mission is to advance understanding of the diversity and dynamics of forests and to strengthen global capacity for forest science research. ForestGEO is unique among forest plot networks in its large-scale plot dimensions, censusing of all stems ≥1 cm in diameter, inclusion of tropical, temperate and boreal forests, and investigation of additional biotic (e.g., arthropods) and abiotic (e.g., soils) drivers, which together provide a holistic view of forest functioning. The 71 FDPs in 27 countries include approximately 7.33 million living trees and about 12,000 species, representing 20% of the world's known tree diversity. With >1300 published papers, ForestGEO researchers have made significant contributions in two fundamental areas: species coexistence and diversity, and ecosystem functioning. Specifically, defining the major biotic and abiotic controls on the distribution and coexistence of species and functional types and on variation in species' demography has led to improved understanding of how the multiple dimensions of forest diversity are structured across space and time and how this diversity relates to the processes controlling the role of forests in the Earth system. Nevertheless, knowledge gaps remain that impede our ability to predict how forest diversity and function will respond to climate change and other stressors. Meeting these global research challenges requires major advances in standardizing taxonomy of tropical species, resolving the main drivers of forest dynamics, and integrating plot-based ground and remote sensing observations to scale up estimates of forest diversity and function, coupled with improved predictive models. However, they cannot be met without greater financial commitment to sustain the long-term research of ForestGEO and other forest plot networks, greatly expanded scientific capacity across the world's forested nations, and increased collaboration and integration among research networks and disciplines addressing forest science."
url <- "https://doi.org/10.1016/j.biocon.2020.108907"
license <- ""


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "S0006320720309654.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2021-10-27",
           type = "static",
           licence = license,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           path = occurrenceDBDir)

# read dataset ----
#
data <- read_csv(file = paste0(thisPath, "forestgeo_global.csv"))

# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = x,
    y = y,
    geometry = NA,
    date = ymd(paste0(year, "-01-01")),
    country = country,
    irrigated = F,
    area = NA_real_,
    presence = F,
    externalID = NA_character_,
    externalValue = "Forests",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())

# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
