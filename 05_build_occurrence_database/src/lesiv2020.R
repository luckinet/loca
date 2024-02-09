# script arguments ----
#
thisDataset <- "Lesiv2020"
description <- "The data set, in a form of table, contains information on Human Impact on Forests that was collected during a few crowd sourcing campaigns (Human Impact on Tropical Forest, Human Impact on Temperate Forest and Human Impact on Boreal Forest). the data set is not yet final. We expect to publish the final version under Open Access in nearest future."
doi <- "https://zenodo.org/record/3356758"
licence <- ""

message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(occurr_dir, "input/", thisDataset, "/", "ref.bib"))


# read dataset ----
#
data_path <- paste0(occurr_dir, "input/", thisDataset, "/", "final_training_data.csv")

data <- read_csv(file = data_path, col_names = FALSE, col_types = cols(.default = "c"))


# data management ----
#


# matches <- tibble(new = as.character(unique(data$level12)),
#                   old = c("Palm plantations", "Undisturbed Forest", NA,
#                           "Tree orchards", "Naturally Regenerating Forest",
#                           "Woody plantation", "Tree orchards",
#                           "Undisturbed Forest", "Planted Forest"))

# harmonise data ----
#
data <- data %>%
  mutate(obsID = row_number(), .before = 1)                                     # define observation ID on raw data to be able to join harmonised data with the rest

schema_ <-
  setFormat(decimal = , thousand = , na_values = ) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", columns = 1) %>%
  setIDVar(name = "externalID", columns = 3) %>%
  setIDVar(name = "open", value = FALSE) %>%
  setIDVar(name = "type", value = "point") %>%
  setIDVar(name = "x", columns = 4) %>%
  setIDVar(name = "y", columns = 5) %>%
  setIDVar(name = "epsg", value = "4326") %>%
  setIDVar(name = "date", value = ymd("2015-01-01")) %>%
  setIDVar(name = "sample_type", value = "visual interpretation") %>%
  setIDVar(name = "collector", value = "citizen scientist") %>%
  setIDVar(name = "purpose", value = "validation") %>%
  setObsVar(name = "value", columns = 6) %>%
  setObsVar(name = "irrigated", value = FALSE) %>%
  setObsVar(name = "present", value = TRUE)

temp <- reorganise(schema = schema_, input = data)

otherData <- data %>%
  select()                                                                      # remove all columns that are recorded in 'out'


# harmonize with ontology ----
#
new_source(name = thisDataset,
           description = description,
           homepage = doi,
           date = ymd("2020-10-21"),
           license = licence,
           ontology = onto_path)

out <- matchOntology(table = temp,
                     columns = "value",
                     dataseries = thisDataset,
                     ontology = onto_path)


# write output ----
#
validateFormat(object = out) %>%
  saveRDS(file = paste0(occurr_dir, thisDataset, ".rds"))

saveRDS(object = otherData, file = paste0(occurr_dir, thisDataset, "_other.rds"))

read_lines(file = paste0(occurr_dir, "references.bib")) %>%
  c(bibtex_writer(z = bib, key = thisDataset)) %>%
  write_lines(file = paste0(occurr_dir, "references.bib"))


beep(sound = 10)
message("\n     ... done")
