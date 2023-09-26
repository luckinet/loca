# script arguments ----
#
thisDataset <- ""
description <- "Cassava brown streak disease (CBSD) is currently the most devastating cassava disease in eastern, central and southern Africa affecting a staple crop for over 700 million people on the continent. A major outbreak of CBSD in 2004 near Kampala rapidly spread across Uganda. In the following years, similar CBSD outbreaks were noted in countries across eastern and central Africa, and now the disease poses a threat to West Africa including Nigeria - the biggest cassava producer in the world. A comprehensive dataset with 7,627 locations, annually and consistently sampled between 2004 and 2017 was collated from historic paper and electronic records stored in Uganda. The survey comprises multiple variables including data for incidence and symptom severity of CBSD and abundance of the whitefly vector (Bemisia tabaci). This dataset provides a unique basis to characterize the epidemiology and dynamics of CBSD spread in order to inform disease surveillance and management. We also describe methods used to integrate and verify extensive field records for surveys typical of emerging epidemics in subsistence crops."
url <- "https://doi.org/10.1038/s41597-019-0334-9 https://"
licence <- "CC-BY-4.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "9273536.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-12-17"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data_A <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "DATASET_A.csv"))
data_B <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "DATASET_B.csv"))

data <-  bind_rows(data_A, data_B)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Uganda",
    x = longitude,
    y = latitude,
    geometry = NA,
    epsg = 4326,
    area = field_size_m2,
    date = mdy(date),
    externalID = as.character(id),
    externalValue = "cassava",
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
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
