# script arguments ----
#
thisDataset <- "Franklin2018"
description <- "Geographical Ecology of Dry Forest Tree Communities in the West Indies"
url <- "https://doi.org/10.6086/D1ZH32 https://"
licence <- "CC BY 4.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "franklin2018.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-21"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "WestIndiesSDTF_environment_572sites_with_descriptions.csv"), skip = 28)


# harmonise data ----
#
a <- seq(from = 1969, to = 2016, by = 1) # time period of study

temp <- data %>%
  distinct(lat, long, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = case_when(TDF_raw.country == "Bahamas" ~ "Commonwealth of The Bahamas",
                        TDF_raw.country == "Cuba" ~ "Cuba",
                        TDF_raw.country == "Florida" ~ "United States",
                        TDF_raw.country == "Guadeloupe" ~ "France",
                        TDF_raw.country == "hispaniola" | TDF_raw.country ==  "Hispaniola" ~ "Dominican Republic",
                        TDF_raw.country == "Jamaica" ~ "Jamaica",
                        TDF_raw.country == "Martinique" ~ "France",
                        TDF_raw.country == "mona" | TDF_raw.country == "puertorico" ~ "Puerto Rico",
                        TDF_raw.country == "Providencia" ~ "Colombia",
                        TDF_raw.country == "stlucia" ~ "Saint Lucia",
                        TDF_raw.country == "usvi" ~ "United States"),
    x = long,
    y = lat,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = paste(a, collapse = "_"),
    externalID = TDF_raw.plot_id,
    externalValue = "Forests",
    irrigated = NA,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_") %>%
  mutate(
    fid = row_number(),
    date = ymd(paste0(year, "-01-01"))) %>%
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
