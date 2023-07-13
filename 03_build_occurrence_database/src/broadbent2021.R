# script arguments ----
#
thisDataset <- "Broadbent2021"
description <- "Aim Nutrient enrichment is associated with plant invasions and biodiversity loss. Functional trait advantages may predict the ascendancy of invasive plants following nutrient enrichment but this is rarely tested. Here, we investigate 1) whether dominant native and non-native plants differ in important morphological and physiological leaf traits, 2) how their traits respond to nutrient addition, and 3) whether responses are consistent across functional groups. Location Australia, Europe, North America and South Africa Time period 2007 - 2014 Major taxa studied Graminoids and forbs Methods We focused on two types of leaf traits connected to resource acquisition: morphological features relating to light-foraging surfaces and investment in tissue (Specific Leaf Area, SLA) and physiological features relating to internal leaf chemistry as the basis for producing and utilizing photosynthate. We measured these traits on 503 leaves from 151 dominant species across 27 grasslands on four continents. We used an identical nutrient addition treatment of nitrogen (N), phosphorus (P) and potassium (K) at all sites. Sites represented a broad range of grasslands that varied widely in climatic and edaphic conditions. Results We found evidence that non-native graminoids invest in leaves with higher nutrient concentrations than native graminoids, particularly at sites where native and non-native species both dominate. We found little evidence that native and non-native forbs differed in the measured leaf traits. These results were consistent in natural soil fertility levels and nutrient enriched conditions, with dominant species responding similarly to nutrient addition regardless of whether they were native or non-native. Main conclusions Our work identifies the inherent physiological trait advantages that can be used to predict non-native graminoid establishment; potentially because of higher efficiency at taking up crucial nutrients into their leaves. Most importantly, these inherent advantages are already present at natural soil fertility levels and are maintained following nutrient enrichment."
url <- "https://doi.org/10.5061/dryad.tmpg4f4v8 https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- ris_reader(paste0(thisPath, "pericles_1466823829.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2020-06-02"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(thisPath, "Broadbent_et_al_2020_GEB_Data.csv"))


# harmonise data ----
#
temp <- data %>%
  distinct(year, latitude, longitude, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = case_when(country == "AU" ~ "Australia",
                        country == "PT" ~ "Portugal",
                        country == "CA" ~ "Canada",
                        country == "US" ~ "United States of America",
                        country == "CH" ~ "Switzerland",
                        country == "ZA" ~ "South Africa",
                        country == "UK" ~ "Unitedd Kingdom",
                        country == "DE" ~ "Germany"),
    x = longitude,
    y = latitude,
    geometry = NA,
    epsg = 4326,
    area = 25,
    date = NA,
    # year = "2007_2008_2009_2010_2011_2012_2013_2014",
    # month = NA_real_,
    # day = NA_integer_,
    externalID = NA_character_,
    externalValue = "Herbaceous associations",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = as.numeric(year),
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
