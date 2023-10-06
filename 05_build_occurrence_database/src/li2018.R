# script arguments ----
#
thisDataset <- "Li2018"
description <- "Reliable data on biomass produced by lignocellulosic bioenergy crops are essential to identify sustainable bioenergy sources. Field studies have been performed for decades on bioenergy crops, but only a small proportion of the available data is used to explore future land use scenarios including bioenergy crops. A global dataset of biomass production for key lignocellulosic bioenergy crops is thus needed to disentangle the factors impacting biomass production in different regions. Such dataset will be also useful to develop and assess bioenergy crop modelling in integrated assessment socio-economic models and global vegetation models. Here, we compiled and described a global biomass yield dataset based on field measurements. We extracted 5,088 entries of data from 257 published studies for five main lingocellulosic bioenergy crops: eucalypt, Miscanthus, poplar, switchgrass, and willow. Data are from 355 geographic sites in 31 countries around the world. We also documented the species, plantation practices, climate conditions, soil property, and managements. Our dataset can be used to identify productive bioenergy species over a large range of environments."
url <- "https://doi.org/10.6084/m9.figshare.c.3951967 https://"
licence <- "CC BY 4.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "10.1038_sdata.2018.169-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-19"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Li_etal_2018_SciData_Data.xlsx"))


# pre-process data ----
#
data1 <- data %>%
  separate(Planting_date, into = c("Startyear", "month")) %>%
  separate(Harvest_year, into = c("Endyear", "year_rest"))
data1 <- data %>%
  select(-Planting_date) %>%
  rename(year = Harvest_year)
data2 <- data %>%
  select(-Harvest_year) %>%
  rename(year = Planting_date)
data <- bind_rows(data1, data2)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = NA_character_,
    country = Country,
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = Crop_type,
    irrigated = if_else(!is.na(Irrigation), TRUE, FALSE),
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
