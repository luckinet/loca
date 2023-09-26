# script arguments ----
#
thisDataset <- ""
description <- ""
url <- "https://doi.org/ https://"
licence <- ""


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "pericles_13652745106.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd(),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "mdd6plots_data_22jul2016.csv"))


# pre-process data ----
#
time <- tibble(Site = c("CashuTr3", "CashuTr12", "TRC", "LA", "RA", "BM"),
               year = c(2010, 2009, "2008_2009", "2008_2009", "2008", "2004"))


# harmonise data ----
#
temp <- data %>%
  left_join(., time, by = "Site") %>%
  separate_rows(year, sep = "_") %>%
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
