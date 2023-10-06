# script arguments ----
#
thisDataset <- "Trettin2020"
description <- "Mangroves are recognized for their valued ecosystem services to coastal areas, and the functional linkages between those services and ecosystem carbon stocks have been established. However, spatially explicit inventories are necessary to facilitate management and protection of mangroves, as well as providing a foundation for payment for ecosystem service programs such as REDD+. We conducted an inventory of carbon stocks in mangroves within Pongara National Park (PNP), Gabon using a stratified random sampling design based on forest canopy height derived from TanDEM-X remote sensing data. Ecosystem carbon pools, including aboveground and belowground biomass and necromass, and soil carbon to a depth of 2 m were assessed using measurements and samples from plots distributed among three canopy height classes within the park. There were two mangrove species within the inventory area in PNP, Rhizophora racemosa and R. harrisonii. R. harrisonii was predominant in the sparse, low-stature stands that dominated the west side of the park. In the east side of the park, both species occurred in tall-stature stands, with tree height often exceeding 30 m. Canopy height was an effective means to stratify the inventory area, as biomass was significantly different among the height classes. Despite those differences in aboveground biomass, the soil carbon density was not significantly different among height classes. Soils were the main component of the ecosystem carbon stock, accounting for over 84% of the total. The ecosystem carbon density ranged from 644 to 943 Mg C ha−1 among the three height classes. The ecosystem carbon stock within PNP is estimated to be 40,588 Gg C. The combination of pre-inventory information about stand conditions and their spatial distribution within the assessment area obtained from remote sensing data and a spatial decision support system were fundamental to implementing this relatively large-scale field inventory. This work exemplifies how mangrove carbon stocks can be quantified to augment national C reporting statistics, provide a baseline for projects involving monitoring, reporting and verification (i.e., MRV), and provide data on the forest composition and structure for sustainable management and conservation practices."
url <- "https://doi.org/10.1016/j.ecss.2021.107432"
license <- ""


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "S0272771421002857.bib")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2020-06-12"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Data/Gabon_Plots.csv"))


# harmonise data ----
#
temp <- data %>%
  rename(
    x = unique("longitude"),
    y = unique("latitude")) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = NA_character_,
    country = "Gabon",
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = `plot ID`,
    externalValue = NA_character_,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = NA,
    sample_type = "field",
    collector = "expert",
    purpose = NA_character_) %>%
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
