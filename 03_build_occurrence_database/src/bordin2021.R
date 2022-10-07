# script arguments ----
#
thisDataset <- "Bordin2021"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(x = paste0(thisPath, "bordin.bib"))

regDataset(name = thisDataset,
           description = "Subtropical forests certainly contribute to terrestrial global carbon storage, but we have limited understanding about the relative amounts and of the drivers of above-ground biomass (AGB) variation in their region. Here we assess the spatial distribution and drivers of AGB in 119 sites across the South American subtropical forests. We applied a structural equation modelling approach to test the causal relationships between AGB and environmental (climate and soil), structural (proportion of large-sized trees) and community (functional and species diversity and composition) variables. The AGB on subtropical forests is on average 246 Mg ha−1. Biomass stocks were driven directly by temperature annual range and the proportion of large-sized trees, whilst soil texture, community mean leaf nitrogen content and functional diversity had no predictive power. Temperature annual range had a negative effect on AGB, indicating that communities under strong thermal amplitude across the year tend to accumulate less AGB. The positive effect of large-sized trees indicates that mature forests are playing a key role in the long-term persistence of carbon storage, as these large trees account for 64% of total biomass stored in these forests. Our study reinforces the importance of structurally complex subtropical forest remnants for maximising carbon storage, especially facing future climatic changes predicted for the region.",
           url = "https://doi.org/10.1016/j.foreco.2021.119126",
           type = "static",
           bibliography = bib,
           download_date = "2021-09-13",
           contact = "see corresponding author",
           licence = NA_character_,
           disclosed = "yes",
           update = TRUE,
           notes = NA_character_)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "forestPlots_Bordin.xlsx"))
yearArea <-  read_xlsx(paste0(thisPath, "plotArea.xlsx")) %>%
  rename(site = Site) %>%
  left_join(., read_xlsx(paste0(thisPath, "data_years.xlsx")), by = "site")

data <- left_join(data, yearArea, by = "site")

# manage ontology ---
#

matches <- tibble(new = c(data$forest_type),
                  old = "Undisturbed Forest")

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)

# harmonise data ----
#
unique_data <- data %>%
  distinct(long,lat,forest_type, year, .keep_all = TRUE)

temp <- unique_data %>%
  mutate(x = long,
         y = lat,
         externalID = site,
         date = ymd(paste0(year, "-01-01")),
         fid = row_number(),
         country = "Brazil",
         datasetID = thisDataset,
         irrigated = FALSE,
         area = as.numeric(`Sampled area (ha)`)*10000,
         presence = TRUE,
         type = "areal",
         geometry = NA,
         externalValue = forest_type,
         LC1_orig = NA_character_,
         LC2_orig = NA_character_,
         LC3_orig = NA_character_,
         sample_type = "field",
         collector = "expert",
         purpose = "study",
         geometry = NA,
         epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")


