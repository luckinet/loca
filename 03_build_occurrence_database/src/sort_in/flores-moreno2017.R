# script arguments ----
#
thisDataset <- "Flores-Moreno2017"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "Citation.ris"))

regDataset(name = thisDataset,
           description = "Ecosystem eutrophication often increases domination by non-natives and causes displacement of native taxa. However, variation in environmental conditions may affect the outcome of interactions between native and non-native taxa in environments where nutrient supply is elevated. We examined the interactive effects of eutrophication, climate variability and climate average conditions on the success of native and non-native plant species using experimental nutrient manipulations replicated at 32 grassland sites on four continents. We hypothesized that effects of nutrient addition would be greatest where climate was stable and benign, owing to reduced niche partitioning. We found that the abundance of non-native species increased with nutrient addition independent of climate; however, nutrient addition increased non-native species richness and decreased native species richness, with these effects dampened in warmer or wetter sites. Eutrophication also altered the time scale in which grassland invasion responded to climate, decreasing the importance of long-term climate and increasing that of annual climate. Thus, climatic conditions mediate the responses of native and non-native flora to nutrient enrichment. Our results suggest that the negative effect of nutrient addition on native abundance is decoupled from its effect on richness, and reduces the time scale of the links between climate and compositional change.",
           url = "https://doi.org/10.5061/dryad.tm53q",
           download_date = "2022-06-01",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#

data <- read_csv(file = paste0(thisPath, "change_in_abundance_and_richness_data.csv")) %>%
  left_join(.,  read_csv(file = paste0(thisPath, "FloresMoreno-site-PI-table.csv")), by = "site_code")


# harmonise data ----
#

temp <- data %>%
  distinct(latitude.x, longitude.x, cover_year, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = longitude.x ,
    y = latitude.x ,
    geometry = NA,
    year = cover_year,
    month = NA_real_,
    day = NA_integer_,
    country = case_when(country == "AU" ~ "Australia",
                        country == "CA" ~ "Canada",
                        country == "US" ~ "United States of America",
                        country == "CH" ~ "Switzerland",
                        country == "ZA" ~ "South Africa",
                        country == "UK" ~ "Unitedd Kingdom"),
    irrigated = F,
    area = 25,
    presence = F,
    externalID = NA_character_,
    externalValue = "Herbaceous associations",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
