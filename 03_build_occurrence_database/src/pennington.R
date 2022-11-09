# script arguments ----
#
thisDataset <- "Pennington2018"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "Forest plot inventory data from seasonally dry and moist Atlantic forest in Rio de Janeiro State"
url <- "http://dx.doi.org/10.5521/forestplots.net/2018_3"
license <- "CC-BY-SA 4"

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Pennington.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2021-08-06",
           type = "static",
           licence = "CC-BY-SA 4",
           contact = NA_character_,
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "forestPlots_Pennington.csv"))


# harmonise data ----
#
data <- data %>%
  separate(`Last Census Date`, into = c("yearL", "rest"))
data <- data %>%
  separate(`Date Established`, into = c("yearF", "rest"))
data$year <- paste(data$yearL, data$yearF, sep = "_")
data <- data %>%
  separate_rows(year, sep = "_")

temp <- data %>%
  distinct(year, `Longitude Decimal`, `Latitude Decimal`, .keep_all = T) %>%
  mutate(
    fid = row_number(),
    x = `Longitude Decimal`,
    y = `Latitude Decimal`,
    date = ymd(paste0(year, "-01-01")),
    datasetID = thisDataset,
    country = tolower(Country),
    irrigated = F,
    externalID = `Plot Code`,
    type = "point",
    presence = F,
    area = NA_real_,
    geometry = NA,
    externalValue = "Forests",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
