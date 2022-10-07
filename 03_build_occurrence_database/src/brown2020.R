# script arguments ----
#
thisDataset <- "Brown2020"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

 # reference ----
#
bib <- bibtex_reader(paste0(thisPath, "S0378112720310057.bib")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "High deforestation rates, especially in the tropics, currently result in the annual emission of large amounts of carbon, contributing to global climate change. There is therefore an urgent need to take actions to mitigate climate change both by slowing down deforestation and by initiating new sinks. Tropical forest plantations are generally thought to sequester carbon rapidly during the initial years but there is limited knowledge on their long-term potential. In this study, we assessed the carbon sequestration in old (42–47 years) timber plantations of Aucoumea klaineana, Cedrela odorata, Tarrietia utilis, and Terminalia ivorensis, and secondary forests of similar ages, by comparing their basal areas and above-ground carbon stocks (AGC) to that of nearby primary forests. Additionally, we estimated and compared timber volume and stumpage value in the three forest types. Systematic random sampling of ninety-three 20 m × 20 m plots in eleven forest sites (2 secondary forests, 2 primary forests, and 7 timber plantations) was undertaken to determine the effect of forest type on AGC, basal area, timber volume, and stumpage value. After 42 years of growth, mean AGC of the timber plantations (159.7 ± 14.3 Mg ha−1) was similar to that of primary forests (173.0 ± 25.1 Mg ha−1) and both were significantly higher than the mean AGC of the secondary forests (103.6 ± 12.3 Mg ha−1). Mean basal area and timber volume of the timber plantations and secondary forests were similar to that of the primary forests, though in each case the timber plantations had significantly higher values compared to the secondary forests. Mean timber value of the plantations ($8577 ha−1) was significantly higher than both secondary ($1870 ha−1) and primary forests ($3112 ha−1). Contrary to our expectations, naturally regenerated trees (woody recruits) within the timber plantations had similar AGC levels, basal area, timber volume, and value compared to the secondary forests. Long-rotation tropical forest plantations under low-intensity management could achieve higher AGC levels and thus have higher climate change mitigation potential and timber values compared to naturally regenerated secondary forests, and are able to reach values similar to primary forests. Monoculture timber plantations could facilitate the successful colonization of their understoreys by native woody recruits that contribute considerably to stand AGC and timber values. Long-rotation forest plantations in the tropics therefore have a critical role to play in forest rehabilitation and climate change mitigation while having the potential to provide modest financial returns to landowners through selective harvesting of timber and/or payments for carbon sequestration.",
           url = "https://www.sciencedirect.com/science/article/pii/S0378112720310057",
           type = "static",
           licence = "CC BY 4.0",
           bibliography = bib,
           download_date = "2021-12-16",
           contact = "see corresponding author",
           disclosed = "yes",
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Brown2020_data+.xlsx"))


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)
#luckinetID = case_when( site == "Secondary Forest" ~ 1132L,
#                        site == "Primary Forest" |  site == "Primary Forest (Reference)" ~ 1136L,
#                        TRUE ~ 1132L)

matches <- tibble(new = c("W-AK", "W-TU", "W-CO", "W-TI", "M-AK", "M-TI", "M-CO",
                          "W-SF", "M-SF",
                          "W-RF", "M-RF"),
                  old = c("Woody plantation", "Woody plantation", "Woody plantation", "Woody plantation", "Woody plantation", "Woody plantation", "Woody plantation",
                          "Naturally regenerating forest", "Naturally regenerating forest",
                          "Undisturbed Forest", "Undisturbed Forest"))

getConcept(label_en = matches$old) %>%
  # ... %>% apply some additional filters (optional)
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close", # in most cases that should be "close", see ?newMapping
             source = thisDataset,
             certainty = 3) # value from 1:3

# harmonise data ----
#
temp <- data %>%
  filter(row_number() %% 2 == 1)

long <- data %>%
  filter(row_number() %% 2 == 0)

temp <- temp %>%
  mutate(lat = `Latitude/Longitude`,
         long = long$`Latitude/Longitude`)

# extract and define seperators
chd = substr(temp$lat, 3, 3)[1]
chm = substr(temp$lat, 6, 6)[1]
chs = substr(temp$lat, 11, 11)[1]

temp <- temp %>%
  mutate(lat = as.numeric(char2dms(lat, chd = chd, chm = chm, chs = chs)),
         long = as.numeric(char2dms(long, chd = chd, chm = chm, chs = chs)))

temp <- temp %>%
  select(-c(`Area of Study Site (ha)`, `Mean Annual Rainfallb (mm)`,`Mean Annual Temperatureb (°C)`,`Mean No. of Dry Months/Yrc`)) %>%
  mutate(fid = row_number(),
         x = long,
         y = lat,
         country = "Ghana",
         year = NA_real_,
         month = NA_real_,
         day = NA_integer_,
         irrigated = FALSE,
         datasetID = thisDataset,
         externalID = `Site Code`,
         externalValue = `Site / Forest Type`,
         LC1_orig = NA_character_,
         LC2_orig = NA_character_,
         LC3_orig = NA_character_,
         sample_type = "field",
         collector = "expert",
         purpose = "study",
         geometry = NA,
         area = NA_real_,
         presence = TRUE,
         type = "point",
         epsg = 4326) %>%
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
