thisDataset <- _INSERT
message("\n---- ", thisDataset, " ----")

# current data repositories
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2020atopendataaustriapoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2020frignrpgpoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2019frignrpgpoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2018frignrpgpoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2017frignrpgpoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2021atopendataaustriapoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2019atopendataaustriapoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2018atopendataaustriapoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2017atopendataaustriapoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2021beflandersfullpoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2019beflandersfullpoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2018beflandersfullpoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2017beflandersfullpoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2021lvfullpoly110
# https://worldcereal-rdm.geo-wiki.org/collections/details/?id=2019lvfullpoly110



message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, _INSERT))

# data_path_cmpr <- paste0(input_dir, "")
# unzip(exdir = input_dir, zipfile = data_path_cmpr)
# untar(exdir = input_dir, tarfile = data_path_cmpr)

data_path <- paste0(input_dir, _INSERT)
data <- read_csv(file = data_path)
data <- read_tsv()
data <- st_read(dsn = data_path) %>% as_tibble()
data <- read_excel(path = data_path)
data <- read_parquet()


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

