# script arguments ----
#
thisDataset <- "Jordan2020"
description <- "Eyespots evolved independently in many taxa as anti-predator signals. There remains debate regarding whether eyespots function as diversion targets, predator mimics, conspicuous startling signals, deceptive detection, or a combination. Although eye patterns and gaze modify human behaviour, anti-predator eyespots do not occur naturally in contemporary mammals. Here we show that eyespots painted on cattle rumps were associated with reduced attacks by ambush carnivores (lions and leopards). Cattle painted with eyespots were significantly more likely to survive than were cross-marked and unmarked cattle, despite all treatment groups being similarly exposed to predation risk. While higher survival of eyespot-painted cattle supports the detection hypothesis, increased survival of cross-marked cattle suggests an effect of novel and conspicuous marks more generally. To our knowledge, this is the first time eyespots have been shown to deter large mammalian predators. Applying artificial marks to high-value livestock may therefore represent a cost-effective tool to reduce livestock predation."
url <- "https://doi.org/10.1038/s42003-020-01156-0 https://"
licence <- "Attribution 4.0 International"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Jordan2020.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-22"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = NA,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Predation_exposure_risk_Master.csv"))


# pre-process data ----
#
data_sf <- st_as_sf(data, coords = c("Longitude_UTM", "Latitude_UTM"), crs =  st_crs("EPSG:22235"))
data <- data_sf %>%
  st_transform(., crs = "EPSG:4326")


# harmonise data ----
#
temp <- data %>%
  distinct(geometry, Date, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Botswana",
    x = st_coordinates(.)[,1],
    y = st_coordinates(.)[,2],
    geometry = geometry,
    epsg = 4326,
    area = NA_real_,
    date = dmy(Date),
    externalID = as.character(X1),
    externalValue = "Permanent grazing",
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
