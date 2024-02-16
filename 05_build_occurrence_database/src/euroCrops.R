thisDataset <- "_INSERT"                                                         # the ID of this dataset
message("\n---- ", thisDataset, " ----")

# current data repositories
# https://github.com/maja601/EuroCrops
#
# OR
#
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2021pteurocroppoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2021denrweurocroppoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2021lteurocroppoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2021sieurocroppoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2021eeeurocroppoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2021delseurocroppoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2021seeurocroppoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2020nleurocroppoly110


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, "_INSERT"))

# data_path_cmpr <- paste0(input_dir, "")
data_path <- paste0(input_dir, "_INSERT")

# (unzip/untar)
# unzip(exdir = input_dir, zipfile = data_path_cmpr)
# untar(exdir = input_dir, tarfile = data_path_cmpr)

data <- read_csv(file = data_path)
data <- read_tsv(file = data_path)
data <- st_read(dsn = data_path) %>% as_tibble()
data <- read_excel(path = data_path)


message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1)

other <- data %>%
  select(_INSERT)

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
           description = "_INSERT",
           homepage = "_INSERT",
           date = ymd("_INSERT"),
           license = "_INSERT",
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

# script arguments ----
#
thisDataset <- "euroCrops"
description <- ""
url <- "https://doi.org/ https://github.com/maja601/EuroCrops"
licence <- "CC BY 4.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "ref.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-04-27"),
           type = "dynamic",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", ""))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = NA_character_,
    country = NA_character_,
    x = NA_real_,
    y = NA_real_,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = NA_character_,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = NA,
    sample_type = NA_character_,
    collector = NA_character_,
    purpose = NA_character_) %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated, presence,
         sample_type, collector, purpose, everything())


# harmonize with ontology ----
#
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
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")

