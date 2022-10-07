# script arguments ----
#
thisDataset <- "Karlsson2017"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1365294x26.bib"))

regDataset(name = thisDataset,
           description = "Organic farming is often advocated as an approach to mitigate biodiversity loss on agricultural land. The phyllosphere provides a habitat for diverse fungal communities that are important for plant health and productivity. However, it is still unknown how organic farming affects the diversity of phyllosphere fungi in major crops. We sampled wheat leaves from 22 organically and conventionally cultivated fields in Sweden, paired based on their geographical location and wheat cultivar. Fungal communities were described using amplicon sequencing and real-time PCR. Species richness was higher on wheat leaves from organically managed fields, with a mean of 54 operational taxonomic units (OTUs) compared with 40 OTUs for conventionally managed fields. The main components of the fungal community were similar throughout the 350-km-long sampling area, and seven OTUs were present in all fields: Zymoseptoria, Dioszegia fristingensis, Cladosporium, Dioszegia hungarica, Cryptococcus, Ascochyta and Dioszegia. Fungal abundance was highly variable between fields, 103–105 internal transcribed spacer copies per ng wheat DNA, but did not differ between cropping systems. Further analyses showed that weed biomass was the strongest explanatory variable for fungal community composition and OTU richness. These findings help provide a more comprehensive understanding of the effect of organic farming on the diversity of organism groups in different habitats within the agroecosystem.",
           url = "https://doi.org/10.1111/mec.14132",
           download_date = "2022-13-04",
           type = "static",
           licence = "CC BY 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "SuppInfo_TablesS1-S6.xlsx"), sheet = 3, skip = 1, n_max = 23)


# harmonise data ----
#

temp <- data %>%
  mutate(
    fid = row_number(),
    x = Latitude,
    y = Longitude,
    date = ymd("2017-07-01"),
    datasetID = thisDataset,
    country = NA_character_,
    irrigated = FALSE,
    externalID = NA_character_,
    presence = FALSE,
    type = "point",
    area = NA_real_,
    geometry = NA,
    externalValue = "wheat",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")

