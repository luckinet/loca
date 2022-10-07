# script arguments ----
#
thisDataset <- "Gebert2019"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "KiLi_mammals_diversity.ris"))

regDataset(name = thisDataset,
           description = "This data set contains plot data on climate, land area, land use, primary productivity, conservation and domestic mammals for explaining the diversity of wild mammals on Mount Kilimanjaro, Tanzania. This data set includes data on mammal diversity from 66 study plots along elevation and land use gradients on Mount Kilimanjaro.",
           url = "https://doi.org/10.1594/PANGAEA.903710",
           download_date = "2022-05-14",
           type = "static",
           licence = "CC-BY-4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)



# pre-process data ----
#


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


# manage ontology ---
#
matches <- tibble(new = c(unique(data$ontology)),
                  old = c("coffee", "Naturally Regenerating Forest", "Undisturbed Forest", "Grass crops",
                          "Grass crops", "Shrubland", "Permanent cropland", "maize",
                          "Other Wooded Areas", NA))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)


# harmonise data ----
#

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    type = "areal",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    year = 2016,
    month = "05_06_07_08_09",
    day = NA_integer_,
    country = "Tanzania",
    irrigated = F,
    area = 0.25 * 10000,
    presence = T,
    externalID = NA_character_,
    externalValue = ontology,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(month, sep = "_") %>%
  mutate(fid = row_number(),
         month = as.numeric(month)) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
