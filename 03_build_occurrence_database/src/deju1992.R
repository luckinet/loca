# script arguments ----
#
thisDataset <- "Deju1992"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "0378377493900212.bib")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "This paper deals with the water-use efficiency of winter wheat (Triticum aestivum L.) and maize (Zea mays L.) on a salt-affected soil in the Huang Huai Hai river plain of China. A strong linear relationship was found between the dry above ground biomass and evapotranspiration (ET) for winter wheat (48 kg ha−1 mm−1) and maize (38 kg ha−1 mm−1). A similar result was obtained for the grain yield of winter wheat (10 kg ha−1 mm−1). The harvest index of winter wheat decreases at increasing evapotranspiration: i.e. from about 0.4 down to 0.3 when evapotranspiration increases from 200 to 380 mm. Application of the yield-decrease — evapotranspiration-decrease model of Stewart et al. (1977) to divide evapotranspiration in soil evaporation and transpiration resulted for winter wheat in a total soil evaporation of 9 mm (3% of total evapotranspiration) and for maize of 62 mm (17.5% of total evapotranspiration). The relationship between grain yield of winter wheat and irrigation depth could be approached by a quadratic curve indicating that with increasing amount of irrigation water yield increase becomes less. Soil salinity increased during the dry season mainly due to capillary rise and decreased during the rainy season in summer by leaching. The capillary rise during the dry season was estimated from the chloride concentration of the soil water at a depth of 2 m and the increase of the chloride content in the layer 0–2 m and amounted to about 55 mm. The decrease in chloride content in the layer 0–2 m during the rainy season counterbalances the chloride increase in the dry season.",
           url = "https://doi.org/10.1016/0378-3774(93)90021-2",
           download_date = "2021-10-19",
           type = "static", # dynamic or static
           licence = , # optional
           contact = , # optional
           disclosed = FALSE, # whether the data are freely available TRUE/FALSE
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv2(paste0(thisPath, "Deju1992.csv"))


# manage ontology ---
#

matches <- tibble(new = c(unique(data$commodities)[1]),
                  old = c("wheat"))

getConcept(label_en = matches$old) %>%

  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)


# harmonise data ----
#
chd = substr(data$lat, 3, 3)[1]
chm = substr(data$lat, 7, 7)[1]

temp <- data %>%
  mutate(y = as.numeric(char2dms(paste0(data$lat,'N'), chd = chd, chm = chm)),
         x = as.numeric(char2dms(paste0(data$long,'E'), chd = chd, chm = chm))) %>%
  mutate(fid = row_number(),
         date = ymd(paste0(year, "-01-01")),
         irrigated = TRUE,
         datasetID = thisDataset,
         country = "China",
         presence = TRUE,
         area = 100,
         type = "areal",
         geometry = NA,
         externalID = NA_character_,
         externalValue = commodities,
         LC1_orig = NA_character_,
         LC2_orig = NA_character_,
         LC3_orig = NA_character_,
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


