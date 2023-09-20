# script arguments ----
#
thisDataset <- "LUCAS"
description <- "Mapping pan-European land cover using Landsat spectral-temporal metrics and the European LUCAS survey"
url <- "https://doi.org/10.1016/j.rse.2018.12.001 https://ec.europa.eu/eurostat/web/lucas/data/primary-data"
licence <- ""

# current data repositories
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2006
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2009
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2012
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2015
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2018

search for harmonisation by mareijn van der velde from JRC (https://scholar.google.at/citations?user=M3NqiBYAAAAJ&hl=de)

# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "S0034425718305546.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           type = "static",
           licence = licence,
           bibliography = bib,
           download_date = dmy("17-12-2021"),
           contact = "see corresponding author",
           disclosed = TRUE,
           path = occurrenceDBDir)


# preprocess data ----
#
data2006 <- list.files(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/"), pattern = "_2006", full.names = TRUE)
if(!any(str_detect(data2006, "EU_2006"))){
  data2006 %>%
    map(.f = function(ix){
      read_csv(ix, col_types = "dddccccddddcdddcddcd")
    }) %>%
    bind_rows() %>%
    write_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "EU_2006.csv"))
}


# read dataset ----
#
data2006 <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/EU_2006.csv"), col_types = "dddccccddddcdddcddcd")
data2009 <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/EU_2009_20200213.csv"))
data2012 <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/EU_2012_20200213.csv"))
data2015 <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/EU_2015_20200225.csv"))
data2018 <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/EU_2018_20200213.csv"))


# harmonise data ----
#
pts06 <- data2006 %>%
  select(x = X_LAEA, y = Y_LAEA) %>%
  gs_point() %>%
  setCRS(crs = "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs") %>%
  gc_sf() %>%
  setCRS(crs = 4326) %>%
  getPoints()

data2006 <- data2006 %>%
  bind_cols(pts06) %>%
  filter(GPS_PROJ != 2 & GPS_PROJ != 0) %>%
  filter(!is.na(x) & !is.na(y)) %>%
  mutate(iso_a2 = NUTS0,
         date = dmy(SURV_DATE),
         LC2 = as.character(LC2),
         LU2 = as.character(LU2),
         sample_type = if_else(OBS_TYPE  == 1, "field", "visual interpretation"),
         collector = "expert",
         purpose = "validation") %>%
  select(POINT_ID, iso_a2, date, sample_type, collector, purpose, GPS_PREC, x, y, LC1, LC2, LU1, LU2)

data2009 <- data2009 %>%
  distinct(POINT_ID, .keep_all = TRUE) %>%
  filter(GPS_PROJ != "X") %>%
  filter(!is.na(TH_LAT) | !is.na(TH_LONG) | !is.na(GPS_PROJ) | !is.na(NUTS0)) %>%
  mutate(iso_a2 = if_else(NUTS0 == "EL", "GR", if_else(NUTS0 == "UK", "GB", NUTS0)),
         date = dmy(SURVEY_DATE),
         sample_type = if_else(OBS_TYPE %in% c(1, 2), "field", "visual interpretation"),
         collector = "expert",
         purpose = "validation",
         x = if_else(TH_EW == "W", TH_LONG * -1, TH_LONG),
         y = TH_LAT) %>%
  select(POINT_ID, iso_a2, date, sample_type, collector, purpose, GPS_PREC, x, y, LC1, LC1_SPECIES, LC2, LC2_SPECIES, LU1, LU2)

data2012 <- data2012 %>%
  distinct(POINT_ID, .keep_all = TRUE) %>%
  filter(!is.na(TH_LAT) | !is.na(TH_LONG) | !is.na(GPS_PROJ) | !is.na(NUTS0)) %>%
  mutate(iso_a2 = if_else(NUTS0 == "EL", "GR", if_else(NUTS0 == "UK", "GB", NUTS0)),
         date = dmy(SURVEY_DATE),
         POINT_ID = as.numeric(POINT_ID),
         LC2_SPECIES = as.character(LC2_SPECIES),
         sample_type = if_else(OBS_TYPE %in% c(1, 2), "field", "visual interpretation"),
         collector = "expert",
         purpose = "validation",
         x = TH_LONG,
         y = TH_LAT) %>%
  select(POINT_ID, iso_a2, date, sample_type, collector, purpose, GPS_PREC, x, y, LC1, LC1_SPECIES, LC2, LC2_SPECIES, LU1, LU2)

data2015 <- data2015 %>%
  distinct(POINT_ID, .keep_all = TRUE) %>%
  filter(!is.na(TH_LAT) | !is.na(TH_LONG) | !is.na(GPS_PROJ) | !is.na(NUTS0)) %>%
  mutate(iso_a2 = if_else(NUTS0 == "EL", "GR", if_else(NUTS0 == "UK", "GB", NUTS0)),
         date = dmy(SURVEY_DATE),
         POINT_ID = as.numeric(POINT_ID),
         LC2_SPECIES = as.character(LC2_SPECIES),
         sample_type = if_else(OBS_TYPE %in% c(1, 2), "field", if_else(OBS_TYPE %in% c(3, 7), "visual interpretation", NA_character_)),
         collector = "expert",
         purpose = "validation",
         x = TH_LONG,
         y = TH_LAT) %>%
  select(POINT_ID, iso_a2, date, sample_type, collector, purpose, GPS_PREC, x, y, LC1, LC1_SPECIES, LC2, LC2_SPECIES, LU1, LU1_TYPE, LU2, LU2_TYPE)

data2018 <- data2018 %>%
  distinct(POINT_ID, .keep_all = TRUE) %>%
  filter(!is.na(TH_LAT) | !is.na(TH_LONG) | !is.na(GPS_PROJ) | !is.na(NUTS0)) %>%
  mutate(iso_a2 = if_else(NUTS0 == "EL", "GR", if_else(NUTS0 == "UK", "GB", NUTS0))) %>%
  mutate(POINT_ID = as.numeric(POINT_ID),
         date = dmy(SURVEY_DATE),
         LC2_SPEC = as.character(LC2_SPEC),
         sample_type = if_else(OBS_TYPE %in% c(1, 2), "field", if_else(OBS_TYPE %in% c(3, 7), "visual interpretation", NA_character_)),
         collector = "expert",
         purpose = "validation",
         x = TH_LONG,
         y = TH_LAT) %>%
  select(POINT_ID, iso_a2, date, sample_type, collector, purpose, GPS_PREC, x, y, LC1, LC1_SPECIES = LC1_SPEC, LC2, LC2_SPECIES = LC2_SPEC, LU1, LU1_TYPE, LU2, LU2_TYPE, GRAZING, LC_LU_SPECIAL_REMARK, WM)

temp <- data2006 %>%
  bind_rows(data2009) %>%
  bind_rows(data2012) %>%
  bind_rows(data2015) %>%
  bind_rows(data2018)

temp <- temp %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    externalID = as.character(POINT_ID),
    externalValue = NA_character_,
    attr_1 = LC1,
    attr_1_typ = "landcover",
    attr_2 = LC2,
    attr_2_typ = "landcover",
    irrigated = NA,
    presence = TRUE) %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated,presence, LC1_orig, LC2_orig,
         LC3_orig, sample_type, collector, purpose, everything())


# harmonize with ontology ----
#
# check out "lucas_taxonomy.csv"
new_source(name = thisDataset,
           description = description,
           homepage = url,
           date = Sys.Date(),
           license = licence,
           ontology = ontoDir)

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = occurrenceDBDir, name = thisDataset)

message("\n---- done ----")
