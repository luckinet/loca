# script arguments ----
#
thisDataset <- "Lesiv2020"
description <- "The data set, in a form of table, contains information on Human Impact on Forests that was collected during a few crowd sourcing campaigns (Human Impact on Tropical Forest, Human Impact on Temperate Forest and Human Impact on Boreal Forest). the data set is not yet final. We expect to publish the final version under Open Access in nearest future."
url <- "https://doi.org/ https://zenodo.org/record/3356758"
licence <- "none yet"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "ref.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2020-10-21"),
           type = "static",
           licence = licence,
           contact = "Myroslava Lesiv",
           disclosed = FALSE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "final_training_data.csv"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = NA_real_,
    y = NA_real_,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = 2015,
    # month = NA_real_,
    # day = NA_integer_,
    externalID = as.character(location_id),
    externalValue = as.character(level12),
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "visual interpretation",
    collector = "citizen scientist",
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

# matches <- tibble(new = as.character(unique(data$level12)),
#                   old = c("Palm plantations", "Undisturbed Forest", NA,
#                           "Tree orchards", "Naturally Regenerating Forest",
#                           "Woody plantation", "Tree orchards",
#                           "Undisturbed Forest", "Planted Forest"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
