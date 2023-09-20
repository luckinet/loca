# script arguments ----
#
thisDataset <- "Ballauff2021"
description <- "The data were collected in the humid tropical climate on Sumatra (Indonesia) in rain forests, in jungle rubber (rubber planted into forests), in rubber, and oil palm plantations. A total of 44 plots were sampled. The data set consists of two tables. The table Environmental_data contains plot information, geographic coordinates of the plots, and data on soil properties (pH, nitrogen, carbon, C/N, potassium, calcium, magnesium, manganese, iron, phosporous, soil resource index, soil PC1, soil PC2) and on root traits (biomass, nitrogen, carbon, C/N, potassium, calcium, magnesium, manganese, iron, phosporous, root resource index, root PC1, soil PC, root vitality). Table 2 contain abundance data (OTU counts) for fungi associated with roots or with soil and their phylogenetic and functional assignments."
url <- "https://doi.org/10.1016/j.soilbio.2021.108140 https://"
licence <- "CC0 1.0"


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
           description = description,
           url = url,
           download_date = ymd("2022-01-14"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(path = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Environmental_data.xlsx"), skip = 1)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Indonesia",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = 2500,
    date = NA,
    # year = 2016,
    # month = 11,
    # day = NA_integer_,
    externalID = `Plot ID`,
    externalValue = landuse,
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

# matches <- tibble(new = c(unique(data$landuse)),
#                   old = c("Naturally Regenerating Forest", "natural rubber", "oil palm", "natural rubber"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
