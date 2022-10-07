# script arguments ----
#
thisDataset <- "LUCAS"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "Mapping pan-European land cover using Landsat spectral-temporal metrics and the European LUCAS survey"
url <- "https://doi.org/10.1016/j.rse.2018.12.001"    # ideally the doi, but if it doesn't have one, the main source of the database
license <- ""

# current data repositories
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2006
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2009
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2012
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2015
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2018


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "S0034425718305546.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           type = "static",
           licence = license,
           bibliography = bib,
           download_date = "2021-12-17",
           contact = "see corresponding author",
           disclosed = "yes",
           update = TRUE)


# preprocess data ----
#
data2006 <- list.files(thisPath, pattern = "_2006", full.names = TRUE)
if(!any(str_detect(data2006, "EU_2006"))){
  data2006 %>%
    map(.f = function(ix){
      read_csv(ix, col_types = "dddccccddddcdddcddcd")
    }) %>%
    bind_rows() %>%
    write_csv(file = paste0(thisPath, "/EU_2006.csv"))
}


# read dataset ----
#
data2006 <- read_csv(paste0(thisPath, "/EU_2006.csv"), col_types = "dddccccddddcdddcddcd")
data2009 <- read_csv(paste0(thisPath, "/EU_2009_20200213.csv"))
data2012 <- read_csv(paste0(thisPath, "/EU_2012_20200213.csv"))
data2015 <- read_csv(paste0(thisPath, "/EU_2015_20200225.csv"))
data2018 <- read_csv(paste0(thisPath, "/EU_2018_20200213.csv"))


# manage ontology ---
#
lucas_concepts <- read_csv(file = paste0(thisPath, "lucas_taxonomy.csv")) %>%
  unite(col = "code", category, code, `sub-code`, sep = "", na.rm = TRUE)

luckiOnto <- new_source(name = thisDataset,
                        description = "Mapping pan-European land cover using Landsat spectral-temporal metrics and the European LUCAS survey",
                        homepage = "https://ec.europa.eu/eurostat/web/lucas/data/primary-data",
                        date = Sys.Date(),
                        license = "",
                        ontology = luckiOnto)

# in case new harmonised concepts appear here (avoid if possible)
# luckiOnto <- new_concept(new = , broader = , class = , description = ,
#                          ontology = luckiOnto)

luckiOnto <- new_mapping(new = lucas_concepts$code,
                         target = lucas_concepts %>% select(class, name = label, description, includes, excludes),
                         source = thisDataset,
                         description = lucas_concepts$description,
                         match = "close",
                         certainty = 3,
                         ontology = luckiOnto, matchDir = paste0(occurrenceDBDir, "01_concepts/"), verbose = TRUE)


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

# cnt <- temp %>%
#   distinct(iso_a2) %>%
#   filter(!is.na(iso_a2)) %>%
#   left_join(countries, by = "iso_a2") %>%
#   select(iso_a2, country = unit)

temp <- temp %>%
  # left_join(countries, by = "iso_a2") %>%
  mutate(
    fid = row_number(),
    type = "point",
    country = NA_character_,
    geometry = NA,
    area = NA_real_,
    datasetID = thisDataset,
    presence = TRUE,
    irrigated = NA,
    externalID = as.character(POINT_ID),
    externalValue = NA_character_,
    LC1_orig = LC1,
    LC2_orig = LC2,
    LC3_orig = NA_character_,
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, date, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
