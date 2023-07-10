# script arguments ----
#
thisDataset <- "Hoffman2019"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_s41467-019-12603-w-citation.ris"))

regDataset(name = thisDataset,
           description = "Protected areas (PA) are refugia of biodiversity. However, anthropogenic climate change induces a redistribution of life on Earth that affects the effectiveness of PAs. When species are forced to migrate from protected to unprotected areas to track suitable climate, they often face degraded habitats in human-dominated landscapes and a higher extinction threat. Here, we assess how climate conditions are expected to shift within the world’s terrestrial PAs (n=137,432). PAs in the temperate and northern high-latitude biomes are predicted to obtain especially high area proportions of climate conditions that are novel within the PA network at the local, regional and global scale by the end of this century. These PAs are predominantly small, at low elevation, with low environmental heterogeneity, high human pressure, and low biotic uniqueness. Our results guide adaptation measures towards PAs that are strongly affected by climate change, and of low adaption capacity and high conservation value.",
           url = "https://doi.org/10.1038/s41467-019-12603-w",
           download_date = "2022-01-22",
           type = "static",
           licence = "CC BY 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "CC_PA_revision2.csv"))


# manage ontology ---
#
# define labels in the new dataset and their matching already harmonised labels
matches <- tibble(new = c(unique(data$biome)),
                  old = c(NA, NA, "Forests",
                          "Forests", NA, "Forests",
                          "Forests", NA, "Forests",
                          "Forests", "Forests", "Forests",
                          NA, NA))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close", # in most cases that should be "close", see ?newMapping
             source = thisDataset,
             certainty = 3) # value from 1:3



# harmonise data ----
#
temp <- data %>%
  mutate(
    fid = row_number(),
    x = x,
    y = y,
    geometry = NA,
    year = NA_real_,
    month = NA_real_,
    day = NA_integer_,
    datasetID = thisDataset,
    country = NA_character_,
    irrigated = F,
    externalID = as.character(WDPAID),
    externalValue = biome,
    presence = T,
    type = "point",
    area = area * 1000000,
    LC1_orig = biome,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "meta study",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
