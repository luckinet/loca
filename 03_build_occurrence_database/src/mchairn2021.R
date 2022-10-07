# script arguments ----
#
thisDataset <- "McHairn2021"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibentry(
  bibtype = "Misc",
  title= "SMAPVEX16 Manitoba In Situ Vegetation Data, Version 1",
  author=c(
    person=c("H.K.", "McNairn"),
    person=c("K.", "Gottfried"),
    person=c("J.", "Powers"),
    doi="https://doi.org/10.5067/PP14EED9ZOE2",
    institution="NASA National Snow and Ice Data Center Distributed Active Archive Center"
  )
)

regDataset(name = thisDataset,
           description = "This data set contains in situ measurements of crop density, height, and biomass collected for the Soil Moisture Active Passive Validation Experiment 2016 Manitoba (SMAPVEX16 Manitoba) campaign.",
           url = "https://doi.org/10.5067/PP14EED9ZOE2",
           download_date = "2022-01-18",
           type = "static",
           licence = "none",
           contact = "nsidc@nsidc.org",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- st_read(dsn = paste0(thisPath, "5000002235744/223877708/SMAPVEX16_MB_v4.gdb"), layer = "FieldSites") %>%
  left_join(read_csv(paste0(thisPath, "5000002235744/223877695/SV16M_V_CropDensity_Vers3.csv")))


# manage ontology ---
#
matches <- tibble(new = unique(data$CROP),
                  old = c("wheat", "rapeseed", "maize", "soybean", "alfalfa",
                          "oat", "bean"))

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
  bind_cols(st_coordinates(data$Shape) %>% as_tibble()) %>%
  st_drop_geometry() %>%
  as_tibble() %>%
  mutate(
    fid = row_number(),
    type = "point",
    x = X,
    y = Y,
    geometry = NA,
    year = year(SEED_DATE),
    month = month(SEED_DATE),
    day = day(SEED_DATE),
    datasetID = thisDataset,
    country = NA_character_,
    irrigated = NA,
    area = NA_real_,
    presence = TRUE,
    externalID = NA_character_,
    externalValue = CROP,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
