# script arguments ----
#
thisDataset <- "Annighoefer2015"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#

bib <- ris_reader(paste0(thisPath, "Oak_inven.ris"))

regDataset(name = thisDataset,
           description = "In supplement to: Annighöfer, P et al. (2015): Regeneration patterns of European oak species (Quercus petraea (Matt.) Liebl., Quercus robur L.) in dependence of environment and neighborhood. PLoS ONE, https://doi.org/10.1371/journal.pone.0134935",
           url = "https://doi.org/10.1594/PANGAEA.847281",
           download_date = "2022-01-14",
           type = "static",
           licence = "CC-BY-3.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_tsv(paste0(thisPath, "Oak_inven.tab"), skip = 20)

# harmonise data ----
#

temp <- data %>%
  distinct(Longitude, Latitude, Event, Comment) %>%
  mutate(
    x = Longitude,
    y = Latitude,
    year = "2011_2012_2013",
    month = NA_real_,
    day = NA_integer_,
    datasetID = thisDataset,
    country = "Germany",
    irrigated = FALSE,
    externalID = Event,
    presence = FALSE,
    externalValue = "Naturally regenerating forest",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    geometry = NA,
    area = 500,
    type = "areal",
    collector = "expert",
    purpose = "monitoring",
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = as.numeric(year),
         fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")

