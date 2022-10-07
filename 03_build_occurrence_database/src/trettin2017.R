# script arguments ----
#
thisDataset <- "Trettin2017"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibentry(
  bibtype = "Misc",
  title = "Mangrove carbon stocks in Zambezi River Delta, Mozambique",
  author = c(
    person("Carl C.", "Trettin", role = "aut", email = "carl.c.trettin@usda.gov"),
    person("Christina E.", "Stringer", role = "aut"),
    person("Stanley J.", "Zarnoch", role = "aut"),
    person("Wenwu", "Tang", role = "aut"),
    person("Zhaohua", "Dai", role = "aut")),
  year = "2017",
  url = "https://doi.org/10.2737/RDS-2017-0053",
  note = "Updated 25 March 2019",
  publisher = "Forest Service Research Data Archive",
  address = "Fort Collins, CO"
)

regDataset(name = thisDataset,
           description = "Carbon stocks in mangroves in the Zambezi River Delta of Mozambique (East Africa) were inventoried using a stratified random sampling approach from 2012 to 2016. A total 52 plots containing 287 subplots were objectively distributed using a GIS based spatial decision support system (SDSS) to represent the characteristics of mangroves and the operating constraints within the Delta area. The inventory was designed to provide estimates of above- and below-ground carbon stocks for the entire Delta. Data include species, height and diameter at breast height for overstory, understory and dead trees, mass of woody debris, litter, and ground vegetation. Data to estimate soil carbon and nitrogen content to 2 meters depth are also included.",
           url = "https://doi.org/10.2737/RDS-2017-0053",
           download_date = "",
           type = "static",
           licence = "CC0 1.0 Universal (CC0 1.0)",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#
data <- read_csv(paste0(thisPath, "Data/Zambezi_PlotLocations.csv"), locale = locale(decimal_mark = ","))

# harmonise data ----
#
temp <- data %>%
  rename(
    x = unique("Long"),
    y = unique("Lati")) %>%
  mutate(
    country = "Mozambique",
    month = NA_real_,
    day = NA_integer_,
    irrigated = F,
    externalID = as.character(Plot),
    datasetID = thisDataset,
    geometry = NA,
    area = NA_real_,
    presence = F,
    type = "point",
    externalValue = "Naturally Regenerating Forest",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326,
    fid = row_number())%>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
