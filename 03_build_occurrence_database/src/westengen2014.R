# script arguments ----
#
thisDataset <- "Westengen2014"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "Citation.ris"))

regDataset(name = thisDataset,
           description = "Sorghum is a drought-tolerant crop with a vital role in the livelihoods of millions of people in marginal areas. We examined genetic structure in this diverse crop in Africa. On the continent-wide scale, we identified three major sorghum populations (Central, Southern, and Northern) that are associated with the distribution of ethnolinguistic groups on the continent. The codistribution of the Central sorghum population and the Nilo-Saharan language family supports a proposed hypothesis about a close and causal relationship between the distribution of sorghum and languages in the region between the Chari and the Nile rivers. The Southern sorghum population is associated with the Bantu languages of the Niger-Congo language family, in agreement with the farming-language codispersal hypothesis as it has been related to the Bantu expansion. The Northern sorghum population is distributed across early Niger-Congo and Afro-Asiatic language family areas with dry agroclimatic conditions. At a finer geographic scale, the genetic substructure within the Central sorghum population is associated with language-group expansions within the Nilo-Saharan language family. A case study of the seed system of the Pari people, a Western-Nilotic ethnolinguistic group, provides a window into the social and cultural factors involved in generating and maintaining the continent-wide diversity patterns. The age-grade system, a cultural institution important for the expansive success of this ethnolinguistic group in the past, plays a central role in the management of sorghum landraces and continues to underpin the resilience of their traditional seed system.",
           url = "https://doi.org/10.1073/pnas.1401646111",
           download_date = "2022-05-30",
           type = "static",
           licence = "",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#

data <- read_excel(paste0(thisPath, "pnas.1401646111.sd01.xlsx"), skip = 6)



# harmonise data ----
#

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    type = "point",
    x = `Longitude*`,
    y = `Latitude*`,
    geometry = NA,
    year = "NA-1983_11-2010_1-2013",
    month = NA_real_,
    day = NA_integer_,
    country = "South Sudan",
    irrigated = F,
    area = NA_real_,
    presence = F,
    externalID = NA_character_,
    externalValue = "sorghum",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  separate(year, sep = "-", into = c("month", "year")) %>%
  mutate(year = as.numeric(year),
         month = as.numeric(month),
         fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())

# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
