# script arguments ----
#
thisDataset <- "Sanchez-Azofeita2017"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "bg-14-977-2017.bib")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "Tropical dry forests (TDFs) are ecosystems with long drought periods, a mean temperature of 25 °C, a mean annual precipitation that ranges from 900 to 2000 mm, and that possess a high abundance of deciduous species (trees and lianas). What remains of the original extent of TDFs in the Americas remains highly fragmented and at different levels of ecological succession. It is estimated that one of the main fingerprints left by global environmental and climate change in tropical environments is an increase in liana coverage. Lianas are non-structural elements of the forest canopy that eventually kill their host trees. In this paper we evaluate the use of a terrestrial laser scanner (TLS) in combination with hemispherical photographs (HPs) to characterize changes in forest structure as a function of ecological succession and liana abundance. We deployed a TLS and HP system in 28 plots throughout secondary forests of different ages and with different levels of liana abundance. Using a canonical correlation analysis (CCA), we addressed how the VEGNET, a terrestrial laser scanner, and HPs could predict TDF structure. Likewise, using univariate analyses of correlations, we show how the liana abundance could affect the prediction of the forest structure. Our results suggest that TLSs and HPs can predict the differences in the forest structure at different successional stages but that these differences disappear as liana abundance increases. Therefore, in well known ecosystems such as the tropical dry forest of Costa Rica, these biases of prediction could be considered as structural effects of liana presence. This research contributes to the understanding of the potential effects of lianas in secondary dry forests and highlights the role of TLSs combined with HPs in monitoring structural changes in secondary TDFs.",
           url = "https://doi.org/10.5194/bg-14-977-2017",
           download_date = "2022-01-07",
           type = "static",
           licence = "CC BY 3.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Biogeosciences Santa Rosa TLS plots.xlsx"), skip = 2)


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
data <- data[- 34,]

#transform coordinates
data$Latitude <- str_remove(data$Latitude, " ")
data$Longitude <- str_remove(data$Longitude, " ")

chd = "°"
chm = "'"
chs = "\""
# transform coordinates

temp <- data %>%
  mutate(y = as.numeric(char2dms(paste0(data$Latitude,'N'), chd = chd, chm = chm, chs = chs)),
         x = as.numeric(char2dms(paste0(data$Longitude,'E'), chd = chd, chm = chm, chs = chs)))

temp <- temp %>%
  mutate(
    fid = row_number(),
    country = "Costa Rica",
    day = NA_character_,
    month = 7,
    year = 2016,
    datasetID = thisDataset,
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = NA_character_,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    luckinetID = 1132,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
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
