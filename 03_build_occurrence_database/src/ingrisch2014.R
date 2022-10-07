# script arguments ----
#
thisDataset <- "Ingrisch2014"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "13CO2_resp.ris"))

regDataset(name = thisDataset,
           description = "The Tibetan highlands host the largest alpine grassland ecosystems worldwide, bearing soils that store substantial stocks of carbon (C) that are very sensitive to land use changes. This study focuses on the cycling of photoassimilated C within a Kobresia pygmaea pasture, the dominating ecosystems on the Tibetan highlands. We investigated short-term effects of grazing cessation and the role of the characteristic Kobresia root turf on C fluxes and belowground C turnover. By combining eddy-covariance measurements with 13CO2 pulse labeling we applied a powerful new approach to measure absolute fluxes of assimilates within and between various pools of the plant-soil-atmosphere system. The roots and soil each store roughly 50% of the overall C in the system (76 Mg C ha− 1), with only a minor contribution from shoots, which is also expressed in the root:shoot ratio of 90. During June and July the pasture acted as a weak C sink with a strong uptake of approximately 2 g C m− 2  d− 1 in the first half of July. The root turf was the main compartment for the turnover of photoassimilates, with a subset of highly dynamic roots (mean residence time 20 days), and plays a key role for the C cycling and C storage in this ecosystem. The short-term grazing cessation only affected aboveground biomass but not ecosystem scale C exchange or assimilate allocation into roots and soil.",
           url = "https://doi.org/10.1594/PANGAEA.833749",
           download_date = "2022-06-04",
           type = "static",
           licence = "CC-BY-3.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#

data <- read_tsv(file = paste0(thisPath, "13CO2_pools.tab"), skip = 37)



# manage ontology ---
#
# define labels in the new dataset and their matching already harmonised labels
matches <- tibble(new = c(unique(data$Treat)),
                  old = c("Permanent grazing", "Temporary grazing", "Herbaceous associations"))


getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)


# harmonise data ----
#

temp <- data %>%
  distinct(Longitude, Latitude, `Date/Time`, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    year = year(ymd(`Date/Time`)),
    month = month(ymd(`Date/Time`)),
    day = day(ymd(`Date/Time`)),
    country = "China",
    irrigated = F,
    area = 25000,
    presence = T,
    externalID = NA_character_,
    externalValue = Treat,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
