# script arguments ----
#
thisDataset <- "plantVillage"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibentry(
  title = "PlantVillage Kenya Ground Reference Crop Type Dataset",
  bibtype = "Misc",
  author = person("PlantVillage ", role = "aut"),
  year = 2019,
  doi = "https://doi.org/10.34911/RDNT.U41J87"
)

regDataset(name = thisDataset,
           description = "",
           url = "https://doi.org/10.34911/RDNT.U41J87",
           download_date = "2021-02-02",
           type = "static",
           licence = NA_character_,
           contact = "ml@radiant.earth",
           disclosed = "no",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- st_read(paste0(thisPath, "ref_african_crops_kenya_01_labels/ref_african_crops_kenya_01_labels_00/labels.geojson")) %>%
  bind_rows(st_read(paste0(thisPath, "ref_african_crops_kenya_01_labels/ref_african_crops_kenya_01_labels_01/labels.geojson"))) %>%
  bind_rows(st_read(paste0(thisPath, "ref_african_crops_kenya_01_labels/ref_african_crops_kenya_01_labels_02/labels.geojson"))) %>%
pivot_longer(cols = Crop1:Crop5, values_to = "externalValue")

# manage ontology ---
#
matches <- tibble(new = c(unique(data$externalValue)),
                  old = c("cassava", NA,
                          "maize", "peanut",
                          "bean", "sorghum",
                          "cow pea", "soybean",
                          "Fallow", "millet",
                          "tomato", "sugarcane",
                          "sweet potato", "banana",
                          "cabbage"))


getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)

# harmonise data ----
#
temp <- st_transform(data, crs = 4326) %>%
  st_make_valid() %>%
  mutate(ID = row_number(),
         area = st_area(.))

temp <- temp %>%
  st_centroid(.) %>%
  select(cent.geometry = geometry,
         ID) %>%
  left_join(., as_tibble(temp), by = "ID")

# tidy times
survey <- temp %>% select(-Planting.Date) %>%
  rename(date = Survey.Date)
planting <- temp %>% select(-Survey.Date) %>%
  rename(date = Planting.Date)
temp <- bind_rows(survey, planting)

# assign NAs, drop them and get coordinates

temp <- temp %>%
  mutate(externalValue = na_if(externalValue, y = c("")),
         x = st_coordinates(.)[,1],
         y = st_coordinates(.)[,2]) %>%
  drop_na(externalValue)


temp <- temp %>%
  distinct(externalValue, date, geometry, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    geometry = geometry,
    date = ymd(date),
    country = "Kenya",
    irrigated = FALSE,
    area = as.numeric(area),
    presence = T,
    externalID = NA_character_,
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
