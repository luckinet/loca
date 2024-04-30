# script arguments ----
#
thisDataset <- "Silva2019"
description <- "We present a forest inventory carried out in 129 plots (10 m x 50 m; 6.45 ha in total) dispersed in a grid (5 km x 5 km) located in a forest zone ecotone in the eastern part of Maracá Ecological Station. All stems (tree + palm) with diameter at breast height ≥ 10 cm were recorded, identified and measured. A total of 3040 stems were recorded (tree = 2815; palm = 225), corresponding to 42 botanic families and 140 identified species. Seven families and 20 genera contained unidentified taxa (12.2%). Sapotaceae (735 stems; 10 species), Leguminosae (409; 24) and Rubiaceae (289; 12) were the most abundant families. Peltogyne gracilipes Ducke (Leguminosae), Pradosia surinamensis (Eyma) T.D.Penn. (Sapotaceae) and Ecclinusa guianensis Eyma (Sapotaceae) were the species with the highest importance value index (~ 25%). The dominance (m2 ha-1) of these species corresponds to > 36% of the total value observed in the forest inventory. Our dataset provides complementary floristic and structure information on tree and palm in Maracá, improving our knowledge of this Amazonian ecotone forest."
url <- "https://doi.org/10.3897/BDJ.7.e47025 https://"
licence <- "CC BY 4.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Bibtex.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-12-17"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_delim(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "occurrence.txt"), delim = ";")


# harmonise data ----
#
temp <- data %>%
  mutate(year = "3-2017_12-2017") %>%
  separate_rows(year, sep = "_") %>%
  separate(year, into = c("month", "year"), sep = "-") %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Brazil",
    x = decimalLongitude,
    y = decimalLatitude,
    geometry = NA,
    epsg = 4326,
    area = 100,
    date = NA,
    # year = as.numeric(year),
    # month = as.numeric(month),
    # day = NA_integer_,
    externalID = as.character(id),
    externalValue = "Undisturbed Forest",
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = FALSE,
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

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
