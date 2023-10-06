# script arguments ----
#
thisDataset <- "Trettin2017"
description <- "Carbon stocks in mangroves in the Zambezi River Delta of Mozambique (East Africa) were inventoried using a stratified random sampling approach from 2012 to 2016. A total 52 plots containing 287 subplots were objectively distributed using a GIS based spatial decision support system (SDSS) to represent the characteristics of mangroves and the operating constraints within the Delta area. The inventory was designed to provide estimates of above- and below-ground carbon stocks for the entire Delta. Data include species, height and diameter at breast height for overstory, understory and dead trees, mass of woody debris, litter, and ground vegetation. Data to estimate soil carbon and nitrogen content to 2 meters depth are also included."
url <- "https://doi.org/10.2737/RDS-2017-0053 https://"
licence <- "CC0 1.0 Universal (CC0 1.0)"


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
           description = description,
           url = url,
           download_date = ymd(),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Data/Zambezi_PlotLocations.csv"), locale = locale(decimal_mark = ","))


# harmonise data ----
#
temp <- data %>%
  rename(
    x = unique("Long"),
    y = unique("Lati")) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Mozambique",
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = as.character(Plot),
    externalValue = "Naturally Regenerating Forest",
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
