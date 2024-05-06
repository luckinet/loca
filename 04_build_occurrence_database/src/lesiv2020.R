# ----
# geography : Global
# period    : 2015
# typology  :
#   - cover  : VEGETATED
#   - use    : various
# features  : 226323
# data type : point
# doi/url   : https://www.nature.com/articles/s41597-022-01332-3
# authors   : Steffen Ehrmann
# date      : 2024-04-17
# status    : done
# comment   : _INSERT
# ----

thisDataset <- "lesiv2020"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr_wip, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, "ref.bib"))

data_path <- paste0(dir_input, "final_training_data.csv")

data <- read_csv(file = data_path)


message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1)

other <- data %>%
  select(obsID, crowd)

schema_lesiv202 <-
  setFormat(header = 1L) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", type = "i", columns = 1) %>%
  setIDVar(name = "externalID", columns = 3) %>%
  setIDVar(name = "open", type = "l", value = FALSE) %>%
  setIDVar(name = "type", value = "point") %>%
  setIDVar(name = "x", type = "n", columns = 5) %>%
  setIDVar(name = "y", type = "n", columns = 6) %>%
  setIDVar(name = "epsg", value = "4326") %>%
  setIDVar(name = "date", value = "2015-01-01") %>%
  setIDVar(name = "irrigated", type = "l", value = FALSE) %>%
  setIDVar(name = "present", type = "l", value = TRUE) %>%
  setIDVar(name = "sample_type", value = "visual interpretation") %>%
  setIDVar(name = "collector", value = "citizen scientist") %>%
  setIDVar(name = "purpose", value = "validation") %>%
  setObsVar(name = "concept", type = "c", columns = 7)

temp <- reorganise(schema = schema_lesiv202, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "The data set, in a form of table, contains information on Human Impact on Forests that was collected during a few crowd sourcing campaigns (Human Impact on Tropical Forest, Human Impact on Temperate Forest and Human Impact on Boreal Forest). the data set is not yet final. We expect to publish the final version under Open Access in nearest future.",                                              # the abstract (if paper available) or project description
           homepage = "https://zenodo.org/record/3356758",
           date = ymd("2020-10-21"),
           license = "unknown",
           ontology = path_onto_odb)

# matches <- tibble(new = as.character(unique(data$level12)),
#                   old = c("Palm plantations", "Undisturbed Forest", NA,
#                           "Tree orchards", "Naturally Regenerating Forest",
#                           "Woody plantation", "Tree orchards",
#                           "Undisturbed Forest", "Planted Forest"))

out <- matchOntology(table = temp,
                     columns = "concept",
                     colsAsClass = FALSE,
                     dataseries = thisDataset,
                     ontology = path_onto_odb)

out <- list(harmonised = out, extra = other)


message(" --> writing output")
saveRDS(object = out, file = paste0(dir_occurr_wip, "output/", thisDataset, ".rds"))
saveBIB(object = bib, file = paste0(dir_occurr_wip, "references.bib"))

beep(sound = 10)
message("\n     ... done")
