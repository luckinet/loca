# script arguments ----
#
thisDataset <- "DeJonge2014"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "")) # or bibtex_reader()

regDataset(name = thisDataset,
           description = "Soil-derived branched glycerol dialkyl glycerol tetraethers (brGDGTs) in marine river fan sediments have a potential use for determining changes in the mean annual temperature (MAT) and pH of the river watershed soils. Prior to their incorporation in marine sediments, the compounds are transported to the marine system by rivers. However, emerging evidence suggests that the brGDGTs in freshwater systems can be derived from both soil run-off and in situ production. The production of brGDGTs in the river system can complicate the interpretation of the brGDGT signal delivered to the marine system. Therefore, we studied the distribution of brGDGT lipids in suspended particulate matter (SPM) of the Yenisei River. Chromatographic improvements allowed quantification of the recently described hexamethylated brGDGT isomer, characterized by having two methyl groups at the 6/6′ instead of the 5/5′ positions, in an environmental dataset for the first time. This novel compound was the most abundant brGDGT in SPM from the Yenisei. Its fractional abundance correlated well with that of the 6-methyl isomer of the hexamethylated brGDGT that contains one cyclopentane moiety. The Yenisei River watershed is characterized by large differences in MAT (>11 °C) as it spans a large latitudinal range (46–73°N), which would be expected to be reflected in brGDGT distributions of its soils. However, the brGDGT distributions in its SPM show little variation. Furthermore, the reconstructed pH values are high compared to the watershed soil pH. We, therefore, hypothesize that the brGDGTs in the Yenisei River SPM are predominantly produced in situ and not primarily derived from erosion of soil. This accounts for the absence of a change in the temperature signal, as the river water temperature is more stable. Using a lake calibration, the reconstructed temperature values agree with the mean summer temperatures (MST) recorded. The brGDGTs delivered to the sea by the Yenisei River during this season are thus not soil-derived, possibly complicating the use of brGDGTs in marine sediments for palaeoclimate reconstructions.",
           url = "https://doi.org/10.1594/PANGAEA.877982",
           download_date = "2022-06-08",
           type = "static",
           licence = "CC-BY-3.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# pre-process data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#

data <- read_tsv(file = paste0(thisPath, "Yenisei_soil.tab"), skip = 47)



# manage ontology ---
#
# define labels in the new dataset and their matching already harmonised labels
matches <- tibble(new = c(unique(data$`Soil type`)),
                  old = c("Permanent cropland", "Inland wetlands", "Forests", "Herbaceous crops", "Forests", "Forests", "Shrubland"))

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
 dplyr::mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    year = 2009,
    month = NA_real_,
    day = NA_integer_,
    country = "Russia ",
    irrigated = F,
    area = NA_real_,
    presence = T,
    externalID = NA_character_,
    externalValue = `Soil type`,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
