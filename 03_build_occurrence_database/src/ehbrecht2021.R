# script arguments ----
#
thisDataset <- "Ehbrecht2021"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_s41467-020-20767-z-citation.ris"))

regDataset(name = thisDataset,
           description = "The complexity of forest structures plays a crucial role in regulating forest ecosystem functions and strongly influences biodiversity. Yet, knowledge of the global patterns and determinants of forest structural complexity remains scarce. Using a stand structural complexity index based on terrestrial laser scanning, we quantify the structural complexity of boreal, temperate, subtropical and tropical primary forests. We find that the global variation of forest structural complexity is largely explained by annual precipitation and precipitation seasonality (R²=0.89). Using the structural complexity of primary forests as benchmark, we model the potential structural complexity across biomes and present a global map of the potential structural complexity of the earth´s forest ecoregions. Our analyses reveal distinct latitudinal patterns of forest structure and show that hotspots of high structural complexity coincide with hotspots of plant diversity. Considering the mechanistic underpinnings of forest structural complexity, our results suggest spatially contrasting changes of forest structure with climate change within and across biomes.",
           url = "https://www.nature.com/articles/s41467-020-20767-z",
           download_date = "2021-10-14",
           type = "static",
           licence = "CC BY 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Ehbrecht et al_Global patterns and climatic controls of forest structural complexity_Year of data collection.xlsx"), sheet = 1, skip = 1)



# harmonise data ----
#
temp <- data %>%
  mutate(
         fid = row_number(),
         externalID = Site,
         x = `Longitude (°)`,
         y = `Latitude (°)`,
         epsg = 4326,
         country = unlist(str_extract_all(Site, "(?<=\\().+?(?=\\))")),
         date = ymd(paste0(`Year of data collection`, "-01-01")) ,
         irrigated = FALSE,
         datasetID = thisDataset,
         presence = FALSE,
         area = NA_real_,
         type = "point",
         geometry = NA,
         externalValue = "Undisturbed Forest",
         LC1_orig = Biome,
         LC2_orig = NA_character_,
         LC3_orig = NA_character_,
         sample_type = "field",
         collector = "expert",
         purpose = "validation") %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")

