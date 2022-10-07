# script arguments ----
#
thisDataset <- "Draper2021"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_s41559-021-01418-y-citation.ris")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "The forests of Amazonia are among the most biodiverse plant communities on Earth. Given the immediate threats posed by climate and land-use change, an improved understanding of how this extraordinary biodiversity is spatially organized is urgently required to develop effective conservation strategies. Most Amazonian tree species are extremely rare but a few are common across the region. Indeed, just 227 ‘hyperdominant’ species account for >50% of all individuals >10 cm diameter at 1.3 m in height. Yet, the degree to which the phenomenon of hyperdominance is sensitive to tree size, the extent to which the composition of dominant species changes with size class and how evolutionary history constrains tree hyperdominance, all remain unknown. Here, we use a large floristic dataset to show that, while hyperdominance is a universal phenomenon across forest strata, different species dominate the forest understory, midstory and canopy. We further find that, although species belonging to a range of phylogenetically dispersed lineages have become hyperdominant in small size classes, hyperdominants in large size classes are restricted to a few lineages. Our results demonstrate that it is essential to consider all forest strata to understand regional patterns of dominance and composition in Amazonia. More generally, through the lens of 654 hyperdominant species, we outline a tractable pathway for understanding the functioning of half of Amazonian forests across vertical strata and geographical locations.",
           url = "https://www.nature.com/articles/s41559-021-01418-y",
           download_date = "2021-08-06", # YYYY-MM-DD
           type = "static", # dynamic or static
           licence = "CC-BY-SA 4." , # optional
           contact = , # optional
           disclosed = TRUE, # whether the data are freely available TRUE/FALSE
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "forestPlots_Draper.csv"))


# manage ontology ---
#

#luckinetID = case_when(forest_type == "clay" ~ NA_character_,
#                       forest_type == "TF" ~ NA_character_,
#                       forest_type == "SF" ~ NA_character_,
#                       forest_type == "WS" ~ NA_character_,
#                       forest_type == "SW" ~ NA_character_)

# harmonise data ----
#
temp <- data %>%
  mutate(fid = seq_along(Plot_ID),
         externalID = Plot_ID,
         x = Longitude,
         y = Latitude,
         epsg = 4326,
         country = Country,
         year = NA_real_,
         month = NA_real_,
         day = NA_integer_,
         irrigated = FALSE,
         presence = FALSE,
         type = "point",
         area = NA_real_,
         datasetID = thisDataset,
         externalValue = "Forest Land",
         LC1_orig = NA_character_,
         LC2_orig = NA_character_,
         LC3_orig = NA_character_,
         sample_type = "field",
         collector = "expert",
         purpose = "monitoring") %>%
  select(datasetID, fid, country, x, y, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())

# In case we are dealing with areal data, build object that contains polygons
# temp_sf <- temp %>%
#   mutate(geom = ) %>% # select the geometry object
#   select(datasetID, fid, geom)


# write output ----
#
validateFormat(object = temp, type = "in-situ point") %>%
  saveDataset(dataset = thisDataset)

# validateFormat(object = temp_sf, type = "in-situ areal") %>%
#   write_sf(dsn = paste0(thisDataset, "_sf.gpkg"), delete_layer = TRUE)

message("\n---- done ----")

