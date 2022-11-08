# script arguments ----
#
thisDataset <- "Ballauff2021"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibentry(
  bibtype = "misc",
  title = "Belowground fungi, soil, and root chemistry in tropical landuse systems",
  author = as.person("Andrea Polle [aut], Johannes Ballauff [aut]"),
  year = "2021",
  organization = "Dryad",
  address = "Göttingen, Germany",
  doi = "https://doi.org/10.5061/dryad.7h44j0zrd",
  url = "https://datadryad.org/stash/dataset/doi:10.5061/dryad.7h44j0zrd",
  type = "data set"
)

regDataset(name = thisDataset,
           description = "The data were collected in the humid tropical climate on Sumatra (Indonesia) in rain forests, in jungle rubber (rubber planted into forests), in rubber, and oil palm plantations. A total of 44 plots were sampled. The data set consists of two tables. The table Environmental_data contains plot information, geographic coordinates of the plots, and data on soil properties (pH, nitrogen, carbon, C/N, potassium, calcium, magnesium, manganese, iron, phosporous, soil resource index, soil PC1, soil PC2) and on root traits (biomass, nitrogen, carbon, C/N, potassium, calcium, magnesium, manganese, iron, phosporous, root resource index, root PC1, soil PC, root vitality). Table 2 contain abundance data (OTU counts) for fungi associated with roots or with soil and their phylogenetic and functional assignments.",
           url = "https://doi.org/10.1016/j.soilbio.2021.108140",
           download_date = "2022-01-14",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(path = paste0(thisPath, "Environmental_data.xlsx"), skip = 1)


# manage ontology ---
#
matches <- tibble(new = c(unique(data$landuse)),
                  old = c("Naturally Regenerating Forest", "natural rubber", "oil palm", "natural rubber"))

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
  mutate(
    fid = row_number(),
    x = Longitude,
    y = Latitude,
    year = 2016,
    month = 11,
    day = NA_integer_,
    datasetID = thisDataset,
    country = "Indonesia",
    irrigated = F,
    externalID = `Plot ID`,
    externalValue = landuse,
    type = "areal",
    area = 2500,
    presence = TRUE,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    geometry = NA,
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
