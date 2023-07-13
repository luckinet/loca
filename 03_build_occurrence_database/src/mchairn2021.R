# script arguments ----
#
thisDataset <- "McHairn2021"
description <- "This data set contains in situ measurements of crop density, height, and biomass collected for the Soil Moisture Active Passive Validation Experiment 2016 Manitoba (SMAPVEX16 Manitoba) campaign."
url <- "https://doi.org/10.5067/PP14EED9ZOE2 https://"
licence <- ""


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
           description = description,
           url = url,
           download_date = ymd("2022-01-18"),
           type = "static",
           licence = licence,
           contact = "nsidc@nsidc.org",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)



# read dataset ----
#
data <- st_read(dsn = paste0(thisPath, "5000002235744/223877708/SMAPVEX16_MB_v4.gdb"), layer = "FieldSites") %>%
  left_join(read_csv(paste0(thisPath, "5000002235744/223877695/SV16M_V_CropDensity_Vers3.csv")))


# harmonise data ----
#
temp <- data %>%
  bind_cols(st_coordinates(data$Shape) %>% as_tibble()) %>%
  st_drop_geometry() %>%
  as_tibble() %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = X,
    y = Y,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = year(SEED_DATE),
    # month = month(SEED_DATE),
    # day = day(SEED_DATE),
    externalID = NA_character_,
    externalValue = CROP,
    irrigated = NA,
    presence = TRUE,
    sample_type = "field",
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

# matches <- tibble(new = unique(data$CROP),
#                   old = c("wheat", "rapeseed", "maize", "soybean", "alfalfa",
#                           "oat", "bean"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
