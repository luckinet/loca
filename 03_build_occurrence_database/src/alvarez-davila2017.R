# script arguments ----
#
thisDataset <- "Alvarez-Davila2017"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1371_journal.pone.0171072.ris"))

regDataset(name = thisDataset,
           description = "Understanding and predicting the likely response of ecosystems to climate change are crucial challenges for ecology and for conservation biology. Nowhere is this challenge greater than in the tropics as these forests store more than half the total atmospheric carbon stock in their biomass. Biomass is determined by the balance between biomass inputs (i.e., growth) and outputs (mortality). We can expect therefore that conditions that favor high growth rates, such as abundant water supply, warmth, and nutrient-rich soils will tend to correlate with high biomass stocks. Our main objective is to describe the patterns of above ground biomass (AGB) stocks across major tropical forests across climatic gradients in Northwestern South America. We gathered data from 200 plots across the region, at elevations ranging between 0 to 3400 m. We estimated AGB based on allometric equations and values for stem density, basal area, and wood density weighted by basal area at the plot-level. We used two groups of climatic variables, namely mean annual temperature and actual evapotranspiration as surrogates of environmental energy, and annual precipitation, precipitation seasonality, and water availability as surrogates of water availability. We found that AGB is more closely related to water availability variables than to energy variables. In northwest South America, water availability influences carbon stocks principally by determining stand structure, i.e. basal area. When water deficits increase in tropical forests we can expect negative impact on biomass and hence carbon storage.",
           url = "https://doi.org/10.1371/journal.pone.0171072",
           download_date = "2022-01-13",
           type = "static",
           licence = "",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(path = paste0(thisPath, "Álvarez-Dávila_etal_2017_PlosOne_PlotData.xlsx"), sheet = 1)


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)


# harmonise data ----
#
temp <- data %>%
  mutate(
    fid = row_number(),
    x = X,
    y = Y,
    year = NA_character_,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    country = Country,
    irrigated = FALSE,
    externalID = PlotID,
    externalValue = "old-growth forest",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, year, month, day, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())

# before preparing data for storage, test that all required variables are available
assertNames(x = names(temp),
            must.include = c("datasetID", "fid", "country", "x", "y", "epsg",
                             "year", "month", "day", "irrigated",
                             "externalID", "externalValue", "LC1_orig", "LC2_orig", "LC3_orig",
                             "sample_type", "collector", "purpose"))


# write output ----
#
saveDataset(object = temp, dataset = thisDataset)
