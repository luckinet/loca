thisDataset <- "fritz2017"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, "10.1038_sdata.2017.75-citation.bib"))

data_path <- paste0(input_dir, "GlobalCrowd.tab")

data <- read_tsv(file = data_path,
                 skip = 33)


message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1)

other <- data %>%
  select(obsID, conf_human_impact = `Conf (Confidence Human Impact, 0 = ...)`,
         conf_landcover = `Conf (Confidence Land Cover, 0 = su...)`,
         abandoned = `Perc [%] (Confidence of abandonment, , ...)`,
         conf_abandoned = Conf, highres = `Resolution (High resolution used)`,
         morethan3 = `Code (More than 3 Land Cover Classe...)`,
         record_dateTime = `Date/Time (The date and time the entry w...)`,
         fieldsize = `Size (Size of agricultural fields, ...)`)

schema_fritz2017 <-
  setFormat(header = 1L) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", type = "i", columns = 1) %>%
  setIDVar(name = "externalID", columns = c(4, 3), merge = "-") %>%
  setIDVar(name = "open", type = "l", value = TRUE) %>%
  setIDVar(name = "type", value = "point") %>%
  setIDVar(name = "x", type = "n", columns = 5) %>%
  setIDVar(name = "y", type = "n", columns = 6) %>%
  setIDVar(name = "epsg", value = "4326") %>%
  setIDVar(name = "date", columns = 21) %>%
  setIDVar(name = "irrigated", type = "l", value = FALSE) %>%
  setIDVar(name = "present", type = "l", value = TRUE) %>%
  setIDVar(name = "sample_type", value = "visual interpretation") %>%
  setIDVar(name = "collector", value = "citizen scientist") %>%
  setIDVar(name = "purpose", value = "map development") %>%
  setIDVar(name = "repetition", columns = c(8, 11, 14), rows = 1, split = "\\(([^,]*),") %>%
  setObsVar(name = "concept", type = "c", columns = c(8, 11, 14), top = 1) %>%
  setObsVar(name = "cover_perc", columns = c(9, 12, 15), top = 1) %>%
  setObsVar(name = "human_impact", columns = c(7, 10, 13), top = 1)

temp <- reorganise(schema = schema_fritz2017, input = data) %>%
  filter(!is.na(concept))


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "Global land cover is an essential climate variable and a key biophysical driver for earth system models. While remote sensing technology, particularly satellites, have played a key role in providing land cover datasets, large discrepancies have been noted among the available products. Global land use is typically more difficult to map and in many cases cannot be remotely sensed. In-situ or ground-based data and high resolution imagery are thus an important requirement for producing accurate land cover and land use datasets and this is precisely what is lacking. Here we describe the global land cover and land use reference data derived from the Geo-Wiki crowdsourcing platform via four campaigns.",
           homepage = "https://doi.org/10.1594/PANGAEA.869680",
           date = ymd("2021-09-13"),
           license = "https://creativecommons.org/licenses/by/3.0/",
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
