thisDataset <- INSERT                                                           # the ID of this dataset
description <- INSERT                                                           # the abstract (if paper available) or project description
doi <- INSERT                                                                   # either the doi to the dataset, the doi to the paper or the url to the dataset
licence <- INSERT                                                               # the url to a license

message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, INSERT))                               # citation(s)

# data_path_cmpr <- paste0(input_dir, "")
data_path <- paste0(input_dir, INSERT)

# (unzip/untar)
# unzip(exdir = input_dir, zipfile = data_path_cmpr)                            # in case of zip archive
# untar(exdir = input_dir, tarfile = data_path_cmpr)                            # in case of tar archive

data <- read_csv(file = data_path,
                 col_names = FALSE,
                 col_types = cols(.default = "c"))                              # in case of csv
data <- read_tsv()
data <- st_read(dsn = data_path) %>% as_tibble()                                # in case of geopackage/shape/...
data <- read_excel(path = data_path)                                            # in case of excel file


message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1)                                     # define observation ID on raw data to be able to join harmonised data with the rest

schema_INSERT <-
  setFormat(decimal = INSERT, thousand = INSERT, na_values = INSERT) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%                         # the dataset ID
  setIDVar(name = "obsID", type = "i", columns = 1) %>%                         # the observation ID
  setIDVar(name = "externalID", columns = INSERT) %>%                           # the verbatim observation-specific ID as used in the external dataset
  setIDVar(name = "open", type = "l", value = INSERT) %>%                       # whether the dataset is freely available (TRUE) or restricted (FALSE)
  setIDVar(name = "type", value = INSERT) %>%                                   # whether the data are "point" or "areal" (when its from a plot, region, nation, etc)
  setIDVar(name = "x", type = "n", columns = INSERT) %>%                        # the x-value of the coordinate (or centroid if type = "areal")
  setIDVar(name = "y", type = "n", columns = INSERT) %>%                        # the y-value of the coordinate (or centroid if type = "areal")
  setIDVar(name = "epsg", value = INSERT) %>%                                   # the EPSG code of the coordinates or geometry
  setIDVar(name = "geometry", columns = INSERT) %>%                             # the geometries if type = "areal"
  setIDVar(name = "date", columns = INSERT) %>%                                 # the date (as character) of the observation
  setIDVar(name = "irrigated", type = "l", columns = INSERT) %>%                # whether the observation receives irrigation (TRUE) or not (FALSE)
  setIDVar(name = "present", type = "l", columns = INSERT) %>%                  # whether the observation describes a presence (TRUE) or an absence (FALSE)
  setIDVar(name = "sample_type", value = INSERT) %>%                            # from what space the data were collected, either "field/ground", "visual interpretation", "experience", "meta study" or "modelled"
  setIDVar(name = "collector", value = INSERT) %>%                              # who the collector was, either "expert", "citizen scientist" or "student"
  setIDVar(name = "purpose", value = INSERT) %>%                                # what the data were collected for, either "monitoring", "validation", "study" or "map development"
  setObsVar(name = "concept", type = "c", columns = INSERT)                     # the value of the observation

temp <- reorganise(schema = schema_INSERT, input = data)

other <- data %>%
  slice(-INSERT) %>%                                                            # slice off the rows that contain the header
  select(INSERT)                                                                # remove all columns that are recorded in 'out'


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = description,
           homepage = doi,
           date = ymd(INSERT),                                                        # the download date
           license = license,
           ontology = odb_onto_path)

out <- matchOntology(table = temp,
                     columns = "concept",
                     colsAsClass = FALSE,
                     dataseries = thisDataset,
                     ontology = odb_onto_path)


message(" --> writing output")
saveRDS(object = out, file = paste0(occurr_dir, "output/", thisDataset, ".rds"))
saveRDS(object = other, file = paste0(occurr_dir, "output/", thisDataset, "_other.rds"))
saveBIB(object = bib, file = paste0(occurr_dir, "references.bib"))

beep(sound = 10)
message("\n     ... done")
# script arguments ----
#
thisDataset <- "lucas"
description <- "Mapping pan-European land cover using Landsat spectral-temporal metrics and the European LUCAS survey"
url <- "https://ec.europa.eu/eurostat/web/lucas/data/primary-data"
licence <- ""

