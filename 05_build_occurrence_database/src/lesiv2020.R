thisDataset <- "Lesiv2020"                                                         # the ID of this dataset
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, "ref.bib"))

data_path <- paste0(input_dir, "final_training_data.csv")

data <- read_csv(file = data_path)


message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1)

other <- data %>%
  select(obsID, crowd = X7) check here

schema_INSERT <-
  setFormat(header = 1L) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", type = "i", columns = 1) %>%
  setIDVar(name = "externalID", columns = 3) %>%
  setIDVar(name = "open", type = "l", value = FALSE) %>%
  setIDVar(name = "type", value = "point") %>%
  setIDVar(name = "x", type = "n", columns = 5) %>%
  setIDVar(name = "y", type = "n", columns = 6) %>%
  setIDVar(name = "epsg", value = "4326") %>%
  setIDVar(name = "date", columns = ymd("2015-01-01")) %>%
  setIDVar(name = "irrigated", type = "l", value = FALSE) %>%
  setIDVar(name = "present", type = "l", value = TRUE) %>%
  setIDVar(name = "sample_type", value = "visual interpretation") %>%
  setIDVar(name = "collector", value = "citizen scientist") %>%
  setIDVar(name = "purpose", value = "validation") %>%
  setObsVar(name = "concept", type = "c", columns = 7)

temp <- reorganise(schema = schema_INSERT, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "The data set, in a form of table, contains information on Human Impact on Forests that was collected during a few crowd sourcing campaigns (Human Impact on Tropical Forest, Human Impact on Temperate Forest and Human Impact on Boreal Forest). the data set is not yet final. We expect to publish the final version under Open Access in nearest future.",                                              # the abstract (if paper available) or project description
           homepage = "https://zenodo.org/record/3356758",
           date = ymd("2020-10-21"),
           license = "unknown",
           ontology = odb_onto_path)

# matches <- tibble(new = as.character(unique(data$level12)),
#                   old = c("Palm plantations", "Undisturbed Forest", NA,
#                           "Tree orchards", "Naturally Regenerating Forest",
#                           "Woody plantation", "Tree orchards",
#                           "Undisturbed Forest", "Planted Forest"))

out <- matchOntology(table = temp,
                     columns = "concept",
                     colsAsClass = FALSE,
                     dataseries = thisDataset,
                     ontology = odb_onto_path)


message(" --> writing output")
saveRDS(object = out, file = paste0(occurr_dir, "output/", thisDataset, ".rds"))
saveRDS(object = other, file = paste0(occurr_dir, "output/", thisDataset, "_extra.rds"))
saveBIB(object = bib, file = paste0(occurr_dir, "references.bib"))

beep(sound = 10)
message("\n     ... done")
