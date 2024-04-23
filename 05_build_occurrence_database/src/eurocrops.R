# ----
# geography : Europe
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# sample    : _INSERT
# doi/url   : _INSERT
# license   : _INSERT
# disclosed : _INSERT
# doi/url   : https://github.com/maja601/EuroCrops
# authors   : Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

thisDataset <- "eurocrops"
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
input_dir <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, "10.1038_s41597-023-02517-0-citation.bib"))
# bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "ref.bib"))

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
           homepage = "https://github.com/maja601/EuroCrops",
           date = ymd("2022-04-27"),
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
