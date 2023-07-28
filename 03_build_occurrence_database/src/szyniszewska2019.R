# script arguments ----
#
thisDataset <- ""
description <- ""
url <- "https://doi.org/ https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "")) # or bibtex_reader()

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd(),
           type = NA_character_,
           licence = licence,
           contact = NA_character_,
           disclosed = NA,
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




# script arguments ----
#
thisDataset <- "Szyniszewska2019"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "9273536.bib")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "Cassava brown streak disease (CBSD) is currently the most devastating cassava disease in eastern, central and southern Africa affecting a staple crop for over 700 million people on the continent. A major outbreak of CBSD in 2004 near Kampala rapidly spread across Uganda. In the following years, similar CBSD outbreaks were noted in countries across eastern and central Africa, and now the disease poses a threat to West Africa including Nigeria - the biggest cassava producer in the world. A comprehensive dataset with 7,627 locations, annually and consistently sampled between 2004 and 2017 was collated from historic paper and electronic records stored in Uganda. The survey comprises multiple variables including data for incidence and symptom severity of CBSD and abundance of the whitefly vector (Bemisia tabaci). This dataset provides a unique basis to characterize the epidemiology and dynamics of CBSD spread in order to inform disease surveillance and management. We also describe methods used to integrate and verify extensive field records for surveys typical of emerging epidemics in subsistence crops. ",
           url = "https://doi.org/10.1038/s41597-019-0334-9",
           type = "static",
           licence = "CC-BY-4.0",
           bibliography = bib,
           download_date = "2021-12-17",
           contact = "see corresponding author",
           disclosed = "yes",
           update = TRUE)


# read dataset ----
#
data_A <- read_csv(paste0(thisPath, "DATASET_A.csv"))
data_B <- read_csv(paste0(thisPath, "DATASET_B.csv"))


# manage ontology ---
#


# harmonise data ----
#
temp <- bind_rows(data_A, data_B) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = longitude,
    y = latitude,
    geometry = NA,
    date = mdy(date),
    year = year,
    month = month(date),
    day = day(date),
    country = "Uganda",
    irrigated = NA,
    area = field_size_m2,
    presence = TRUE,
    externalID = as.character(id),
    externalValue = "cassava",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
