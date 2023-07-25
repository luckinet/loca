# script arguments ----
#
thisDataset <- "Ingrisch2014"
description <- "The Tibetan highlands host the largest alpine grassland ecosystems worldwide, bearing soils that store substantial stocks of carbon (C) that are very sensitive to land use changes. This study focuses on the cycling of photoassimilated C within a Kobresia pygmaea pasture, the dominating ecosystems on the Tibetan highlands. We investigated short-term effects of grazing cessation and the role of the characteristic Kobresia root turf on C fluxes and belowground C turnover. By combining eddy-covariance measurements with 13CO2 pulse labeling we applied a powerful new approach to measure absolute fluxes of assimilates within and between various pools of the plant-soil-atmosphere system. The roots and soil each store roughly 50% of the overall C in the system (76 Mg C ha− 1), with only a minor contribution from shoots, which is also expressed in the root:shoot ratio of 90. During June and July the pasture acted as a weak C sink with a strong uptake of approximately 2 g C m− 2  d− 1 in the first half of July. The root turf was the main compartment for the turnover of photoassimilates, with a subset of highly dynamic roots (mean residence time 20 days), and plays a key role for the C cycling and C storage in this ecosystem. The short-term grazing cessation only affected aboveground biomass but not ecosystem scale C exchange or assimilate allocation into roots and soil."
url <- "https://doi.org/10.1594/PANGAEA.833749 https://"
licence <- "CC-BY-3.0"


# reference ----
#
bib <- ris_reader(paste0(thisPath, "13CO2_resp.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-06-04"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_tsv(file = paste0(thisPath, "13CO2_pools.tab"), skip = 37)


# harmonise data ----
#
temp <- data %>%
  distinct(Longitude, Latitude, `Date/Time`, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "China",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = 25000,
    date = NA,
    # year = year(ymd(`Date/Time`)),
    # month = month(ymd(`Date/Time`)),
    # day = day(ymd(`Date/Time`)),
    externalID = NA_character_,
    externalValue = Treat,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
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

# matches <- tibble(new = c(unique(data$Treat)),
#                   old = c("Permanent grazing", "Temporary grazing", "Herbaceous associations"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
