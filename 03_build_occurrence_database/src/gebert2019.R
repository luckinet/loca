# script arguments ----
#
thisDataset <- "Gebert2019"
description <- "This data set contains plot data on climate, land area, land use, primary productivity, conservation and domestic mammals for explaining the diversity of wild mammals on Mount Kilimanjaro, Tanzania. This data set includes data on mammal diversity from 66 study plots along elevation and land use gradients on Mount Kilimanjaro."
url <- "https://doi.org/10.1594/PANGAEA.903710 https://"
licence <- "CC-BY-4.0"


# reference ----
#
bib <- ris_reader(paste0(thisPath, "KiLi_mammals_diversity.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-05-14"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
dataLoc <- read_delim(file = paste0(thisPath, "KiLi_mammals_diversity.tab"), trim_ws = T, skip = 9, col_names = F, n_max = 65, delim = " ")
dataLoc <- dataLoc %>%
  mutate(X1 = str_remove_all(X1, "^Event[()]s[()]:"),
         X1 = trimws(X1)) %>%
  select(Event = X1, Longitude = X7, Latitude = X4, commo = X20)

data <- read_tsv(file = paste0(thisPath, "KiLi_mammals_diversity.tab"), skip = 90) %>%
  left_join(., dataLoc, by = "Event") %>%
  mutate(ontology = paste(`Land use`, commo, sep = "_"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Tanzania",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = 0.25 * 10000,
    date = NA,
    # year = 2016,
    # month = "05_06_07_08_09",
    # day = NA_integer_,
    externalID = NA_character_,
    externalValue = ontology,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(month, sep = "_") %>%
  mutate(fid = row_number(),
         month = as.numeric(month)) %>%
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

# matches <- tibble(new = c(unique(data$ontology)),
#                   old = c("coffee", "Naturally Regenerating Forest", "Undisturbed Forest", "Grass crops",
#                           "Grass crops", "Shrubland", "Permanent cropland", "maize",
#                           "Other Wooded Areas", NA))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
