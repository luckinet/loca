# script arguments ----
#
thisDataset <- "Schneider2020"
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
           download_date = ymd("2021-12-17"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Data/Plot_locations.csv"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "United States of America",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = 1.42 * 10000,
    date = ymd(paste0("1964", "-01-01")),
    externalID = Plot,
    externalValue = "Forests",
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
