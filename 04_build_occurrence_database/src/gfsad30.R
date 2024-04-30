thisDataset <- "gfsad30"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, _INSERT))
# bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "GFSAD30.bib"))

# data_path_cmpr <- paste0(input_dir, "")
# unzip(exdir = input_dir, zipfile = data_path_cmpr)
# untar(exdir = input_dir, tarfile = data_path_cmpr)

# data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "GFSAD30_2000-2010.csv"), col_types = "iiiddciiiiicccl") %>%
#   bind_rows(read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "GFSAD30_2011-2021.csv"), col_types = "iiiddciiiiicccl"))
# data <- data %>%
#   filter(!land_use_type == 0 | !crop_primary == 0) %>%
#   mutate(jointCol = paste(land_use_type, crop_primary, sep = "-"))

data_path <- paste0(input_dir, _INSERT)
data <- read_csv(file = data_path)
data <- read_tsv(file = data_path)
data <- read_excel(path = data_path)
data <- read_parquet(file = data_path)
data <- st_read(dsn = data_path) %>% as_tibble()


message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1)
# mutate(month = gsub(0, "01", month)) %>%
#   date = ymd(paste(year, month, "01", sep = "-")),
# externalValue = paste(land_use_type, crop_primary, sep = "-"),
# irrigated = case_when(water == 0 ~ NA,
#                       water == 1 ~ F,
#                       water == 2 ~ T),

other <- data %>%
  select(obsID, _INSERT)

schema_INSERT <-
  setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
            na_values = _INSERT) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", type = "i", columns = 1) %>%
  setIDVar(name = "externalID", columns = _INSERT) %>%
  setIDVar(name = "open", type = "l", value = _INSERT) %>%
  setIDVar(name = "type", value = "point") %>%
  setIDVar(name = "x", type = "n", columns = _INSERT) %>% # lon
  setIDVar(name = "y", type = "n", columns = _INSERT) %>% # lat
  setIDVar(name = "geometry", columns = _INSERT) %>%
  setIDVar(name = "date", columns = _INSERT) %>%
  setIDVar(name = "irrigated", type = "l", value = _INSERT) %>%
  setIDVar(name = "present", type = "l", value = TRUE) %>%
  setIDVar(name = "sample_type", value = "field") %>%
  setIDVar(name = "collector", value = "expert") %>%
  setIDVar(name = "purpose", value = "map development") %>%
  setObsVar(name = "concept", type = "c", columns = _INSERT)

temp <- reorganise(schema = schema_INSERT, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "The GFSAD30 is a NASA funded project to provide high resolution global cropland data and their water use that contributes towards global food security in the twenty-first century. The GFSAD30 products are derived through multi-sensor remote sensing data (e.g., Landsat, MODIS, AVHRR), secondary data, and field-plot data and aims at documenting cropland dynamics from 2000 to 2025.",
           homepage = "https://croplands.org/app/data/search?page=1&page_size=200",
           date = ymd("2021-09-14"),
           license = _INSERT,
           ontology = odb_onto_path)

# newConcepts <- tibble(target = c("Temporary cropland", "Open spaces with little or no vegetation", "Herbaceous associations",
#                                  "Forests", "WATER BODIES", "Shrubland",
#                                  "Permanent cropland", "rice", "Urban fabric",
#                                  "Temporary cropland", "sugarcane", "Fallow",
#                                  "potato", "rice", "wheat",
#                                  "maize", "barley", "alfalfa",
#                                  "cotton", "oil palm", "soybean",
#                                  "cassava", "peanut", "millet",
#                                  "sunflower", "LEGUMINOUS CROPS", "Temporary cropland",
#                                  "Temporary grazing", "rapeseed"),
#                       new = unique(temp$jointCol),
#                       class = c("landcover", "landcover", "landcover",
#                                 "landcover", "landcover group", "landcover",
#                                 "landcover", "commodity", "landcover",
#                                 "landcover", "commodity", "land-use",
#                                 "commodity", "commodity", "commodity",
#                                 "commodity", "commodity", "commodity",
#                                 "commodity", "commodity", "commodity",
#                                 "commodity", "commodity", "commodity",
#                                 "commodity", "group", "landcover",
#                                 "land-use", "commodity"),
#                       description = NA,
#                       match = "close",
#                       certainty = 3)

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
