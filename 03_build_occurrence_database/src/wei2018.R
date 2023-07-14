# script arguments ----
#
thisDataset <- "Wei2018"
description <- "Reliable data on biomass produced by lignocellulosic bioenergy crops are essential to identify sustainable bioenergy sources. Field studies have been performed for decades on bioenergy crops, but only a small proportion of the available data is used to explore future land use scenarios including bioenergy crops. A global dataset of biomass production for key lignocellulosic bioenergy crops is thus needed to disentangle the factors impacting biomass production in different regions. Such dataset will be also useful to develop and assess bioenergy crop modelling in integrated assessment socio-economic models and global vegetation models. Here, we compiled and described a global biomass yield dataset based on field measurements. We extracted 5,088 entries of data from 257 published studies for five main lingocellulosic bioenergy crops: eucalypt, Miscanthus, poplar, switchgrass, and willow. Data are from 355 geographic sites in 31 countries around the world. We also documented the species, plantation practices, climate conditions, soil property, and managements. Our dataset can be used to identify productive bioenergy species over a large range of environments."
url <- "https://doi.org/10.1038/sdata.2018.169 https://figshare.com/collections/_/3951967"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_sdata.2018.169-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-13"),
           type = "static",
           licence = licence,
           contact = "wei.li@lsce.ipsl.fr",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(paste0(thisPath, "Field_sites_180329_sub.xlsx"))


# harmonise data ----
#
temp <- data %>%
  separate_rows(Crop_type, sep = "[+]") %>%
  distinct(Latitude, Longitude, Crop_type, Harvest_year) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(paste(Harvest_year, "-01-01")),
    externalID = NA_character_,
    externalValue = Crop_type,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = TRUE,
    sample_type = "meta study",
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

# luckiOnto <- new_concept(new = c("big cordgrass", "paraserianthes", "facaltaria",
#                                  "dalbergia", "gliricidia", "pinus",
#                                  "casuarina", "sand reed", "big bluestem",
#                                  "indian grass", "arundo", "topinambur",
#                                  "cynara", "brome grass", "festuca",
#                                  "eastern gamagrass", "flat pea", "sudan grass",
#                                  "alder", "napier grass", "guinea grass",
#                                  "bermuda grass", "flaccid grass", "Virginia fanpetals",
#                                  "panic grass", "saccharum", "cocksfoot grass",
#                                  "milkvetch"),
#                          broader = c("_0101", "_0301", "_0102",
#                                      "_0102", "_0102", "_0102",
#                                      "_0102", "_0101", "_0101",
#                                      "_0101", "_0101", "_1301",
#                                      "_0101", "_0101", "_0101",
#                                      "_0101", "_0101", "_0101",
#                                      "_0102", "_0101", "_0101",
#                                      "_0101", "_0101", "_0101",
#                                      "_0101", "_0101", "_0101",
#                                      "_0101"),
#                          class = c("commodity"),
#                          description = NA,
#                          ontology = luckiOnto)

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
