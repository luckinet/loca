# script arguments ----
#
thisDataset <- "Karlsson2017"
description <- "Organic farming is often advocated as an approach to mitigate biodiversity loss on agricultural land. The phyllosphere provides a habitat for diverse fungal communities that are important for plant health and productivity. However, it is still unknown how organic farming affects the diversity of phyllosphere fungi in major crops. We sampled wheat leaves from 22 organically and conventionally cultivated fields in Sweden, paired based on their geographical location and wheat cultivar. Fungal communities were described using amplicon sequencing and real-time PCR. Species richness was higher on wheat leaves from organically managed fields, with a mean of 54 operational taxonomic units (OTUs) compared with 40 OTUs for conventionally managed fields. The main components of the fungal community were similar throughout the 350-km-long sampling area, and seven OTUs were present in all fields: Zymoseptoria, Dioszegia fristingensis, Cladosporium, Dioszegia hungarica, Cryptococcus, Ascochyta and Dioszegia. Fungal abundance was highly variable between fields, 103–105 internal transcribed spacer copies per ng wheat DNA, but did not differ between cropping systems. Further analyses showed that weed biomass was the strongest explanatory variable for fungal community composition and OTU richness. These findings help provide a more comprehensive understanding of the effect of organic farming on the diversity of organism groups in different habitats within the agroecosystem."
url <- "https://doi.org/10.1111/mec.14132 https://" # doi, in case this exists and download url separated by empty space
licence <- "CC BY 4.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1365294x26.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("04-13-2022"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "SuppInfo_TablesS1-S6.xlsx"), sheet = 3, skip = 1, n_max = 23)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = Latitude,
    y = Longitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd("2017-07-01"),
    externalID = NA_character_,
    externalValue = "wheat",
    irrigated = FALSE,
    presence = FALSE,
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
