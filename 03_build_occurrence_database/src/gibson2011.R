# script arguments ----
#
thisDataset <- "Gibson2011"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_nature10425-citation.ris"))

regDataset(name = thisDataset,
           description = "Primary tropical forests sustain the majority of Earth's terrestrial biodiversity, but they have faced considerable degradation, and in many locations have been replaced by agriculture, plantations and secondary forests. A meta-analysis of the biodiversity consequences of such changes in land use suggests that with the possible exception of selective logging, all changes from primary forest cause substantial falls in biodiversity, and secondary forests are poor substitutes for primary forest.",
           url = "https://doi.org/10.1038/nature10425",
           download_date = "2022-01-25",
           type = "static",
           licence = NA_character_,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xls(paste0(thisPath, "41586_2011_BFnature10425_MOESM254_ESM.xls"), sheet = 1) %>%
  left_join(read_xls(paste0(thisPath, "41586_2011_BFnature10425_MOESM254_ESM.xls"), sheet = 2), by = "study.ID")


# manage ontology ---
#
matches <- read_csv(paste0(thisPath, "gibson_ontology.csv"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 2)


# harmonise data ----
#
temp <- data %>%
  separate(latitude, c("y","y_direction"), sep = " ") %>%
  separate(longitude, c("x","x_direction"), sep = " ") %>%
  mutate(y = as.double(y),
         x = as.double(x)) %>%
  mutate(y = case_when(y_direction == "S" ~ y * -1,
                       y_direction == "N" ~ y),
         x = case_when(x_direction == "W" ~ x * -1,
                       TRUE ~ x)) %>%
  distinct(x, y, study.ID, disturbance.specific, .keep_all = TRUE) %>%
  mutate(
    fid = row_number(),
    year = NA_real_,
    month = NA_real_,
    day = NA_integer_,
    datasetID = thisDataset,
    irrigated = F,
    externalID = as.character(row.ID),
    externalValue = disturbance.specific,
    presence = TRUE,
    type = "point",
    area = NA_real_,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "meta study",
    collector = "expert",
    purpose = "study",
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