# current data repositories
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2006
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2009
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2012
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2015
# https://ec.europa.eu/eurostat/web/lucas/data/primary-data/2018
#
# https://ec.europa.eu/eurostat/web/gisco/geodata/reference-data/land-cover#umz


# reference ----
#
bib <- bibtex_reader(paste0(occurr_dir, "input/", thisDataset, "/", "S0034425718305546.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           type = "static",
           licence = licence,
           bibliography = bib,
           download_date = dmy("17-12-2021"),
           contact = "see corresponding author",
           disclosed = TRUE,
           path = occurr_dir)


# preprocess data ----
#
data2006 <- list.files(paste0(occurr_dir, "input/", thisDataset, "/"), pattern = "_2006", full.names = TRUE)
if(!any(str_detect(data2006, "EU_2006"))){
  data2006 %>%
    map(.f = function(ix){
      read_csv(ix, col_types = "dddccccddddcdddcddcd")
    }) %>%
    bind_rows() %>%
    write_csv(file = paste0(occurr_dir, "stage1/", thisDataset, "/", "EU_2006.csv"))
}


# read dataset ----
#
data2006 <- read_csv(paste0(occurr_dir, "input/", thisDataset, "/EU_2006.csv"), col_types = "dddccccddddcdddcddcd")
data2009 <- read_csv(paste0(occurr_dir, "input/", thisDataset, "/EU_2009_20200213.csv"))
data2012 <- read_csv(paste0(occurr_dir, "input/", thisDataset, "/EU_2012_20200213.csv"))
data2015 <- read_csv(paste0(occurr_dir, "input/", thisDataset, "/EU_2015_20200225.csv"))
data2018 <- read_csv(paste0(occurr_dir, "input/", thisDataset, "/EU_2018_20200213.csv"))


# harmonise data ----
#
pts06 <- data2006 %>%
  select(x = X_LAEA, y = Y_LAEA) %>%
  st_as_sf(coords = c("x", "y"), crs = "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs") %>%
  st_transform(crs = 4326) %>%
  st_coordinates()

data2006 <- data2006 %>%
  bind_cols(pts06) %>%
  filter(GPS_PROJ != 2 & GPS_PROJ != 0) %>%
  filter(!is.na(X) & !is.na(Y)) %>%
  mutate(iso_a2 = NUTS0,
         date = dmy(SURV_DATE),
         LC2 = as.character(LC2),
         LU2 = as.character(LU2),
         sample_type = if_else(OBS_TYPE  == 1, "field", "visual interpretation"),
         collector = "expert",
         purpose = "validation") %>%
  select(POINT_ID, iso_a2, date, sample_type, collector, purpose, GPS_PREC, x = X, y = Y, LC1, LC2, LU1, LU2)

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

make LC1|LC2=LC and LU1|LU2=LU long columns
also sort crops that are part of LU into column CROP
make LC|LU|CROP=externalValue into one long column and make externalType with the respective type

temp <- temp %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = iso_a2,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    externalID = as.character(POINT_ID),
    externalValue = NA_character_,
    externalType = NA_character_,
    irrigated = NA,
    presence = TRUE) %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, externalType, irrigated, presence,
         sample_type, collector, purpose, everything())


# harmonize with ontology ----
#
# check out "lucas_taxonomy.csv"
new_source(name = thisDataset,
           description = description,
           homepage = url,
           date = Sys.Date(),
           license = licence,
           ontology = onto_path)

landcover <- temp %>%
  filter(externalType == "landcover") %>%
  rename(landcover = externalValue) %>%
  matchOntology(columns = "landcover",
                dataseries = thisDataset,
                ontology = onto_path)

landuse <- temp %>%
  filter(externalType == "landuse") %>%
  rename(landuse = externalValue) %>%
  matchOntology(columns = "landuse",
                dataseries = thisDataset,
                ontology = onto_path)

crop <- temp %>%
  filter(externalType == "crop") %>%
  rename(crop = externalValue) %>%
  matchOntology(columns = "crop",
                dataseries = thisDataset,
                ontology = onto_path)

out <- bind_rows(landcover, landuse, crop)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = occurr_dir, name = thisDataset)

message("\n---- done ----")
