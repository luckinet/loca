# script arguments ----
#
thisDataset <- "Jordan2020"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Jordan2020.bib"))

regDataset(name = thisDataset,
           description = "Eyespots evolved independently in many taxa as anti-predator signals. There remains debate regarding whether eyespots function as diversion targets, predator mimics, conspicuous startling signals, deceptive detection, or a combination. Although eye patterns and gaze modify human behaviour, anti-predator eyespots do not occur naturally in contemporary mammals. Here we show that eyespots painted on cattle rumps were associated with reduced attacks by ambush carnivores (lions and leopards). Cattle painted with eyespots were significantly more likely to survive than were cross-marked and unmarked cattle, despite all treatment groups being similarly exposed to predation risk. While higher survival of eyespot-painted cattle supports the detection hypothesis, increased survival of cross-marked cattle suggests an effect of novel and conspicuous marks more generally. To our knowledge, this is the first time eyespots have been shown to deter large mammalian predators. Applying artificial marks to high-value livestock may therefore represent a cost-effective tool to reduce livestock predation.",
           url = "https://doi.org/10.1038/s42003-020-01156-0",
           download_date = "2022-01-22",
           type = "static",
           licence = "Attribution 4.0 International",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Predation_exposure_risk_Master.csv"))


# harmonise data ----
#

# convert coords
data_sf <- st_as_sf(data, coords = c("Longitude_UTM", "Latitude_UTM"), crs =  st_crs("EPSG:22235"))
data <- data_sf %>%
  st_transform(., crs = "EPSG:4326")

temp <- data %>%
  distinct(geometry, Date, .keep_all = T) %>%
  mutate(
    fid = row_number(),
    x = st_coordinates(.)[,1],
    y = st_coordinates(.)[,2],
    date = dmy(Date),
    datasetID = thisDataset,
    country = "Botswana",
    irrigated = F,
    externalID = as.character(X1),
    externalValue = "Permanent grazing",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    presence = F,
    type = "point",
    area = NA_real_,
    geometry = geometry,
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


