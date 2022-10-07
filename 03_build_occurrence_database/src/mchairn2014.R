# script arguments ----
#
thisDataset <- "McHairn2014"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


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
           description = "This data set contains in situ vegetation data collected at several agricultural sites as a part of the Soil Moisture Active Passive Validation Experiment 2012 (SMAPVEX12).",
           url = "https://doi.org/10.5067/X2EF9ZKL0DGC",
           download_date = "2022-01-18",
           type = "static",
           licence = "none",
           contact = "nsidc@nsidc.org",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "5000002235738/173027028/Field_Sites_ver4_coords")) %>%
  left_join(read_csv(paste0(thisPath, "5000002235738/50514315/SV12VA_Crop_Height_Diam_ver4.txt")), by = "Site_ID") %>%
  left_join(read_csv(paste0(thisPath, "5000002235738/50514313/SV12VA_Crop_Biomass_ver4.txt")), by = "Site_ID")


# manage ontology ---
#
matches <- tibble(new = unique(data$Crop_Type),
                  old = c(NA, "soybean", "Permanent grazing", "wheat", "rapeseed",
                          "Grass and fodder crops", "Grass and fodder crops",
                          "maize", "wheat", "oat", "rapeseed", "rapeseed", "bean"))

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
  distinct(Site_ID, X, Y, Date, Crop_Type) %>%
  mutate(
    fid = row_number(),
    type = "point",
    x = X,
    y = Y,
    geometry = NA,
    date = mdy(Date),
    year = year(date),
    month = month(date),
    day = day(date),
    datasetID = thisDataset,
    country = NA_character_,
    irrigated = NA,
    area = NA_real_,
    presence = TRUE,
    externalID = Site_ID,
    externalValue = Crop_Type,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 32614) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
