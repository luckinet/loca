# script arguments ----
#
thisDataset <- "Bayas2021"
description <- "The data set is the result of the Drivers of Tropical Forest Loss crowdsourcing campaign. The campaign took place in December 2020. A total of 58 participants contributed validations of almost 120k locations worldwide. The locations were selected randomly from the Global Forest Watch tree loss layer (Hansen et al 2013), version 1.7. At each location the participants were asked to look at satellite imagery time series using a customized Geo-Wiki user interface and identify drivers of tropical forest loss during the years 2008 to 2019 following 3 steps: Step 1) Select the predominant driver of forest loss visible on a 1 km square (delimited by a blue bounding box); Step 2) Select any additional driver(s) of forest loss and; Step 3) Select if any roads, trails or buildings were visible in the 1 km bounding box. The Geo-Wiki campaign aims, rules and prizes offered to the participants in return for their work can be seen here: https://application.geo-wiki.org/Application/modules/drivers_forest_change/drivers_forest_change.html . The record contains 3 files: One “.csv” file with all the data collected by the participants during the crowdsourcing campaign (1158021 records); a second “.csv” file with the controls prepared by the experts at IIASA, used for scoring the participants (2001 unique locations, 6157 records) and a ”.docx” file describing all variables included in the two other files. A data descriptor paper explaining the mechanics of the campaign and describing in detail how the data was generated will be made available soon."
url <- "https://doi.org/10.22022/NODES/06-2021.122 https://" # doi, in case this exists and download url separated by empty space
licence <- "CC BY 4.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "")) # or bibtex_reader()

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("14-04-2022"),
           type = "static",
           licence = licence,
           contact = "corresponding author",
           disclosed = NA,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(thisPath, "ILUC_DARE_x_y/ILUC_DARE_campaign_x_y.csv"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = x,
    y = y,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = dmy("01-01-2008"),
    externalID = NA_character_,
    externalValue = "Forests",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "visual interpretation",
    collector = "citizen scientist",
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
