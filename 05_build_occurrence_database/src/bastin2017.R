# script arguments ----
#
thisDataset <- "Bastin2017"
description <- "The extent of forest in dryland biomes"
doi <- "https://doi.org/10.1126/science.aam6527 https://"
licence <- "unknown"

message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- read.bib(file = paste0(occurr_dir, "input/", thisDataset, "/", "csp_356_.bib"))
newBib <- read.bib(file = paste0(occurr_dir, "references.bib")) %>% c(bib)
newBib <- newBib[!duplicated(newBib)]


# read dataset ----
#
data_path_comp <- paste0(occurr_dir, "input/", thisDataset, "/", "aam6527_Bastin_Database-S1.csv.zip")
data_path <- paste0(occurr_dir, "input/", thisDataset, "/", "aam6527_Bastin_Database-S1.csv")

# (unzip/untar)
unzip(exdir = paste0(occurr_dir, "input/", thisDataset, "/"), zipfile = data_path_comp)

data <- read_delim(file = data_path,
                   col_names = FALSE,
                   col_types = cols(.default = "c"),
                   delim = ";")


# harmonise data ----
#
data <- data %>%
  mutate(obsID = row_number()-1, .before = 1) %>%
  mutate(present = if_else(X5 == "forest", TRUE, FALSE))

schema_bastin2017 <-
  setFormat(decimal = ".") %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", type = "i", columns = 1) %>%
  setIDVar(name = "open", type = "l", value = TRUE) %>%
  setIDVar(name = "type", value = "point") %>%
  setIDVar(name = "x", type = "n", columns = 2) %>%
  setIDVar(name = "y", type = "n", columns = 3) %>%
  setIDVar(name = "epsg", value = "4326") %>%
  setIDVar(name = "date", type = "D", value = ymd("2015", truncated = 2)) %>%
  setIDVar(name = "irrigated", type = "l", value = FALSE) %>%
  setIDVar(name = "present", type = "l", columns = 8) %>%
  setIDVar(name = "sample_type", value = "visual interpretation") %>%
  setIDVar(name = "collector", value = "citizen scientist") %>%
  setIDVar(name = "purpose", value = "study") %>%
  setObsVar(name = "concept", type = "c", columns = 6)

temp <- reorganise(schema = schema_bastin2017, input = data)

otherData <- data %>%
  slice(-1) %>%
  select(obsID, region = X3, aridity = X4, cover.tree = X6)


# harmonize with ontology ----
#
new_source(name = thisDataset,
           description = description,
           homepage = doi,
           date = dmy("15-12-2021"),
           license = licence,
           ontology = onto_path)

out <- matchOntology(table = temp,
                     columns = "concept",
                     colsAsClass = FALSE,
                     dataseries = thisDataset,
                     ontology = onto_path)


# write output ----
#
saveRDS(object = out, file = paste0(occurr_dir, "output/", thisDataset, ".rds"))
saveRDS(object = otherData, file = paste0(occurr_dir, "output/", thisDataset, "_other.rds"))

write.bib(entry = newBib, file = paste0(occurr_dir, "references.bib"))


# beep(sound = 10)
message("\n     ... done")

