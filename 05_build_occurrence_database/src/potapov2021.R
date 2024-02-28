thisDataset <- "potapov2021"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, _INSERT))  #"rs-294463-v1-citation.ris"

# data_path_cmpr <- paste0(input_dir, "")
# unzip(exdir = input_dir, zipfile = data_path_cmpr)
# untar(exdir = input_dir, tarfile = data_path_cmpr)

data_path <- paste0(input_dir, "reference_sample_data.csv")
data <- read_csv(file = data_path)


message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1) %>%
  mutate(present = if_else(cropland == 1, TRUE, FALSE)) %>%
  pivot_longer(cols = c("crop 2003 (0/1)", "crop 2007 (0/1)", "crop 2011 (0/1)",
                        "crop 2015 (0/1)", "crop 2019 (0/1)"),
               names_to = "year", values_to = "cropland") %>%
  mutate(year = str_remove_all(year, "crop "),
         year = str_remove_all(year, " \\(0/1\\)"))

other <- data %>%
  select(obsID, _INSERT)

schema_potapov2021 <-
  setFormat(header = 1L, decimal = _INSERT, thousand = _INSERT, na_values = _INSERT) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", type = "i", columns = 1) %>%
  setIDVar(name = "externalID", columns = _INSERT) %>%
  setIDVar(name = "open", type = "l", value = TRUE) %>%
  setIDVar(name = "type", value = "point") %>%
  setIDVar(name = "x", type = "n", columns = _INSERT) %>% #`Center X`
  setIDVar(name = "y", type = "n", columns = _INSERT) %>% #`Center Y`
  setIDVar(name = "epsg", value = "4326") %>%
  setIDVar(name = "date", columns = _INSERT) %>%
  setIDVar(name = "irrigated", type = "l", value = FALSE) %>%
  setIDVar(name = "present", type = "l", value = _INSERT) %>%
  setIDVar(name = "sample_type", value = "visual interpretation") %>%
  setIDVar(name = "collector", value = "expert") %>%
  setIDVar(name = "purpose", value = "validation") %>%
  setObsVar(name = "concept", type = "c", columns = _INSERT)

temp <- reorganise(schema = schema_potapov2021, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "Spatiotemporally consistent data on global cropland extent is a key to tracking progress toward hunger eradication and sustainable food production1,2. Here, we present an analysis of global cropland area and change for the first two decades of the 21st century derived from satellite data time-series. We estimate 2019 cropland area to be 1,244 Mha with a corresponding total annual net primary production (NPP) of 5.5 Pg C yr-1. From 2003 to 2019, cropland area increased by 9% and crop NPP by 25%, primarily due to agricultural expansion in Africa and South America. Global cropland expansion accelerated over the past two decades, with a near doubling of the annual expansion rate, most notably in Africa. Half of the new cropland area (49%) replaced natural vegetation and tree cover, indicating a conflict with the sustainability goal of protecting terrestrial ecosystems. From 2003 to 2019 global population growth outpaced cropland area expansion, and per capita cropland area decreased by 10%. However, the per capita annual crop NPP increased by 3.5% as a result of intensified agricultural land use. The presented global high-resolution cropland map time-series supports monitoring of sustainable food production at the local, national, and international levels.",
           homepage = "https://doi.org/10.21203/rs.3.rs-294463/v1",
           date = ymd("2022-01-08"),
           license = "https://creativecommons.org/licenses/by/4.0/",
           ontology = odb_onto_path)

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
