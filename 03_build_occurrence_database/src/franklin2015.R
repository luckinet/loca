# script arguments ----
#
thisDataset <- "Franklin2015"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1007_s11258-015-0474-8-citation.ris"))

regDataset(name = thisDataset,
           description = "How does tree species composition vary in relation to geographical and environmental gradients in a globally rare tropical/subtropical broadleaf dry forest community in the Caribbean? We analyzed data from 153 Forest Inventory and Analysis (FIA) plots from Puerto Rico and the U.S. Virgin Islands (USVI), along with 42 plots that we sampled in the Bahamian Archipelago (on Abaco and Eleuthera Islands). FIA data were collected using published protocols. In the Bahamian Archipelago, we recorded terrain and landscape variables, and identified to species and measured the diameter of all stems ≥5 cm at 1.3 m height in 10 m radius plots. All data were analyzed using clustering, ordination, and indicator species analysis at regional and local scales. Regionally, the largest cluster group included over half of all plots and comprised plots from all three island groups. Indicator species were native Bursera simaruba (Burseraceae) and Metopium toxiferum (Anacardiaceae). Species composition was similar to dry forests throughout the region based on published studies. Other groups we identified at the regional scale consisted of many Puerto Rico and USVI plots that were dominated by non-native species, documenting the widespread nature of novel ecosystems. At the local scale the Bahamian data clustered into two main groups corresponding largely to the two islands sampled, a pattern consistent with the latitudinal aridity gradient. Bahamian dry forests share previously undocumented compositional similarity with native-dominated dry forests found throughout the Caribbean, but they lack extensive post-disturbance novel dry forests dominated by non-native trees found in the Greater Antilles.",
           url = "https://doi.org/10.1007/s11258-015-0474-8",
           download_date = "2022-01-21",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Abaco_Eleuthera_plot_data_species_dbh_.csv"), n_max = 42)

a <- read_csv(paste0(thisPath, "Abaco_Eleuthera_plot_data_species_dbh_.csv"), skip = 44)[, -c(10:14)]

data <- left_join(data, a, by = "PlotID")


# harmonise data ----
#

temp <- data %>%
  distinct(Lat, Lon, Date, PlotID, .keep_all = T) %>%
  mutate(
    fid = row_number(),
    x = Lon,
    y = Lat,
    date = mdy(Date),
    datasetID = thisDataset,
    country = "Commonwealth of The Bahamas",
    irrigated = FALSE,
    externalID = PlotID,
    externalValue = "Naturally regenerating forest",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    presence = FALSE,
    area = NA_real_,
    type = "point",
    geometry = NA,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
