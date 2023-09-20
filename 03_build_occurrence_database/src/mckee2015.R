# script arguments ----
#
thisDataset <- "McKee2015"
description <- "This data set includes in situ vegetation data collected during the Soil Moisture Active Passive Validation Experiment 2008 (SMAPVEX08) campaign. Sampling was designed to coincide with satellite overpasses, such as Landsat's Thematic Mapper (TM) 5 and the Moderate Resolution Imaging Spectroradiometer (MODIS) sensor on NASA's Terra satellite (MODIS/Terra), which can be then used to estimate vegetation water content on the regional scale."
url <- "https://doi.org/10.5067/US4X5QPYH6DB https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", ""))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("2022-11-01"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(path = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "SV08V_Sum_VEG_SMAPVEX.xls"), skip = 5)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "USA",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(Date),
    externalID = Field,
    externalValue = Crop,
    irrigated = NA,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "validation") %>%
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

# newConcepts <- tibble(target = case_when(str_match(unique(data$Crop), pattern = "SB") == "SB" ~ "soybean",
#                                          is.character(unique(data$Crop)) ~ "maize"),
#                       new = unique(data$Crop),
#                       class = "commodity",
#                       description = NA,
#                       match = "close",
#                       certainty = 3)

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
