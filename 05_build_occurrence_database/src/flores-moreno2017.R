# script arguments ----
#
thisDataset <- "Flores-Moreno2017"
description <- "Ecosystem eutrophication often increases domination by non-natives and causes displacement of native taxa. However, variation in environmental conditions may affect the outcome of interactions between native and non-native taxa in environments where nutrient supply is elevated. We examined the interactive effects of eutrophication, climate variability and climate average conditions on the success of native and non-native plant species using experimental nutrient manipulations replicated at 32 grassland sites on four continents. We hypothesized that effects of nutrient addition would be greatest where climate was stable and benign, owing to reduced niche partitioning. We found that the abundance of non-native species increased with nutrient addition independent of climate; however, nutrient addition increased non-native species richness and decreased native species richness, with these effects dampened in warmer or wetter sites. Eutrophication also altered the time scale in which grassland invasion responded to climate, decreasing the importance of long-term climate and increasing that of annual climate. Thus, climatic conditions mediate the responses of native and non-native flora to nutrient enrichment. Our results suggest that the negative effect of nutrient addition on native abundance is decoupled from its effect on richness, and reduces the time scale of the links between climate and compositional change."
url <- "https://doi.org/10.5061/dryad.tm53q https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Citation.ris"))

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
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "change_in_abundance_and_richness_data.csv")) %>%
  left_join(.,  read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "FloresMoreno-site-PI-table.csv")), by = "site_code")


# harmonise data ----
#
temp <- data %>%
  distinct(latitude.x, longitude.x, cover_year, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = case_when(country == "AU" ~ "Australia",
                        country == "CA" ~ "Canada",
                        country == "US" ~ "United States of America",
                        country == "CH" ~ "Switzerland",
                        country == "ZA" ~ "South Africa",
                        country == "UK" ~ "Unitedd Kingdom"),
    x = longitude.x ,
    y = latitude.x ,
    geometry = NA,
    epsg = 4326,
    area = 25,
    date = dmx(paste0("01-01-", cover_year)),
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
