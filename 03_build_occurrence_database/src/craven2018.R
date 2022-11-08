# script arguments ----
#
thisDataset <- "Craven2018"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Bibtex.bib"))

regDataset(name = thisDataset,
           description = "OpenNahele is the first database that compiles data from a large number of forest plots across the Hawaiian archipelago to allow broad and high resolution studies of biodiversity patterns.",
           url = "https://doi.org/10.3897/BDJ.6.e28406",
           download_date = "2022-01-20",
           type = "static",
           licence = "CC-Zero",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "OpenNahele_Tree_Data.csv"))


# manage ontology ---
#


# harmonise data ----
#
temp <- data %>%
  distinct(Longitude, Latitude, Year, Plot_Area, .keep_all = TRUE) %>%
  mutate(
    fid = row_number(),
    type = "point",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    year = Year,
    month = NA_real_,
    day = NA_integer_,
    datasetID = thisDataset,
    country = "United States",
    irrigated = NA,
    area = Plot_Area,
    presence = TRUE,
    externalID = NA_character_,
    externalValue = "Forests",
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
