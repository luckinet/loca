# script arguments ----
#
thisDataset <- "Silva2019"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Bibtex.bib"))

regDataset(name = thisDataset,
           description = "We present a forest inventory carried out in 129 plots (10 m x 50 m; 6.45 ha in total) dispersed in a grid (5 km x 5 km) located in a forest zone ecotone in the eastern part of Maracá Ecological Station. All stems (tree + palm) with diameter at breast height ≥ 10 cm were recorded, identified and measured. A total of 3040 stems were recorded (tree = 2815; palm = 225), corresponding to 42 botanic families and 140 identified species. Seven families and 20 genera contained unidentified taxa (12.2%). Sapotaceae (735 stems; 10 species), Leguminosae (409; 24) and Rubiaceae (289; 12) were the most abundant families. Peltogyne gracilipes Ducke (Leguminosae), Pradosia surinamensis (Eyma) T.D.Penn. (Sapotaceae) and Ecclinusa guianensis Eyma (Sapotaceae) were the species with the highest importance value index (~ 25%). The dominance (m2 ha-1) of these species corresponds to > 36% of the total value observed in the forest inventory. Our dataset provides complementary floristic and structure information on tree and palm in Maracá, improving our knowledge of this Amazonian ecotone forest.",
           url = "https://doi.org/10.3897/BDJ.7.e47025",
           type = "static",
           licence = "CC BY 4.0",
           bibliography = bib,
           download_date = "2021-12-17",
           contact = "see corresponding author",
           disclosed = "yes",
           update = TRUE)


# read dataset ----
#
data <- read_delim(paste0(thisPath, "occurrence.txt"), delim = ";")


# harmonise data ----
#
temp <- data %>%
mutate(year = "3-2017_12-2017") %>%
  separate_rows(year, sep = "_") %>%
  separate(year, into = c("month", "year"), sep = "-") %>%
  mutate(
    x = decimalLongitude,
    y = decimalLatitude,
    year = as.numeric(year),
    month = as.numeric(month),
    day = NA_integer_,
    presence = F,
    area = 100,
    type = "areal",
    geometry = NA,
    country = "Brazil",
    irrigated = F,
    externalID = as.character(id),
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326,
    datasetID = thisDataset,
    externalValue = "Undisturbed Forest",
    fid = row_number())%>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
