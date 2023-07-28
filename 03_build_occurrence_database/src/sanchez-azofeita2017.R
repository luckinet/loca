# script arguments ----
#
thisDataset <- "Sanchez-Azofeita2017"
description <- "Tropical dry forests (TDFs) are ecosystems with long drought periods, a mean temperature of 25°C, a mean annual precipitation that ranges from 900 to 2000mm, and that possess a high abundance of deciduous species (trees and lianas). What remains of the original extent of TDFs in the Americas remains highly fragmented and at different levels of ecological succession. It is estimated that one of the main fingerprints left by global environmental and climate change in tropical environments is an increase in liana coverage. Lianas are non-structural elements of the forest canopy that eventually kill their host trees. In this paper we evaluate the use of a terrestrial laser scanner (TLS) in combination with hemispherical photographs (HPs) to characterize changes in forest structure as a function of ecological succession and liana abundance. We deployed a TLS and HP system in 28 plots throughout secondary forests of different ages and with different levels of liana abundance. Using a canonical correlation analysis (CCA), we addressed how the VEGNET, a terrestrial laser scanner, and HPs could predict TDF structure. Likewise, using univariate analyses of correlations, we show how the liana abundance could affect the prediction of the forest structure. Our results suggest that TLSs and HPs can predict the differences in the forest structure at different successional stages but that these differences disappear as liana abundance increases. Therefore, in well known ecosystems such as the tropical dry forest of Costa Rica, these biases of prediction could be considered as structural effects of liana presence. This research contributes to the understanding of the potential effects of lianas in secondary dry forests and highlights the role of TLSs combined with HPs in monitoring structural changes in secondary TDFs."
url <- "https://doi.org/10.5194/bg-14-977-2017"
license <- "CC BY 3.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "bg-14-977-2017.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-07"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Biogeosciences Santa Rosa TLS plots.xlsx"), skip = 2)


# pre-process data ----
#
data <- data[- 34,]

#transform coordinates
data$Latitude <- str_remove(data$Latitude, " ")
data$Longitude <- str_remove(data$Longitude, " ")

chd = "°"
chm = "'"
chs = "\""

temp <- data %>%
  mutate(y = as.numeric(char2dms(paste0(data$Latitude,'N'), chd = chd, chm = chm, chs = chs)),
         x = as.numeric(char2dms(paste0(data$Longitude,'E'), chd = chd, chm = chm, chs = chs)))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Costa Rica",
    x = x,
    y = y,
    geometry = NA,
    epsg = 4326,
    area = 0.1 * 10000,
    date = ymd("2016-07-01"),
    externalID = as.character(`Plot No.`),
    externalValue = "Naturally Regenerating Forest",
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
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
