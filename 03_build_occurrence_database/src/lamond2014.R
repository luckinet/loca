# script arguments ----
#
thisDataset <- "Lamond2014"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "doi 10.34725_DVN_25331.ris"))

regDataset(name = thisDataset,
           description = "CAFNET research has elicited local agro-ecological knowledge from coffee growing areas within the vicinity of forest reserves in Kenya, Uganda and Rwanda. Knowledge was acquired from over 200 farmers in a stratified purposive sample, using a knowledge based systems approach. Ranking and phenology survey Building on the local knowledge studies and on-farm tree inventories, we designed a ranking and phenology survey to be applied across the 100 farms in the three counties to test consistency of farmer knowledge about physical attributes and phenology of trees found in coffee plots and along coffee plot boundaries. (2014-03) ",
           url = "https://doi.org/10.34725/DVN/25331",
           download_date = "2022-05-31",
           type = "static",
           licence = "CC BY-NC-SA 3.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#
dataK <- read_tsv(file = paste0(thisPath, "Farm_GPS_data_Kenya.tab"))
dataR <- read_tsv(file = paste0(thisPath, "Farm_GPS_data_Rwanda.tab"))
dataU <- read_excel(paste0(thisPath, "Farm_GPS_data_Uganda.xlsx"))



# harmonise data ----
#
dataK <- dataK %>%
  mutate(country = "Kenya",
         Farm_number = Farm,
         Cooperative = Factory)

dataR <- dataR %>%
  mutate(country = "Rwanda")

dataU <- dataU %>%
  mutate(country = "Uganda",
         "Lat(S)" = `Lat (S)`,
         "Long(E)" = `Long (E)`)

data <- bind_rows(dataR, dataU, dataK)


temp <- data %>%
  mutate(
    datasetID = thisDataset,
    type = "point",
    x = `Lat(S)`,
    y = `Long(E)`,
    geometry = NA,
    year = "2009_2010_2011",
    month = NA_real_,
    day = NA_integer_,
    country = NA_character_,
    irrigated = F,
    area = NA_real_,
    presence = F,
    externalID = NA_character_,
    externalValue = "coffee",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = as.numeric(year),
         fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
