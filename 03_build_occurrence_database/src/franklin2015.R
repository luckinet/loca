# script arguments ----
#
thisDataset <- "Franklin2015"
description <- "How does tree species composition vary in relation to geographical and environmental gradients in a globally rare tropical/subtropical broadleaf dry forest community in the Caribbean? We analyzed data from 153 Forest Inventory and Analysis (FIA) plots from Puerto Rico and the U.S. Virgin Islands (USVI), along with 42 plots that we sampled in the Bahamian Archipelago (on Abaco and Eleuthera Islands). FIA data were collected using published protocols. In the Bahamian Archipelago, we recorded terrain and landscape variables, and identified to species and measured the diameter of all stems ≥5 cm at 1.3 m height in 10 m radius plots. All data were analyzed using clustering, ordination, and indicator species analysis at regional and local scales. Regionally, the largest cluster group included over half of all plots and comprised plots from all three island groups. Indicator species were native Bursera simaruba (Burseraceae) and Metopium toxiferum (Anacardiaceae). Species composition was similar to dry forests throughout the region based on published studies. Other groups we identified at the regional scale consisted of many Puerto Rico and USVI plots that were dominated by non-native species, documenting the widespread nature of novel ecosystems. At the local scale the Bahamian data clustered into two main groups corresponding largely to the two islands sampled, a pattern consistent with the latitudinal aridity gradient. Bahamian dry forests share previously undocumented compositional similarity with native-dominated dry forests found throughout the Caribbean, but they lack extensive post-disturbance novel dry forests dominated by non-native trees found in the Greater Antilles.",
url <- "https://doi.org/10.1007/s11258-015-0474-8 https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1007_s11258-015-0474-8-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-21"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


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
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Commonwealth of The Bahamas",
    x = Lon,
    y = Lat,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = mdy(Date),
    externalID = PlotID,
    externalValue = "Naturally regenerating forest",
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
