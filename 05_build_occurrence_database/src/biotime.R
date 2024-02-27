thisDataset <- "biotime"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, _INSERT))

# data_path_cmpr <- paste0(input_dir, "")
# unzip(exdir = input_dir, zipfile = data_path_cmpr)
# untar(exdir = input_dir, tarfile = data_path_cmpr)

data_path <- paste0(input_dir, _INSERT)
data <- read_csv(file = data_path)
data <- read_tsv(file = data_path)
data <- read_excel(path = data_path)
data <- read_parquet(file = data_path)
data <- st_read(dsn = data_path) %>% as_tibble()


message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1)

other <- data %>%
  select(obsID, _INSERT)

schema_INSERT <-
  setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
            na_values = _INSERT) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", type = "i", columns = 1) %>%
  setIDVar(name = "externalID", columns = _INSERT) %>%
  setIDVar(name = "open", type = "l", value = _INSERT) %>%
  setIDVar(name = "type", value = _INSERT) %>%
  setIDVar(name = "x", type = "n", columns = _INSERT) %>%
  setIDVar(name = "y", type = "n", columns = _INSERT) %>%
  setIDVar(name = "epsg", value = _INSERT) %>%
  setIDVar(name = "geometry", columns = _INSERT) %>%
  setIDVar(name = "date", columns = _INSERT) %>%
  setIDVar(name = "irrigated", type = "l", value = _INSERT) %>%
  setIDVar(name = "present", type = "l", value = _INSERT) %>%
  setIDVar(name = "sample_type", value = _INSERT) %>%
  setIDVar(name = "collector", value = _INSERT) %>%
  setIDVar(name = "purpose", value = _INSERT) %>%
  setObsVar(name = "concept", type = "c", columns = _INSERT)

temp <- reorganise(schema = schema_INSERT, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = _INSERT,
           homepage = _INSERT,
           date = ymd(_INSERT),
           license = _INSERT,
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


thisDataset <- "BioTime"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, "pericles_1466823827.bib"))

# data_path_cmpr <- paste0(input_dir, "")
data_path <- paste0(input_dir, "BioTIMEQuery02_04_2018.csv")
data_path2 <- paste0(input_dir, "BioTIMEMetadata_02_04_2018.csv")

data <- read_csv(file = data_path,
                 # col_names = FALSE,
                 col_types = cols(.default = "c"))

data <- read_csv(file = data_path2) %>%
  left_join(data, ., by = "STUDY_ID")

message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1)                                     # define observation ID on raw data to be able to join harmonised data with the rest

temp <- data2 %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = NA_character_,
    x = LONGITUDE,
    y = LATITUDE,
    geometry = NA,
    epsg = 4326,
    area = AREA_SQ_KM * 10000,
    date = NA,
    # year = paste(START_YEAR, END_YEAR, sep = "_"),
    externalID = NA_character_,
    externalValue = HABITAT,
    irrigated = ,
    presence = ,
    sample_type = ,
    collector = ,
    purpose = ) %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = as.numeric(year),
         fid = row_number()) %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated, presence,
         sample_type, collector, purpose, everything())

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
  setIDVar(name = "irrigated", type = "l", columns = FALSE) %>%                # whether the observation receives irrigation (TRUE) or not (FALSE)
  setIDVar(name = "present", type = "l", columns = TRUE) %>%                  # whether the observation describes a presence (TRUE) or an absence (FALSE)
  setIDVar(name = "sample_type", value = "meta study") %>%                            # from what space the data were collected, either "field/ground", "visual interpretation", "experience", "meta study" or "modelled"
  setIDVar(name = "collector", value = "expert") %>%                              # who the collector was, either "expert", "citizen scientist" or "student"
  setIDVar(name = "purpose", value = "study") %>%                                # what the data were collected for, either "monitoring", "validation", "study" or "map development"
  setObsVar(name = "concept", type = "c", columns = INSERT)                     # the value of the observation

temp <- reorganise(schema = schema_INSERT, input = data)

other <- data %>%
  slice(-INSERT) %>%                                                            # slice off the rows that contain the header
  select(INSERT)                                                                # remove all columns that are recorded in 'out'


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "Abstract Motivation The BioTIME database contains raw data on species identities and abundances in ecological assemblages through time. These data enable users to calculate temporal trends in biodiversity within and amongst assemblages using a broad range of metrics. BioTIME is being developed as a community-led open-source database of biodiversity time series. Our goal is to accelerate and facilitate quantitative analysis of temporal patterns of biodiversity in the Anthropocene. Main types of variables included The database contains 8,777,413 species abundance records, from assemblages consistently sampled for a minimum of 2 years, which need not necessarily be consecutive. In addition, the database contains metadata relating to sampling methodology and contextual information about each record. Spatial location and grain BioTIME is a global database of 547,161 unique sampling locations spanning the marine, freshwater and terrestrial realms. Grain size varies across datasets from 0.0000000158 km2 (158 cm2) to 100 km2 (1,000,000,000,000 cm2). Time period and grain BioTIME records span from 1874 to 2016. The minimal temporal grain across all datasets in BioTIME is a year. Major taxa and level of measurement BioTIME includes data from 44,440 species across the plant and animal kingdoms, ranging from plants, plankton and terrestrial invertebrates to small and large vertebrates. Software format .csv and .SQL.",
           homepage = "https://doi.org/10.1111/geb.1272",
           date = ymd("2019-09-10"),
           license = "various",
           ontology = odb_onto_path)

# matches <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "BioTIME_ontology.csv"))

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
