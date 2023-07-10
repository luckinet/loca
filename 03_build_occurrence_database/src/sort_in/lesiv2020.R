# script arguments ----
#
thisDataset <- "Lesiv2020"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "ref.bib"))

regDataset(name = thisDataset,
           description = "The data set, in a form of table, contains information on Human Impact on Forests that was collected during a few crowd sourcing campaigns (Human Impact on Tropical Forest, Human Impact on Temperate Forest and Human Impact on Boreal Forest). the data set is not yet final. We expect to publish the final version under Open Access in nearest future.",
           url = "https://zenodo.org/record/3356758",
           download_date = "2020-10-21",
           type = "static",
           licence = "none yet",
           contact = "Myroslava Lesiv",
           disclosed = "no",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "final_training_data.csv"))


# manage ontology ---
#
matches <- tibble(new = as.character(unique(data$level12)),
                  old = c("Palm plantations", "Undisturbed Forest", NA,
                          "Tree orchards", "Naturally Regenerating Forest",
                          "Woody plantation", "Tree orchards",
                          "Undisturbed Forest", "Planted Forest"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = ., external = matches$new, match = "close",
             source = thisDataset, certainty = 3)


# harmonise data ----
#
temp <- data %>%
  mutate(
    fid = row_number(),
    type = "point",
    geometry = NA,
    year = 2015,
    month = NA_real_,
    day = NA_integer_,
    datasetID = thisDataset,
    country = NA_character_,
    irrigated = FALSE,
    area = NA_real_,
    presence = TRUE,
    externalID = as.character(location_id),
    externalValue = as.character(level12),
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "visual interpretation",
    collector = "citizen scientist",
    purpose = "validation",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
