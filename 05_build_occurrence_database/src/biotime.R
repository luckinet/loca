thisDataset <- "biotime"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, "pericles_1466823827.bib"))

# data_path_cmpr <- paste0(input_dir, "")
# unzip(exdir = input_dir, zipfile = data_path_cmpr)
# untar(exdir = input_dir, tarfile = data_path_cmpr)

# data_path <- paste0(input_dir, "BioTIMEQuery02_04_2018.csv")
# data_path2 <- paste0(input_dir, "BioTIMEMetadata_02_04_2018.csv")
#
# data <- read_csv(file = data_path,
#                  # col_names = FALSE,
#                  col_types = cols(.default = "c"))
#
# data <- read_csv(file = data_path2) %>%
#   left_join(data, ., by = "STUDY_ID")
#
# separate_rows(year, sep = "_") %>%
#   mutate(year = as.numeric(year),
#          fid = row_number()) %>%

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
  setIDVar(name = "type", value = "areal") %>%
  setIDVar(name = "x", type = "n", columns = _INSERT) %>% # LONGITUDE
  setIDVar(name = "y", type = "n", columns = _INSERT) %>% # LATITUDE
  setIDVar(name = "epsg", value = _INSERT) %>%
  setIDVar(name = "geometry", columns = _INSERT) %>%
  setIDVar(name = "date", columns = _INSERT) %>%
  setIDVar(name = "irrigated", type = "l", value = FALSE) %>%
  setIDVar(name = "present", type = "l", value = TRUE) %>%
  setIDVar(name = "sample_type", value = "meta study") %>%
  setIDVar(name = "collector", value = "expert") %>%
  setIDVar(name = "purpose", value = "study") %>%
  setObsVar(name = "concept", type = "c", columns = _INSERT) # HABITAT

temp <- reorganise(schema = schema_INSERT, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "Abstract Motivation The BioTIME database contains raw data on species identities and abundances in ecological assemblages through time. These data enable users to calculate temporal trends in biodiversity within and amongst assemblages using a broad range of metrics. BioTIME is being developed as a community-led open-source database of biodiversity time series. Our goal is to accelerate and facilitate quantitative analysis of temporal patterns of biodiversity in the Anthropocene. Main types of variables included The database contains 8,777,413 species abundance records, from assemblages consistently sampled for a minimum of 2 years, which need not necessarily be consecutive. In addition, the database contains metadata relating to sampling methodology and contextual information about each record. Spatial location and grain BioTIME is a global database of 547,161 unique sampling locations spanning the marine, freshwater and terrestrial realms. Grain size varies across datasets from 0.0000000158 km2 (158 cm2) to 100 km2 (1,000,000,000,000 cm2). Time period and grain BioTIME records span from 1874 to 2016. The minimal temporal grain across all datasets in BioTIME is a year. Major taxa and level of measurement BioTIME includes data from 44,440 species across the plant and animal kingdoms, ranging from plants, plankton and terrestrial invertebrates to small and large vertebrates. Software format .csv and .SQL.",
           homepage = "https://doi.org/10.1111/geb.1272",
           date = ymd("2019-09-10"),
           license = _INSERT,
           ontology = odb_onto_path)

# matches <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "BioTIME_ontology.csv"))

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
