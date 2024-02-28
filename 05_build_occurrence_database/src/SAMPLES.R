# script arguments ----
#
thisDataset <- "samples"
description <- "Agricultural greenhouse gas emission factors"
url <- "https://samples.ccafs.cgiar.org/emissions-data/"
license <- ""


# reference ----
#
bib <- bibentry(bibtype = "Misc",
                url = "https://samples.ccafs.cgiar.org/emissions-data/",
                author = "SAMPLES (Standard Assessment of Agricultural Mitigation Potential and Livelihoods)",
                year = "2022")

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-09-23"),
           type = "dynmaic",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", ""))


# pre-process data ----
#
temp <- data %>%
  separate_rows(description, sep = "/") %>%
  separate_rows(description, sep = "[+]")

temp1 <- data %>%
  select(id, org_desc = description)

data <- left_join(temp, temp1, by = "id")

temp <- data %>%
  select(-start_date) %>%
  rename(start_date = end_date)

data <- data %>%
  select(-end_date) %>%
  bind_rows(temp)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = country,
    x = longitude,
    y = latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(start_date),
    externalID = as.character(id),
    externalValue = description,
    irrigated = case_when(str_match(org_desc, "irrigated") == "irrigated" ~ T,
                          is.character(description) ~ F),
    presence = TRUE,
    sample_type ="field",
    collector = "expert",
    purpose = "study") %>%
  drop_na(date) %>%
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

# onto <- read_csv(paste0(thisPath, "SAMPLES_onto.csv"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
