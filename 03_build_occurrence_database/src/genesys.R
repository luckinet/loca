# script arguments ----
#
thisDataset <- "Genesys"
description <- "Genesys is a database which allows users to explore the world’s crop diversity conserved in genebanks through a single website."
url <- "https://doi.org/ https://www.genesys-pgr.org/"
licence <- "dataset specific"


# reference ----
#
bib <- bibentry(bibtype = "Misc",
                title = "Genesys Passport data",
                url = "https://www.genesys-pgr.org/",
                author = "Genesys",
                year = "2020")

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2020-03-16"),
           type = "dynamic",
           licence = licence,
           contact = "see reference for data",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
genesysFiles <- list.files(occurrenceDBDir, "00_incoming/", thisDataset, "/", full.names = TRUE)[-1]

data <- map(genesysFiles, read_excel) %>%
  bind_rows()

# harmonise data ----
#
cnts <- tibble(iso_a3 = unique(data$ORIGCTY)) %>%
  filter(!is.na(iso_a3)) %>%
  left_join(countries, by = "iso_a3") %>%
  filter(!is.na(unit))

temp <- data %>%
  mutate(ACQDATE = gsub("--", "01", ACQDATE)) %>%
  drop_na(DECLONGITUDE, DECLATITUDE, ACQDATE) %>%
  distinct(DECLONGITUDE, DECLATITUDE, ACQDATE, CROPNAME, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = ORIGCTY,
    x = DECLONGITUDE,
    y = DECLATITUDE,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(ACQDATE),
    externalID = ACCENUMB,
    externalValue = CROPNAME,
    irrigated = NA,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring") %>%
  drop_na(date) %>%
  left_join(cnts %>% select(iso_a3, unit), by = "iso_a3") %>%
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
