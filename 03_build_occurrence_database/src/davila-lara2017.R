# script arguments ----
#
thisDataset <- "Davila-Lara2017"
description <- "The Central American seasonally dry tropical (SDT) forest biome is one of the worlds’ most endangered ecosystems, yet little is known about the genetic consequences of its recent fragmentation. A prominent constituent of this biome is Calycophyllum candidissimum, an insect-pollinated and wind-dispersed canopy tree of high socio-economic importance, particularly in Nicaragua. Here, we surveyed amplified fragment length polymorphisms across 13 populations of this species in Nicaragua to elucidate the relative roles of contemporary vs historical factors in shaping its genetic variation. Genetic diversity was low in all investigated populations (mean HE=0.125), and negatively correlated with latitude. Overall population differentiation was moderate (ΦST=0.109, P<0.001), and Bayesian analysis of population structure revealed two major latitudinal clusters (I: ‘Pacific North’+’Central Highland’; II: ‘Pacific South’), along with a genetic cline between I and II. Population-based cluster analyses indicated a strong pattern of ‘isolation by distance’ as confirmed by Mantel’s test. Our results suggest that (1) the low genetic diversity of these populations reflects biogeographic/population history (colonisation from South America, Pleistocene range contractions) rather than recent human impact; whereas (2) the underlying process of their isolation by distance pattern, which is best explained by ‘isolation by dispersal limitation’, implies contemporary gene flow between neighbouring populations as likely facilitated by the species’ efficient seed dispersal capacity. Overall, these results underscore that even tree species from highly decimated forest regions may be genetically resilient to habitat fragmentation due to species-typical dispersal characteristics, the necessity of broad-scale measures for their conservation notwithstanding."
url <- "https://doi.org/10.1038/hdy.2017.45 https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_hdy.2017.45-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-12-03"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "location_sites_Davila_Lara.csv"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Nicaragua",
    x = Long,
    y = Lat,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = "2013-",
    # month = "4_5_6_8",
    # day = "-01",
    externalID = Code,
    externalValue = Code,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(month, sep = "_") %>%
  mutate(
    fid = row_number(),
    date = ymd(paste0(year, month, day))) %>%
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

# matches <- tibble(new = c(unique(data$Code)),
#                   old = c( "Forest land", "Undisturbed Forest", "Forest land",
#                            "Forest land", "Forest land", "Undisturbed Forest", "Forest land",
#                            "Forest land", "Forest land","Forest land", "Undisturbed Forest",
#                            "Undisturbed Forest", "Undisturbed Forest"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
