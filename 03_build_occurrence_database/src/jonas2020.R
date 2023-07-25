# script arguments ----
#
thisDataset <- "Jonas2020"
description <- "Data for this study were collected in six Douglas-fir (Pseudotsuga menziesii) stands between 23 to 26 years old in the Capitol State Forest in western Washington beginning with pre-treatment measurements in 2005. Each stand contained at least 240 trees that were larger than 10 centimeters (cm) at 1.3 meters (m) bole height above the ground, diameter at breast height (DBH). Trees within the stand were stratified by DBH class then randomly assigned to one of 16 treatments with each DBH class represented in each treatment resulting in a total of 1,440 study trees. Trees were assigned to bole damage, root damage, bole and root damage, or control treatments. Bole damage resulted from removing bark from a percentage of bole circumference (20%, 40%, 60%, 80%, 90%, or 100%) along either 1 m or 2 m of bole. Root damage was targeted to damage 25% or 50% of the root cross sectional area. Controls did not damage roots or the bole. Tree DBH, total height, height to live crown, mortality status, and average wound callus width and height were recorded periodically over a ten year period after treatments were applied."
url <- "https://doi.org/10.2737/RDS-2020-0031 https://"
licence <- ""


# reference ----
#
bib <-  bibentry(
  bibtype = "Misc",
  title = "Data for ten-year growth, survival, and wound closure response to bole, root, and crown damage in young Douglas-fir trees",
  institution = "Forest Service Research Data Archive",
  year = "2020",
  author = person(c("Dryw A.", "Jones"))
)

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-22"),
           type = "static",
           licence = licence,
           contact = "dave.thornton@usda.gov",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Data/CF_Damage_Study_Data_10_year.csv"))


# harmonise data ----
#
temp <- data %>%
  distinct(StandLatitude, StandLongitude, MeasurementYear, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "USA",
    x = StandLongitude,
    y = StandLatitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(paste0(MeasurementYear, "-01-01")),
    externalID = NA_character_,
    externalValue = "Planted Forest",
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
