# script arguments ----
#
thisDataset <- "Vilanova2018"
description <- "Using data from 50 long-term permanent plots from across Venezuelan forests in northern South America, we explored large-scale patterns of stem turnover, aboveground biomass (AGB) and woody productivity (AGWP), and the relationships between them and with potential climatic drivers. We used principal component analysis coupled with generalized least squares models to analyze the relationship between climate, forest structure and stem dynamics. Two major axes associated with orthogonal temperature and moisture gradients effectively described more than 90% of the environmental variability in the dataset. Average turnover was 1.91 ± 0.10% year-1 with mortality and recruitment being almost identical, and close to average rates for other mature tropical forests. Turnover rates were significantly different among regions (p < 0.001), with the lowland forests in Western alluvial plains being the most dynamic, and Guiana Shield forests showing the lowest turnover rates. We found a weak positive relationship between AGB and AGWP, with Guiana Shield forests having the highest values for both variables (204.8 ± 14.3 Mg C ha-1 and 3.27 ± 0.27 Mg C ha-1 year-1 respectively), but AGB was much more strongly and negatively related to stem turnover. Our data suggest that moisture is a key driver of turnover, with longer dry seasons favoring greater rates of tree turnover and thus lower biomass, having important implications in the context of climate change, given the increases in drought frequency in many tropical forests. Regional variation in AGWP among Venezuelan forests strongly reflects the effects of climate, with greatest woody productivity where both precipitation and temperatures are high. Overall, forests in wet, low elevation sites and with slow turnover stored the greatest amounts of biomass. Although faster stand dynamics are closely associated with lower carbon storage, stem-level turnover rates and woody productivity did not show any correlation, indicating that stem dynamics and carbon dynamics are largely decoupled from one another."
url <- "https://doi.org/10.1371/journal.pone.0198489"
license <- "CC BY 4.0"


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1371_journal.pone.0198489.ris"))

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
data <- read_xlsx(paste0(thisPath, "DataFile.xlsx"))


# harmonise data ----
#
temp <- data %>%
  rename(
    x = unique("long"),
    y = unique("lat")) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = NA_character_,
    country = "venezuela",
    x = NA_real_,
    y = NA_real_,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = NA_character_,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = NA,
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
