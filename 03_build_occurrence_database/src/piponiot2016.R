# script arguments ----
#
thisDataset <- "Piponiot2016"
description <- "When 2 Mha of Amazonian forests are disturbed by selective logging each year, more than 90 Tg of carbon (C) is emitted to the atmosphere. Emissions are then counterbalanced by forest regrowth. With an original modelling approach, calibrated on a network of 133 permanent forest plots (175 ha total) across Amazonia, we link regional differences in climate, soil and initial biomass with survivors’ and recruits’ C fluxes to provide Amazon-wide predictions of post-logging C recovery. We show that net aboveground C recovery over 10 years is higher in the Guiana Shield and in the west (21 ±3 Mg C ha−1) than in the south (12 ±3 Mg C ha−1) where environmental stress is high (low rainfall, high seasonality). We highlight the key role of survivors in the forest regrowth and elaborate a comprehensive map of post-disturbance C recovery potential in Amazonia."
url <- "https://doi.org/10.7554/eLife.21394.001"
license <- "CC0 1.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "21394.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-09"),
           type = "static",
           licence = licence,
           contact = "camille.piponiot@gmail.com",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_delim(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "sites_clim_soil.csv"),
                   delim = ";",
                   locale = locale(decimal_mark = ","))


# pre-process data ----
#
data <- data %>%
  rowwise() %>%
  mutate(year = paste0(seq(from = first_census, to = last_census, 1), collapse = "_")) %>%
  separate_rows(year, sep = "_")


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = longitude,
    y = latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(paste0(year, "-01-01")),
    externalID = NA_character_,
    externalValue = "Naturally Regenerating Forest",
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = NA,
    sample_type = "field",
    collector = "expert",
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
