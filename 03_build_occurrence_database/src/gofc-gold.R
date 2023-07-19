# script arguments ----
#
thisDataset <- "GOFC-GOLD"
description <- "Towards Better Use of Global Land Cover Datasets and Improved Accuracy Assessment Practices"
url <- "https://doi.org/ https://gofcgold.org/"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "")) # or bibtex_reader()

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-11-12"),
           type = "static",
           licence = licence,
           contact = NA_character_,
           disclosed = FALSE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data1 <- read_excel(paste0(thisPath, "glc2k_agl11_rndsel.xlsx"), sheet = 1)
data2 <- read_csv(paste0(thisPath, "GLCNMO_2008.csv"))
data3 <- read_csv(paste0(thisPath, "Globcover2005_April2013_no_commo.csv"))
data4 <- read_csv(paste0(thisPath, "step_september152014_70rndsel_igbpcl.csv"))


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
