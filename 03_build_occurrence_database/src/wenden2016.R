# script arguments ----
#
thisDataset <- "Wenden2016"
description <- "Professional and scientific networks built around the production of sweet cherry (Prunus avium L.) led to the collection of phenology data for a wide range of cultivars grown in experimental sites characterized by highly contrasted climatic conditions. We present a dataset of flowering and maturity dates, recorded each year for one tree when available, or the average of several trees for each cultivar, over a period of 37 years (1978–2015). Such a dataset is extremely valuable for characterizing the phenological response to climate change, and the plasticity of the different cultivars’ behaviour under different environmental conditions. In addition, this dataset will support the development of predictive models for sweet cherry phenology exploitable at the continental scale, and will help anticipate breeding strategies in order to maintain and improve sweet cherry production in Europe."
url <- "https://doi.org/10.1038/sdata.2016.108 https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_sdata.2016.108-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-12-17"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Sweet_cherry_phenology_data_1978-2015.xlsx"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = Country,
    x = as.numeric(Longitude),
    y = as.numeric(Latitude),
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = as.numeric(Year),
    # month = NA_real_,
    # day = NA_integer_,
    externalID = NA_character_,
    externalValue = "cherry",
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
