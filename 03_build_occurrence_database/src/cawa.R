# script arguments ----
#
thisDataset <- "CaWa"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "Land cover is a key variable in the context of climate change. In particular, crop type information is essential to understand the spatial distribution of water usage and anticipate the risk of water scarcity and the consequent danger of food insecurity. This applies to arid regions such as the Aral Sea Basin (ASB), Central Asia, where agriculture relies heavily on irrigation. Here, remote sensing is valuable to map crop types, but its quality depends on consistent ground-truth data. Yet, in the ASB, such data are missing. Addressing this issue, we collected thousands of polygons on crop types, 97.7% of which in Uzbekistan and the remaining in Tajikistan. We collected 8,196 samples between 2015 and 2018, 213 in 2011 and 26 in 2008. Our data compile samples for 40 crop types and is dominated by “cotton” (40%) and “wheat”, (25%). These data were meticulously validated using expert knowledge and remote sensing data and relied on transferable, open-source workflows that will assure the consistency of future sampling campaigns."
url <- "https://doi.org/10.6084/m9.figshare.12047478, https://doi.org/10.1038/s41597-020-00591-2"
license <- ""

# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_s41597-020-00591-2-citation.ris"))

regDataset(name = thisDataset,
           description = "Land cover is a key variable in the context of climate change. In particular, crop type information is essential to understand the spatial distribution of water usage and anticipate the risk of water scarcity and the consequent danger of food insecurity. This applies to arid regions such as the Aral Sea Basin (ASB), Central Asia, where agriculture relies heavily on irrigation. Here, remote sensing is valuable to map crop types, but its quality depends on consistent ground-truth data. Yet, in the ASB, such data are missing. Addressing this issue, we collected thousands of polygons on crop types, 97.7% of which in Uzbekistan and the remaining in Tajikistan. We collected 8,196 samples between 2015 and 2018, 213 in 2011 and 26 in 2008. Our data compile samples for 40 crop types and is dominated by “cotton” (40%) and “wheat”, (25%). These data were meticulously validated using expert knowledge and remote sensing data and relied on transferable, open-source workflows that will assure the consistency of future sampling campaigns.",
           url = "https://doi.org/10.6084/m9.figshare.12047478, https://doi.org/10.1038/s41597-020-00591-2",
           download_date = "2021-09-14",
           type = "static",
           contact = "see corresponding author",
           disclosed = "yes",
           licence = "",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- st_read(paste0(thisPath, "CAWa_CropType_samples.shp")) %>%
  separate_rows(label_1, sep = "-")

# manage ontology ---
#
newConcepts <- tibble(target = c("cotton", "wheat", NA,
                                 "Tree orchards", "rice", "VEGETABLES",
                                 "maize", "alfalfa", "melon",
                                 "Grapes", "Fallow", "sorghum",
                                 NA, "soybean", "barley",
                                 "carrot", "potato", "carrot",
                                 "cabbage", "onion", "bean",
                                 "sunflower", "tomato", "oat",
                                 "potato", "pumpkin"
                                 ),
                      new = unique(data$label_1),
                      class = c("commodity", "commodity", NA,
                                "land-use", "commodity", "group",
                                "commodity", "commodity", "commodity",
                                "group", "land-use", "commodity",
                                NA, "commodity", "commodity",
                                "commodity", "commodity", "commodity",
                                "commodity", "commodity", "commodity",
                                "commodity", "commodity", "commodity",
                                "commodity", "commodity"
                                ),
                      description = "",
                      match = "close",
                      certainty = 3)

luckiOnto <- new_source(name = thisDataset,
                        description = description,
                        date = Sys.Date(),
                        homepage = url,
                        license = license,
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = newConcepts$new,
                         target = get_concept(x = newConcepts %>% select(label = target), ontology = luckiOnto),
                         source = thisDataset,
                         description = newConcepts$description,
                         match = newConcepts$match,
                         certainty = newConcepts$certainty,
                         ontology = luckiOnto, matchDir = paste0(occurrenceDBDir, "concepts/"))


# harmonise data ----
#
sf_use_s2(FALSE)
temp <- data %>%
  st_make_valid(data) %>%
  st_centroid() %>%
  mutate(
    x = st_coordinates(.)[,1],
    y = st_coordinates(.)[,2]
  ) %>%
  select(x,y,sampler) %>%
  as.tibble()
sf_use_s2(TRUE)

temp <- bind_cols(data, temp)

temp <- temp %>%
  mutate(fid = row_number(),
         country = country,
         x = x,
         y = y,
         irrigated = FALSE,
         datasetID = thisDataset,
         externalID = NA_character_,
         externalValue = label_1,
         geometry = geometry...9,
         type = "areal",
         area = area...8,
         presence = T,
         date = ymd(date),
         LC1_orig = NA_character_,
         LC2_orig = NA_character_,
         LC3_orig = NA_character_,
         sample_type = "field",
         collector = "expert",
         purpose = "validation",
         epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
