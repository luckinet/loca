thisDataset <- "genesys"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- bibentry(bibtype = "Misc",
                title = "Genesys Passport data",
                url = "https://www.genesys-pgr.org/",
                author = "Genesys",
                year = "2020")

# data_path_cmpr <- paste0(input_dir, "")
data_path <- paste0(input_dir, "_INSERT")

genesysFiles <- list.files(path = input_dir, full.names = TRUE)[-1]
data <- map(genesysFiles, read_excel) %>%
  bind_rows()


message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1)

# temp <- data %>%
#   mutate(ACQDATE = gsub("--", "01", ACQDATE)) %>%
#   drop_na(DECLONGITUDE, DECLATITUDE, ACQDATE) %>%
#   distinct(DECLONGITUDE, DECLATITUDE, ACQDATE, CROPNAME, .keep_all = TRUE)

other <- data %>%
  select(obsID, _INSERT)

schema_genesys <-
  setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
            na_values = _INSERT) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", type = "i", columns = 1) %>%
  setIDVar(name = "externalID", columns = _INSERT) %>% # ACCENUMB
  setIDVar(name = "open", type = "l", value = _INSERT) %>%
  setIDVar(name = "type", value = _INSERT) %>%
  setIDVar(name = "x", type = "n", columns = _INSERT) %>% # DECLONGITUDE
  setIDVar(name = "y", type = "n", columns = _INSERT) %>% # DECLATITUDE
  setIDVar(name = "epsg", value = _INSERT) %>%
  setIDVar(name = "geometry", columns = _INSERT) %>%
  setIDVar(name = "date", columns = _INSERT) %>% # ACQDATE
  setIDVar(name = "irrigated", type = "l", value = _INSERT) %>%
  setIDVar(name = "present", type = "l", value = _INSERT) %>%
  setIDVar(name = "sample_type", value = _INSERT) %>%
  setIDVar(name = "collector", value = _INSERT) %>%
  setIDVar(name = "purpose", value = _INSERT) %>%
  setObsVar(name = "concept", type = "c", columns = _INSERT) # CROPNAME

temp <- reorganise(schema = schema_genesys, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = "Genesys is a database which allows users to explore the world’s crop diversity conserved in genebanks through a single website.",
           homepage = "https://www.genesys-pgr.org/",
           date = ymd("2020-03-16"),
           license = "dataset specific",
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
