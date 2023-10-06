# script arguments ----
#
thisDataset <- "Ehbrecht2021"
description <- "The complexity of forest structures plays a crucial role in regulating forest ecosystem functions and strongly influences biodiversity. Yet, knowledge of the global patterns and determinants of forest structural complexity remains scarce. Using a stand structural complexity index based on terrestrial laser scanning, we quantify the structural complexity of boreal, temperate, subtropical and tropical primary forests. We find that the global variation of forest structural complexity is largely explained by annual precipitation and precipitation seasonality (R²=0.89). Using the structural complexity of primary forests as benchmark, we model the potential structural complexity across biomes and present a global map of the potential structural complexity of the earth´s forest ecoregions. Our analyses reveal distinct latitudinal patterns of forest structure and show that hotspots of high structural complexity coincide with hotspots of plant diversity. Considering the mechanistic underpinnings of forest structural complexity, our results suggest spatially contrasting changes of forest structure with climate change within and across biomes."
url <- "https://doi.org/10.1038/s41467-020-20767-z https://"
licence <- "CC BY 4.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "10.1038_s41467-020-20767-z-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-10-14"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Ehbrecht et al_Global patterns and climatic controls of forest structural complexity_Year of data collection.xlsx"), sheet = 1, skip = 1)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = unlist(str_extract_all(Site, "(?<=\\().+?(?=\\))")),
    x = `Longitude (°)`,
    y = `Latitude (°)`,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(paste0(`Year of data collection`, "-01-01")) ,
    externalID = Site,
    externalValue = "Undisturbed Forest",
    attr_1 = Biome,
    attr_1_typ = "biome type",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "validation") %>%
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
