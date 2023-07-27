# script arguments ----
#
thisDataset <- "Schneider2020"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "This data publication includes data used in Spatial aspects of structural complexity in Sitka spruce – western hemlock forests, including evaluation of a new canopy gap delineation method by Schneider and Larson (2017). These data represent trees and plots from a study led by Vernon LaBau for his M.S. Thesis at Oregon State University, which he completed in 1967. Data were collected in 1964 on ten, 1.42 hectare plots (laid out as 5 by 7 chains). Data include tree location within subplots, tree species, diameter at breast height, and height in logs."
url <- "https://doi.org/10.2737/RDS-2020-0025"
license <- ""

# reference ----
#
bib <- bibentry(
  bibtype = "Misc",
  title = "Southeast Alaska old-growth forest stem map data collected in 1964 on ten 1.42 hectare plots",
  year = "2020",
  url = "https://doi.org/10.2737/RDS-2020-0025",
  adress = "Fort Collins, CO",
  publisher = "Forest Service Research Data Archive",
  author = c(person("Eryn E.", "Schneider"),
             person("Justin S.", "Crotteau, "),
             person("Andrew J", "Larson")
    ))

regDataset(name = thisDataset,
           description = description,
           url = url,
           type = "static",
           licence = licence,
           bibliography = bib,
           download_date = "2021-12-17",
           contact = "see corresponding author",
           disclosed = "yes",
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Data/Plot_locations.csv"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    x = Longitude,
    y = Latitude,
    date = ymd(paste0("1964", "-01-01")),
    country = "United States of America",
    irrigated = F,
    externalID = Plot,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    externalValue = "Forests",
    datasetID = thisDataset,
    type = "areal",
    area = 1.42 * 10000,
    geometry = NA,
    presence = F,
    epsg = 4326,
    fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
