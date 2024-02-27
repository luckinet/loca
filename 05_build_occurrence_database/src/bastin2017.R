thisDataset <- "bastin2017"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, "csp_356_.bib"))

data_path_cmpr <- paste0(input_dir, "aam6527_Bastin_Database-S1.csv.zip")
data_path <- paste0(input_dir, "aam6527_Bastin_Database-S1.csv")

unzip(exdir = input_dir, zipfile = data_path_cmpr)

data <- read_delim(file = data_path,
                   delim = ";")


message(" --> normalizing data")
data <- data %>%
  filter(!is.na(location_x) & !is.na(location_y)) %>%
  mutate(present = if_else(land_use_category == "forest", TRUE, FALSE)) %>%
  mutate(obsID = row_number(), .before = 1)

other <- data %>%
  select(obsID, region = dryland_assessment_region, aridity = Aridity_zone, cover.tree = tree_cover)

schema_bastin2017 <-
  setFormat(header = 1L, decimal = ".") %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", type = "i", columns = 1) %>%
  setIDVar(name = "open", type = "l", value = TRUE) %>%
  setIDVar(name = "type", value = "point") %>%
  setIDVar(name = "x", type = "n", columns = 2) %>%
  setIDVar(name = "y", type = "n", columns = 3) %>%
  setIDVar(name = "epsg", value = "4326") %>%
  setIDVar(name = "date", value = "2015") %>%
  setIDVar(name = "irrigated", type = "l", value = FALSE) %>%
  setIDVar(name = "present", type = "l", columns = 8) %>%
  setIDVar(name = "sample_type", value = "visual interpretation") %>%
  setIDVar(name = "collector", value = "citizen scientist") %>%
  setIDVar(name = "purpose", value = "study") %>%
  setObsVar(name = "concept", type = "c", columns = 6)

temp <- reorganise(schema = schema_bastin2017, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "The extent of forest in dryland biomes",
           homepage = "https://doi.org/10.1126/science.aam6527",
           date = dmy("15-12-2021"),
           license = "unknown",
           ontology = odb_onto_path)

out <- matchOntology(table = temp,
                     columns = "concept",
                     dataseries = thisDataset,
                     colsAsClass = FALSE,
                     ontology = odb_onto_path)


message(" --> writing output")
saveRDS(object = out, file = paste0(occurr_dir, "output/", thisDataset, ".rds"))
saveRDS(object = other, file = paste0(occurr_dir, "output/", thisDataset, "_extra.rds"))
saveBIB(object = bib, file = paste0(occurr_dir, "references.bib"))

beep(sound = 10)
message("\n     ... done")
