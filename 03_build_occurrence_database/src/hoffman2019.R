# script arguments ----
#
thisDataset <- "Hoffman2019"
description <- "Protected areas (PA) are refugia of biodiversity. However, anthropogenic climate change induces a redistribution of life on Earth that affects the effectiveness of PAs. When species are forced to migrate from protected to unprotected areas to track suitable climate, they often face degraded habitats in human-dominated landscapes and a higher extinction threat. Here, we assess how climate conditions are expected to shift within the world’s terrestrial PAs (n=137,432). PAs in the temperate and northern high-latitude biomes are predicted to obtain especially high area proportions of climate conditions that are novel within the PA network at the local, regional and global scale by the end of this century. These PAs are predominantly small, at low elevation, with low environmental heterogeneity, high human pressure, and low biotic uniqueness. Our results guide adaptation measures towards PAs that are strongly affected by climate change, and of low adaption capacity and high conservation value."
url <- "https://doi.org/10.1038/s41467-019-12603-w https://"
licence <- "CC BY 4.0"


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_s41467-019-12603-w-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-22"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "CC_PA_revision2.csv"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = x,
    y = y,
    geometry = NA,
    epsg = 4326,
    area = area * 1000000,
    date = NA,
    externalID = as.character(WDPAID),
    externalValue = biome,
    attr_1 = biome,
    attr_1_typ = "biome type",
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "meta study",
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

# matches <- tibble(new = c(unique(data$biome)),
#                   old = c(NA, NA, "Forests",
#                           "Forests", NA, "Forests",
#                           "Forests", NA, "Forests",
#                           "Forests", "Forests", "Forests",
#                           NA, NA))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
