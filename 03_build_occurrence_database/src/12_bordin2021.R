# script arguments ----
#
thisDataset <- "Bordin2021"
description <- "Subtropical forests certainly contribute to terrestrial global carbon storage, but we have limited understanding about the relative amounts and of the drivers of above-ground biomass (AGB) variation in their region. Here we assess the spatial distribution and drivers of AGB in 119 sites across the South American subtropical forests. We applied a structural equation modelling approach to test the causal relationships between AGB and environmental (climate and soil), structural (proportion of large-sized trees) and community (functional and species diversity and composition) variables. The AGB on subtropical forests is on average 246 Mg ha−1. Biomass stocks were driven directly by temperature annual range and the proportion of large-sized trees, whilst soil texture, community mean leaf nitrogen content and functional diversity had no predictive power. Temperature annual range had a negative effect on AGB, indicating that communities under strong thermal amplitude across the year tend to accumulate less AGB. The positive effect of large-sized trees indicates that mature forests are playing a key role in the long-term persistence of carbon storage, as these large trees account for 64% of total biomass stored in these forests. Our study reinforces the importance of structurally complex subtropical forest remnants for maximising carbon storage, especially facing future climatic changes predicted for the region.",
url <- "https://doi.org/10.1016/j.foreco.2021.119126 https://"
licence <- ""


# reference ----
#
bib <- bibtex_reader(x = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "bordin.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-09-13"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "forestPlots_Bordin.xlsx"))
yearArea <-  read_xlsx(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "plotArea.xlsx")) %>%
  rename(site = Site) %>%
  left_join(., read_xlsx(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "data_years.xlsx")), by = "site")


# pre-process data ----
#
data <- left_join(data, yearArea, by = "site") %>%
  distinct(long, lat, forest_type, year, .keep_all = TRUE)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Brazil",
    x = long,
    y = lat,
    geometry = NA,
    epsg = 4326,
    area = as.numeric(`Sampled area (ha)`)*10000,
    date = ymd(paste0(year, "-01-01")),
    externalID = site,
    externalValue = forest_type,
    irrigated = FALSE,
    presence = TRUE,
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

# matches <- tibble(new = c(data$forest_type),
#                   old = "Undisturbed Forest")

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
