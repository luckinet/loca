# script arguments ----
#
thisDataset <- "Maas2015"
description <- "Avian ecosystem services such as the suppression of pests are considered being of high ecological and economic importance in a range of ecosystems, especially in tropical agroforestry. But how bird predation success is related to the diversity and composition of the bird community, as well as local and landscape factors, is poorly understood. The author quantified arthropod predation in relation to the identity and diversity of insectivorous birds, using experimental exposure of artificial, caterpillar-like prey on smallholder cacao agroforestry systems, differing in local shade management and distance to primary forest. The bird community was assessed using both mist netting (targeting on active understory insectivores) and point count (higher completeness of species inventories) sampling. The study was conducted in a land use dominated area in Central Sulawesi, Indonesia, adjacent to the Lore Lindu National Park. We selected 15 smallholder cacao plantations as sites for bird and bat exclosure experiments in March 2010. Until July 2011, we recorded several data in this study area, including the bird community data, cacao tree data and bird predation experiments that are presented here. We found that avian predation success can be driven by single and abundant insectivorous species, rather than by overall bird species richness. Forest proximity was important for enhancing the density of this key species, but did also promote bird species richness. The availability of local shade trees had no effects on the local bird community or avian predation success. Our findings are both of economical as well as ecological interest because the conservation of nearby forest remnants will likely benefit human needs and biodiversity conservation alike."
url <- "https://doi.org/10.1594/PANGAEA.841264 https://"
licence <- "CC-BY-3.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Maas_2015.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-13"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_tsv(paste0(thisPath, "NapuValley_cacao_trees.tab"), skip = 33)


# harmonise data ----
#
temp <- data %>% mutate(year = "2010_2011") %>%
  separate_rows(year, sep = "_") %>%
  mutate(month = case_when(year == "2010" ~ paste0("03_04_05_06_07_08_09_10_11_12"),
                           year == "2011" ~ paste0("01_02"))) %>%
  separate_rows(month, sep = "_")

temp <- temp %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Indonesia",
    x = Latitude,
    y = Longitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = as.numeric(year),
    # month = as.numeric(month),
    externalID = NA_character_,
    externalValue = "cocoa beans",
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

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
