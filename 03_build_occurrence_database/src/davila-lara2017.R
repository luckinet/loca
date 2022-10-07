# script arguments ----
#
thisDataset <- "Davila-Lara2017"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_hdy.2017.45-citation.ris"))

regDataset(name = thisDataset,
           description = "The Central American seasonally dry tropical (SDT) forest biome is one of the worlds’ most endangered ecosystems, yet little is known about the genetic consequences of its recent fragmentation. A prominent constituent of this biome is Calycophyllum candidissimum, an insect-pollinated and wind-dispersed canopy tree of high socio-economic importance, particularly in Nicaragua. Here, we surveyed amplified fragment length polymorphisms across 13 populations of this species in Nicaragua to elucidate the relative roles of contemporary vs historical factors in shaping its genetic variation. Genetic diversity was low in all investigated populations (mean HE=0.125), and negatively correlated with latitude. Overall population differentiation was moderate (ΦST=0.109, P<0.001), and Bayesian analysis of population structure revealed two major latitudinal clusters (I: ‘Pacific North’+’Central Highland’; II: ‘Pacific South’), along with a genetic cline between I and II. Population-based cluster analyses indicated a strong pattern of ‘isolation by distance’ as confirmed by Mantel’s test. Our results suggest that (1) the low genetic diversity of these populations reflects biogeographic/population history (colonisation from South America, Pleistocene range contractions) rather than recent human impact; whereas (2) the underlying process of their isolation by distance pattern, which is best explained by ‘isolation by dispersal limitation’, implies contemporary gene flow between neighbouring populations as likely facilitated by the species’ efficient seed dispersal capacity. Overall, these results underscore that even tree species from highly decimated forest regions may be genetically resilient to habitat fragmentation due to species-typical dispersal characteristics, the necessity of broad-scale measures for their conservation notwithstanding.",
           url = "https://doi.org/10.1038/hdy.2017.45",
           download_date = "2021-12-03",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "location_sites_Davila_Lara.csv"))


# manage ontology ---
#
# define labels in the new dataset and their matching already harmonised labels
matches <- tibble(new = c(unique(data$Code)),
                  old = c( "Forest land", "Undisturbed Forest", "Forest land",
                           "Forest land", "Forest land", "Undisturbed Forest", "Forest land",
                           "Forest land", "Forest land","Forest land", "Undisturbed Forest",
                           "Undisturbed Forest", "Undisturbed Forest"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)


# harmonise data ----
#
temp <- data %>%
  mutate(
    x = Long,
    y = Lat,
    year = "2013-",
    month = "4_5_6_8",
    day = "-01",
    datasetID = thisDataset,
    country = "Nicaragua",
    irrigated = FALSE,
    externalID = Code,
    externalValue = Code,
    presence = TRUE,
    area = NA_real_,
    type = "point",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(month, sep = "_") %>%
  mutate(
    fid = row_number(),
    date = ymd(paste0(year, month, day))) %>%
  select(datasetID, fid, country, x, y, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())

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
