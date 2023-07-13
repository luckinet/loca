# script arguments ----
#
thisDataset <- "McHairn2014"
description <- "This data set contains in situ vegetation data collected at several agricultural sites as a part of the Soil Moisture Active Passive Validation Experiment 2012 (SMAPVEX12)."
url <- "https://doi.org/10.5067/X2EF9ZKL0DGC https://"
licence <- ""


# reference ----
#
bib <- bibentry(
  bibtype = "Misc",
  title= "SMAPVEX12 In Situ Vegetation Data for Agricultural Area, Version 1",
  author=c(
    person=c("H.", "McNairn"),
    person=c("G.", "Wiseman"),
    person=c("J.", "Powers"),
    doi="https://doi.org/10.5067/X2EF9ZKL0DGC",
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
data <- read_csv(paste0(thisPath, "5000002235738/173027028/Field_Sites_ver4_coords")) %>%
  left_join(read_csv(paste0(thisPath, "5000002235738/50514315/SV12VA_Crop_Height_Diam_ver4.txt")), by = "Site_ID") %>%
  left_join(read_csv(paste0(thisPath, "5000002235738/50514313/SV12VA_Crop_Biomass_ver4.txt")), by = "Site_ID")


# harmonise data ----
#
temp <- data %>%
  distinct(Site_ID, X, Y, Date, Crop_Type) %>%
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
    date = mdy(Date),
    externalID = Site_ID,
    externalValue = Crop_Type,
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

# matches <- tibble(new = unique(data$Crop_Type),
#                   old = c(NA, "soybean", "Permanent grazing", "wheat", "rapeseed",
#                           "Grass and fodder crops", "Grass and fodder crops",
#                           "maize", "wheat", "oat", "rapeseed", "rapeseed", "bean"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
