# script arguments ----
#
thisDataset <- "Tedonzong2021"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "pericles_204577589.ris"))

regDataset(name = thisDataset,
           description = "Understanding the mechanisms governing the coexistence of organisms is an important question in ecology, and providing potential solutions contributes to conservation science. In this study, we evaluated the contribution of several mechanisms to the coexistence of two sympatric frugivores, using western lowland gorillas (Gorilla gorilla gorilla) and central chimpanzees (Pan troglodytes troglodytes) in a tropical rainforest of southeast Cameroon as a model system. We collected great ape fecal samples to determine and classify fruit species consumed; we conducted great ape nest surveys to evaluate seasonal patterns of habitat use; and we collected botanical data to investigate the distribution of plant species across habitat types in relation to their “consumption traits” (which indicate whether plants are preferred or fallback for either gorilla, chimpanzee, or both). We found that patterns of habitat use varied seasonally for both gorillas and chimpanzees and that gorilla and chimpanzee preferred and fallback fruits differed. Also, the distribution of plant consumption traits was influenced by habitat type and matched accordingly with the patterns of habitat use by gorillas and chimpanzees. We show that neither habitat selection nor fruit preference alone can explain the coexistence of gorillas and chimpanzees, but that considering together the distribution of plant consumption traits of fruiting woody plants across habitats as well as the pattern of fruit availability may contribute to explaining coexistence. This supports the assumptions of niche theory with dominant and subordinate species in heterogeneous landscapes, whereby a species may prefer nesting in habitats where it is less subject to competitive exclusion and where food availability is higher. To our knowledge, our study is the first to investigate the contribution of plant consumption traits, seasonality, and habitat heterogeneity to enabling the coexistence of two sympatric frugivores. ",
           url = "https://doi.org/10.5061/dryad.ms65f29",
           download_date = "2022-05-30",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# pre-process data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#
data <- read_csv(file = paste0(thisPath, "Botanical inventories 25x25m _for great apes coexistence2.csv"))


# manage ontology ---
#
# define labels in the new dataset and their matching already harmonised labels
matches <- tibble(new = c(unique(data$Habitat_type)),
                  old = c("Undisturbed Forest", "Naturally Regenerating Forest", "Naturally Regenerating Forest",
                          "Undisturbed Forest", "Inland wetlands"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)


# harmonise data ----
#
temp <- st_as_sf(data, coords = c("Longitude", "Latitude"), crs = CRS("EPSG:32633"))
temp <- st_transform(temp, crs = CRS("EPSG:4326"))
temp <- temp %>% mutate(lon =st_coordinates(temp)[,1],
                        lat =st_coordinates(temp)[,2]) %>% as.data.frame()


temp <- temp %>%
  mutate(
    datasetID = thisDataset,
    type = "areal",
    x = lon,
    y = lat,
    geometry = NA,
    year = "5-2015_6-2015_7-2015_8-2015_9-2015_10-2015_11-2015-12-2015_1-2016_2-2016_3-2016_4-2016_5-2016_6-2016_7-2016_8-2016_9-2016",
    month = NA_real_,
    day = NA_integer_,
    country = "Cameroon",
    irrigated = F,
    area = 625,
    presence = T,
    externalID = NA_character_,
    externalValue = Habitat_type,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "stidy",
    epsg = 4326) %>%
    separate_rows(year, sep = "_") %>%
    separate(year, into = c("month", "year")) %>%
    distinct(Habitat_type, year, month, lat, lon, .keep_all = T) %>%
    mutate(year = as.numeric(year),
           month = as.numeric(month),
           fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
