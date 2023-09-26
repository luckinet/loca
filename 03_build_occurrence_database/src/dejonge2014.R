# script arguments ----
#
thisDataset <- "DeJonge2014"
description <- "Soil-derived branched glycerol dialkyl glycerol tetraethers (brGDGTs) in marine river fan sediments have a potential use for determining changes in the mean annual temperature (MAT) and pH of the river watershed soils. Prior to their incorporation in marine sediments, the compounds are transported to the marine system by rivers. However, emerging evidence suggests that the brGDGTs in freshwater systems can be derived from both soil run-off and in situ production. The production of brGDGTs in the river system can complicate the interpretation of the brGDGT signal delivered to the marine system. Therefore, we studied the distribution of brGDGT lipids in suspended particulate matter (SPM) of the Yenisei River. Chromatographic improvements allowed quantification of the recently described hexamethylated brGDGT isomer, characterized by having two methyl groups at the 6/6′ instead of the 5/5′ positions, in an environmental dataset for the first time. This novel compound was the most abundant brGDGT in SPM from the Yenisei. Its fractional abundance correlated well with that of the 6-methyl isomer of the hexamethylated brGDGT that contains one cyclopentane moiety. The Yenisei River watershed is characterized by large differences in MAT (>11 °C) as it spans a large latitudinal range (46–73°N), which would be expected to be reflected in brGDGT distributions of its soils. However, the brGDGT distributions in its SPM show little variation. Furthermore, the reconstructed pH values are high compared to the watershed soil pH. We, therefore, hypothesize that the brGDGTs in the Yenisei River SPM are predominantly produced in situ and not primarily derived from erosion of soil. This accounts for the absence of a change in the temperature signal, as the river water temperature is more stable. Using a lake calibration, the reconstructed temperature values agree with the mean summer temperatures (MST) recorded. The brGDGTs delivered to the sea by the Yenisei River during this season are thus not soil-derived, possibly complicating the use of brGDGTs in marine sediments for palaeoclimate reconstructions."
url <- "https://doi.org/10.1594/PANGAEA.877982 https://"
licence <- "CC-BY-3.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "")) # or bibtex_reader()

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-06-08"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_tsv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Yenisei_soil.tab"), skip = 47)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Russia ",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = 2009,
    # month = NA_real_,
    # day = NA_integer_,
    externalID = NA_character_,
    externalValue = `Soil type`,
    irrigated = FALSE,
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

# matches <- tibble(new = c(unique(data$`Soil type`)),
#                   old = c("Permanent cropland", "Inland wetlands", "Forests", "Herbaceous crops", "Forests", "Forests", "Shrubland"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
