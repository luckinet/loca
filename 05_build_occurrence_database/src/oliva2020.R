# script arguments ----
#
thisDataset <- "Oliva2020"
description = "We present the MARAS (Environmental Monitoring of Arid and Semiarid Regions) dataset, which stores vegetation and soil data of 426 rangeland monitoring plots installed throughout Patagonia, a 624.500 km2 area of southern Argentina and Chile. Data for each monitoring plot includes basic climatic and landscape features, photographs, 500 point intercepts for vegetation cover, plant species list and biodiversity indexes, 50-m line-intercept transect for vegetation spatial pattern analysis, land function indexes drawn from 11 measures of soil surface characteristics and laboratory soil analysis (pH, conductivity, organic matter, N and texture). Monitoring plots were installed between 2007 and 2019, and are being reassessed at 5-year intervals (247 have been surveyed twice). The MARAS dataset provides a baseline from which to evaluate the impacts of climate change and changes in land use intensity in Patagonian ecosystems, which collectively constitute one of the world´s largest rangeland areas. This dataset will be of interest to scientists exploring key ecological questions such as biodiversity-ecosystem functioning relationships, plant-soil interactions and climatic controls on ecosystem structure and functioning."
url = "https://doi.org/10.1038/s41597-020-00658-0"
license = "CC0 1.0"


# reference ----
#
bib <- ris_reader(paste0(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/"), "10.1038_s41597-020-00658-0-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("09-01-2021"),
           type = "static",
           licence = license,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Maras monitoring plots.xlsx"))


# reshape the input data into the harmonised format
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = Country,
    x = parse_lon(str_replace_all(Long, ",", ".")),
    y = parse_lat(str_replace_all(Lat, ",", ".")),
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(Date),
    externalID = NA_character_,
    externalValue = "dryland rangeland",
    irrigated = FALSE,
    presence = NA,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated,presence, LC1_orig, LC2_orig,
         LC3_orig, sample_type, collector, purpose, everything())


# harmonize with ontology ----
#
new_source(name = thisDataset,
           description = description,
           date = Sys.Date(),
           homepage = url,
           license = license,
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
