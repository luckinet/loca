# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# sample    : _INSERT
# doi/url   : _INSERT
# license   : _INSERT
# disclosed : _INSERT
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

thisDataset <- "gfsad30"
message("\n---- ", thisDataset, " ----")

message(" --> handling metadata")
dir_input <- paste0(dir_occurr_wip, "input/", thisDataset, "/")

new_reference(object = paste0(dir_input, "GFSAD30.bib"),
              file = paste0(dir_occurr_wip, "references.bib"))

new_source(name = thisDataset,
           description = "The GFSAD30 is a NASA funded project to provide high resolution global cropland data and their water use that contributes towards global food security in the twenty-first century. The GFSAD30 products are derived through multi-sensor remote sensing data (e.g., Landsat, MODIS, AVHRR), secondary data, and field-plot data and aims at documenting cropland dynamics from 2000 to 2025.",
           homepage = "https://croplands.org/app/data/search?page=1&page_size=200",
           date = ymd("2021-09-14"),
           license = _INSERT,
           ontology = path_onto_odb)


message(" --> handling data")
# data_path_cmpr <- paste0(dir_input, "")
# unzip(exdir = dir_input, zipfile = data_path_cmpr)
# untar(exdir = dir_input, tarfile = data_path_cmpr)

data_path <- paste0(dir_input, _INSERT)
data <- read_csv(file = data_path)
data <- read_tsv(file = data_path)
data <- read_excel(path = data_path)
data <- read_parquet(file = data_path)
data <- read_rds(file = data_path)
data <- st_read(dsn = data_path) |> as_tibble()
# make sure that coordinates are transformed to EPSG:4326 (WGS84)

# data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "GFSAD30_2000-2010.csv"), col_types = "iiiddciiiiicccl") %>%
#   bind_rows(read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "GFSAD30_2011-2021.csv"), col_types = "iiiddciiiiicccl"))
# data <- data %>%
#   filter(!land_use_type == 0 | !crop_primary == 0) %>%
#   mutate(jointCol = paste(land_use_type, crop_primary, sep = "-"))


message(" --> normalizing data")
data <- data |>
  mutate(obsID = row_number(), .before = 1)
# mutate(month = gsub(0, "01", month)) %>%
#   date = ymd(paste(year, month, "01", sep = "-")),
# externalValue = paste(land_use_type, crop_primary, sep = "-"),
# irrigated = case_when(water == 0 ~ NA,
#                       water == 1 ~ F,
#                       water == 2 ~ T),

other <- data |>
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
  setIDVar(name = "date", columns = _INSERT) %>%
  setIDVar(name = "irrigated", type = "l", value = _INSERT) %>%
  setIDVar(name = "present", type = "l", value = TRUE) %>%
  setIDVar(name = "sample_type", value = "field") %>%
  setIDVar(name = "collector", value = "expert") %>%
  setIDVar(name = "purpose", value = "map development") %>%
  setObsVar(name = "concept", type = "c", columns = _INSERT)

temp <- reorganise(schema = schema_INSERT, input = data)


message(" --> harmonizing with ontology")
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
                     ontology = path_onto_odb)

out <- list(harmonised = out, extra = other)

# # in case it's type=areal ...
# geom <- data |>
#   select(obsID, geom)


message(" --> writing output")
saveRDS(object = out, file = paste0(dir_occurr_wip, "output/", thisDataset, ".rds"))
# st_write(obj = geom, dsn = paste0(dir_occurr_wip, "output/", thisDataset, ".gpkg"))

beep(sound = 10)
message("\n     ... done")



