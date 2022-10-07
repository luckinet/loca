# script arguments ----
#
thisDataset <- "vanHooft2015"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1371_journal.pone.0111778.ris"))

regDataset(name = thisDataset,
           description = "",
           url = "", # ideally the doi, but if it doesn't have one, the main source of the database
           download_date = "", # YYYY-MM-DD
           type = "", # dynamic or static
           licence = "",
           contact = "", # optional, if it's a paper that should be "see corresponding author"
           disclosed = "", # whether the data are freely available "yes"/"no"
           bibliography = bib,
           update = TRUE)


# pre-process data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#

data <- read_csv(file = paste0(thisPath, "Ecological data Van Hooft et al. 2014.csv"))


# harmonise data ----
#

temp <- data %>%
  distinct(`longitude (degrees, dec.)`, `latitude (degrees, dec.)`, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    type = "point",
    x = `longitude (degrees, dec.)`,
    y = `latitude (degrees, dec.)`,
    geometry = NA,
    year = "9-1998_10-1998_11-1998",
    month = NA_real_,
    day = NA_integer_,
    country = "South Africa",
    irrigated = F,
    area = NA_real_,
    presence = F,
    externalID = NA_character_,
    externalValue = "buffalo",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  separate(year, sep = "-", into = c("month", "year")) %>%
  mutate(year = as.numeric(year),
         month = as.numeric(month),
         fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
