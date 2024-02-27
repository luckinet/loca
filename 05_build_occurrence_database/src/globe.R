# script arguments ----
#
thisDataset <- "globe"
thisDataset <- _INSERT
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


description <- "This tool allows you to find and retrieve GLOBE data using several different search parameters.You will be presented a summary of sites that have data available based on your search parameters.From those sites you can further refine your search and or download the data into a CSV file for detailed analysis.A summary CSV file is also available that summarizes the amount of data available for each site."
url <- "https://doi.org/ https://datasearch.globe.gov/"
licence <- ""


# reference ----
#
bib <- bibentry(bibtype = "Misc",
                title = "Global Learning and Observations to Benefit the Environment (GLOBE) Program",
                url = "https://www.globe.gov/",
                note = "'Filter by Protocol' == 'Land Cover'")

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-05-30"),
           type = "dynamic",
           licence = licence,
           contact = NA_character_,
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "GLOBEMeasurementData-17618.csv"))
data <- data[-1,]


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = as.numeric(longitude),
    y = as.numeric(latitude),
    geometry = NA,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = year(measured_on),
    # month = month(measured_on),
    # day = day(measured_on),
    externalID = NA_character_,
    externalValue = `land covers:muc description`,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "field",
    collector = "citizen scientist",
    purpose = "monitoring") %>%
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
