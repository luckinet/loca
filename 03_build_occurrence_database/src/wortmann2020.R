# script arguments ----
#
thisDataset <- "Wortmann2020"
description <- "The profit potential for a given investment in fertilizer use can be estimated using representative crop nutrient response functions. Where response data is scarce, determination of representative response functions can be strengthened by using results from homologous crop growing conditions. Maize (Zea mays L.) nutrient response functions were selected from the Optimization of Fertilizer Recommendations in Africa (OFRA) database of 5500 georeferenced response functions determined from field research conducted in Sub-Saharan Africa. Three methods for defining inference domains for selection of response functions were compared. Use of the OFRA Inference Tool (OFRA-IT; http://agronomy.unl.edu/OFRA) resulted in greater specificity of maize N, P, and K response functions with higher R2 values indicating superiority compared with using the Harvest Choice Agroecological Zones (HC-AEZ) and the recommendation domains of the Global Yield Gap Atlas project (GYGA-RD). The OFRA-IT queries three soil properties in addition to climate-related properties while the latter two options use climate properties only. The OFRA-IT was generally insensitive to changes in criteria ranges of 20–25% used in queries suggesting value in using wider criteria ranges compared with the default for information scarce crop nutrient response functions."
url <- "https://doi.org/10.5061/dryad.tt6h5h1 https://" # doi, in case this exists and download url separated by empty space
licence <- "CC0 1.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "10.1007_s10705-017-9827-0-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("29-05-2022"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "GeorefCropNutrientResponseFunctions_for_Tropical_Africa_Dec_18_2020.xlsx"), sheet = 2)


# harmonise data ----
#
temp <- data %>%
  mutate(Year = case_when(Year == "-9" ~ "NA",
                          Year == "??" ~ "NA",
                          Year == "2104" ~ "2014",
                          TRUE ~ as.character(Year))) %>%
  na_if("NA")%>%
  separate(Year, into = c("Start", "End")) %>%
  mutate(End = case_when(End < 25 ~ paste(20, End, sep = ""),
                         End > 26 ~ paste(19, End, sep = ""),
                         is.na(End) ~ as.character(Start))) %>%
  mutate(Start = as.numeric(Start),
         End = as.numeric(End)) %>%
  drop_na(Start, End, Longitude, Latitude)

temp <- temp %>%
  transmute(No...1, year = map2(Start, End, `:`)) %>%
  unnest %>%
  left_join(., data, by = "No...1")

temp <- data %>%
  separate_rows(`Crop/intercrop`, sep = "intercrop") %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = Country,
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(paste0(year, "-01-01")),
    externalID = NA_character_,
    externalValue = `Crop/intercrop`,
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

# matches <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Wortmann_ontology.csv"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)

# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
