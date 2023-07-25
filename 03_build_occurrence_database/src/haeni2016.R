# script arguments ----
#
thisDataset <- "Haeni2016"
description = "Measurements of tree heights and crown sizes are essential in long-term monitoring of spatially distributed forests to assess the health of forests over time. In Switzerland, in 1994 and 1997, more than 4'500 trees have been recorded in a 8x8 km plot within the Sanasilva Inventory, which comprises the Swiss Level I sites of the International Co-operative Programme on Assessment and Monitoring of Air Pollution Effects on Forests' (ICP Forests). Tree heights and crown sizes were measured for the dominant and co-dominant trees (n = 1,723), resulting in a data set from 171 plots in Switzerland, spreading over a broad range of climatic gradient and forest characteristics (species recorded = 20). Average tree height was 22.1 m, average DBH 34.6 cm and crown diameter 6.5 m. The data set presented here is open to use and shall foster research in allometric equation modelling."
url <- "https://doi.org/10.1594/PANGAEA.864521 https://"
licence <- "CC-BY-3.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Haeni_2016a.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-10-18"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_tsv(file = paste0(thisPath, "Haeni_2016a.tab"), skip = 20)


# harmonise data ----
#
temp <- data %>%
  drop_na(Latitude, Longitude) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Switzerland",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = "1994_1995_1996_1997",
    externalID = as.character(ID),
    externalValue = "Naturally Regenerating Forest",
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring") %>%
  separate_rows(year, sep = "_") %>%
  mutate(
    fid = row_number(),
    date = ymd(paste0(year, "-01-01"))) %>%
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
