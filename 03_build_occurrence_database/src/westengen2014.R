# script arguments ----
#
thisDataset <- "Westengen2014"
description <- "Sorghum is a drought-tolerant crop with a vital role in the livelihoods of millions of people in marginal areas. We examined genetic structure in this diverse crop in Africa. On the continent-wide scale, we identified three major sorghum populations (Central, Southern, and Northern) that are associated with the distribution of ethnolinguistic groups on the continent. The codistribution of the Central sorghum population and the Nilo-Saharan language family supports a proposed hypothesis about a close and causal relationship between the distribution of sorghum and languages in the region between the Chari and the Nile rivers. The Southern sorghum population is associated with the Bantu languages of the Niger-Congo language family, in agreement with the farming-language codispersal hypothesis as it has been related to the Bantu expansion. The Northern sorghum population is distributed across early Niger-Congo and Afro-Asiatic language family areas with dry agroclimatic conditions. At a finer geographic scale, the genetic substructure within the Central sorghum population is associated with language-group expansions within the Nilo-Saharan language family. A case study of the seed system of the Pari people, a Western-Nilotic ethnolinguistic group, provides a window into the social and cultural factors involved in generating and maintaining the continent-wide diversity patterns. The age-grade system, a cultural institution important for the expansive success of this ethnolinguistic group in the past, plays a central role in the management of sorghum landraces and continues to underpin the resilience of their traditional seed system."
url <- "https://doi.org/10.1073/pnas.1401646111https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(thisPath, "Citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-05-30"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(paste0(thisPath, "pnas.1401646111.sd01.xlsx"), skip = 6)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "South Sudan",
    x = `Longitude*`,
    y = `Latitude*`,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = "NA-1983_11-2010_1-2013",
    # month = NA_real_,
    # day = NA_integer_,
    externalID = NA_character_,
    externalValue = "sorghum",
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_") %>%
  separate(year, sep = "-", into = c("month", "year")) %>%
  mutate(year = as.numeric(year),
         month = as.numeric(month),
         fid = row_number()) %>%
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
