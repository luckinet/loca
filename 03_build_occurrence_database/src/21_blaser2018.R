# script arguments ----
#
thisDataset <- "Blaser2018"
description <- "Meeting demands for agricultural production while maintaining ecosystem services, mitigating and adapting to climate change and conserving biodiversity will be a defining challenge of this century. Crop production in agroforests is being widely implemented with the expectation that it can simultaneously meet each of these goals. But trade-offs are inherent to agroforestry and so unless implemented with levels of canopy cover that optimize these trade-offs, this effort in climate-smart, sustainable intensification may simply compromise both production and ecosystem services. By combining simultaneous measurements of production, soil fertility, disease, climate variables, carbon storage and species diversity along a shade-tree cover gradient, here we show that low-to-intermediate shade cocoa agroforests in West Africa do not compromise production, while creating benefits for climate adaptation, climate mitigation and biodiversity. As shade-tree cover increases above approximately 30%, agroforests become increasingly less likely to generate win–win scenarios. Our results demonstrate that agroforests cannot simultaneously maximize production, climate and sustainability goals but might optimise the trade-off between these goals at low-to-intermediate levels of cover."
url <- "https://doi.org/10.1038/s41893-018-0062-8 https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "10.1038_s41893-018-0062-8-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2020-11-02"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Blaser_etal_2018_NatureSustainability_GIS_Coordinates.xlsx"))


# harmonise data ----
#
temp <- data %>%
  .[-1] %>%
  na.omit() %>%
  filter(Latitude != "NA") %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Ghana",
    x = as.numeric(Longitude),
    y = as.numeric(Latitude),
    geometry = NA,
    epsg = 4326,
    area = 900,
    date = NA,
    # year = "2015_2016_2017",
    externalID = paste0(Site,"_", Type),
    externalValue = "cocoa beans",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = as.numeric(year)) %>%
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
