# script arguments ----
#
thisDataset <- "Trettin2020"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "Mangroves are recognized for their valued ecosystem services to coastal areas, and the functional linkages between those services and ecosystem carbon stocks have been established. However, spatially explicit inventories are necessary to facilitate management and protection of mangroves, as well as providing a foundation for payment for ecosystem service programs such as REDD+. We conducted an inventory of carbon stocks in mangroves within Pongara National Park (PNP), Gabon using a stratified random sampling design based on forest canopy height derived from TanDEM-X remote sensing data. Ecosystem carbon pools, including aboveground and belowground biomass and necromass, and soil carbon to a depth of 2 m were assessed using measurements and samples from plots distributed among three canopy height classes within the park. There were two mangrove species within the inventory area in PNP, Rhizophora racemosa and R. harrisonii. R. harrisonii was predominant in the sparse, low-stature stands that dominated the west side of the park. In the east side of the park, both species occurred in tall-stature stands, with tree height often exceeding 30 m. Canopy height was an effective means to stratify the inventory area, as biomass was significantly different among the height classes. Despite those differences in aboveground biomass, the soil carbon density was not significantly different among height classes. Soils were the main component of the ecosystem carbon stock, accounting for over 84% of the total. The ecosystem carbon density ranged from 644 to 943 Mg C ha−1 among the three height classes. The ecosystem carbon stock within PNP is estimated to be 40,588 Gg C. The combination of pre-inventory information about stand conditions and their spatial distribution within the assessment area obtained from remote sensing data and a spatial decision support system were fundamental to implementing this relatively large-scale field inventory. This work exemplifies how mangrove carbon stocks can be quantified to augment national C reporting statistics, provide a baseline for projects involving monitoring, reporting and verification (i.e., MRV), and provide data on the forest composition and structure for sustainable management and conservation practices."
url <- "https://doi.org/10.1016/j.ecss.2021.107432"
license <- ""

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "S0272771421002857.bib")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2020-06-12",
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#
data <- read_csv(paste0(thisPath, "Data/Gabon_Plots.csv"))

# harmonise data ----
#
# mutate and rename
temp <- data %>%
  rename(
    x = unique("longitude"),
    y = unique("latitude")) %>%
  mutate(
    month = NA_real_,
    day = NA_real_,
    year = NA_real_,
    irrigated = NA_real_,
    externalID = `plot ID`,
    country = "Gabon",
    datasetID = thisDataset,
    externalValue = NA_character_,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = , # "monitoring", "validation", "study" or "map development"
    fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
