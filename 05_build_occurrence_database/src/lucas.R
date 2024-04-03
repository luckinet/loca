# ----
# geography : Europe
# period    : 2006, 2009, 2012, 2015, 2018
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : 1317176
# data type : point
# doi/url   : _INSERT
# authors   : Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

thisDataset <- "lucas"
message("\n---- ", thisDataset, " ----")

# current data repositories
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2006
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2009
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2012
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2015
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2018
#
# https://ec.europa.eu/eurostat/web/gisco/geodata/reference-data/land-cover#umz


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, "S0034425718305546.bib"))

data2006 <- list.files(path = input_dir, pattern = "_2006", full.names = TRUE)
if(!any(str_detect(data2006, "EU_2006"))){
  data2006 %>%
    map(.f = function(ix){
      read_csv(ix, col_types = "dddccccddddcdddcddcd")
    }) %>%
    bind_rows() %>%
    write_csv(file = paste0(input_dir, "EU_2006.csv"))
}

data2006 <- read_csv(paste0(input_dir, "/EU_2006.csv"), col_types = "dddccccddddcdddcddcd")
data2009 <- read_csv(paste0(input_dir, "/EU_2009_20200213.csv"))
data2012 <- read_csv(paste0(input_dir, "/EU_2012_20200213.csv"))
data2015 <- read_csv(paste0(input_dir, "/EU_2015_20200225.csv"))
data2018 <- read_csv(paste0(input_dir, "/EU_2018_20200213.csv"))


message(" --> normalizing data")
data2006 <- data2006 %>%
  filter(GPS_PROJ != 2 & GPS_PROJ != 0) %>%
  mutate(OBS_TYPE = if_else(OBS_TYPE  == 1, "field", "visual interpretation"),
         GPS_PROJ = as.character(GPS_PROJ),
         LC2 = as.character(LC2),
         LU2 = as.character(LU2)) %>%
  rename(SURVEY_DATE = SURV_DATE)

data2009 <- data2009 %>%
  filter(GPS_PROJ != "X") %>%
  mutate(OBS_TYPE = if_else(OBS_TYPE %in% c(1, 2), "field", "visual interpretation"))

data2012 <- data2012 %>%
  filter(!is.na(GPS_PROJ) | !is.na(NUTS0)) %>%
  mutate(POINT_ID = as.numeric(POINT_ID),
         GPS_PROJ = as.character(GPS_PROJ),
         LC2_SPECIES = as.character(LC2_SPECIES),
         OBS_TYPE = if_else(OBS_TYPE %in% c(1, 2), "field", "visual interpretation"))

data2015 <- data2015 %>%
  filter(!is.na(GPS_PROJ) | !is.na(NUTS0)) %>%
  mutate(POINT_ID = as.numeric(POINT_ID),
         GPS_PROJ = as.character(GPS_PROJ),
         LC2_SPECIES = as.character(LC2_SPECIES),
         OBS_TYPE = if_else(OBS_TYPE %in% c(1, 2), "field", if_else(OBS_TYPE %in% c(3, 7), "visual interpretation", NA_character_)))

data2018 <- data2018 %>%
  filter(!is.na(GPS_PROJ) | !is.na(NUTS0)) %>%
  mutate(POINT_ID = as.numeric(POINT_ID),
         GPS_PROJ = as.character(GPS_PROJ),
         GPS_EW = as.character(GPS_EW),
         LC2_SPEC = as.character(LC2_SPEC),
         OBS_TYPE = if_else(OBS_TYPE %in% c(1, 2), "field", if_else(OBS_TYPE %in% c(3, 7), "visual interpretation", NA_character_)))

data <- data2006 %>%
  bind_rows(data2009) %>%
  bind_rows(data2012) %>%
  bind_rows(data2015) %>%
  bind_rows(data2018) %>%
  mutate(obsID = row_number(), .before = 1)

data <- data %>%
  mutate(LC1 = if_else(LC1 %in% c("", "8"), NA_character_,
                       if_else(!is.na(LC1_SPECIES) & LC1_SPECIES != "8", LC1_SPECIES,
                               if_else(!is.na(LC1_SPEC) & LC1_SPEC != "8", LC1_SPEC, LC1))),
         LC2 = if_else(LC2 %in% c("", "8"), NA_character_,
                       if_else(!is.na(LC2_SPECIES) & LC2_SPECIES != "8", LC2_SPECIES,
                               if_else(!is.na(LC2_SPEC) & LC2_SPEC != "8", LC2_SPEC, LC2))))

# other <- data %>%
#   select(obsID, _INSERT)

schema_lucas <-
  setFormat(header = 1L) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", type = "i", columns = 1) %>%
  setIDVar(name = "externalID", columns = 2) %>%
  setIDVar(name = "open", type = "l", value = TRUE) %>%
  setIDVar(name = "type", value = "point") %>%
  setIDVar(name = "x", type = "n", columns = 14) %>%
  setIDVar(name = "y", type = "n", columns = 12) %>%
  setIDVar(name = "epsg", value = "4326") %>%
  setIDVar(name = "date", columns = 8) %>%
  setIDVar(name = "irrigated", type = "l", value = FALSE) %>%
  setIDVar(name = "present", type = "l", value = TRUE) %>%
  setIDVar(name = "sample_type", columns = 9) %>%
  setIDVar(name = "collector", value = "expert") %>%
  setIDVar(name = "purpose", value = "validation") %>%
  setIDVar(name = "sample_nr", columns = c(17, 18), rows = 1) %>%
  setObsVar(name = "concept", type = "c", columns = c(17, 18), top = 1)

temp <- reorganise(schema = schema_lucas, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "Mapping pan-European land cover using Landsat spectral-temporal metrics and the European LUCAS survey",
           homepage = "https://ec.europa.eu/eurostat/web/lucas/data/primary-data",
           date = dmy("17-12-2021"),
           license = "unknown",
           ontology = odb_onto_path)

out <- matchOntology(table = temp,
                     columns = "concept",
                     colsAsClass = FALSE,
                     dataseries = thisDataset,
                     ontology = odb_onto_path)

out <- list(harmonised = out, extra = other)


message(" --> writing output")
saveRDS(object = out, file = paste0(occurr_dir, "output/", thisDataset, ".rds"))
saveBIB(object = bib, file = paste0(occurr_dir, "references.bib"))

beep(sound = 10)
message("\n     ... done")
