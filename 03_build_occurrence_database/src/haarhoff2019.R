# script arguments ----
#
thisDataset <- "Haarhoff2019"
description <- "Maize (Zea mays L.) productivity has increased globally as a result of improved genetics and agronomic practices. Plant population and row spacing are two key agronomic factors known to have a strong influence on maize grain yield. A systematic review was conducted to investigate the effects of plant population on maize grain yield, differentiating between rainfall regions, N input, and soil tillage system (conventional tillage [CT] and no-tillage [NT]). Data were extracted from 64 peer-reviewed articles reporting on rainfed field trials, representing 13 countries and 127 trial locations. In arid environments, maize grain yield was low (mean maize grain yield = 2448 kg ha−1) across all plant populations with no clear response to plant population. Variation in maize grain yield was high in semiarid environments where the polynomial regression (p < 0.001, n = 951) had a maximum point at ∼140,000 plants ha−1, which reflected a maize grain yield of 9000 kg ha−1. In subhumid environments, maize grain yield had a positive response to plant population (p < 0.001). Maize grain yield increased for both CT and NT systems as plant population increased. In high-N-input (r2 = 0.19, p < 0.001, n = 2 018) production systems, the response of plant population to applied N was weaker than in medium-N-input (r2 = 0.49, p < 0.001, n = 680) systems. There exists a need for more metadata to be analyzed to provide improved recommendations for optimizing plant populations across different climatic conditions and rainfed maize production systems. Overall, the importance of optimizing plant population to local environmental conditions and farming systems is illustrated."
url <- "https://doi.org/10.2135/cropsci2018.01.0003 https://"
licence <- "CC BY-NC-ND 4.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1435065358.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-04-13"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Appendix C. Supplementary data.xlsx"))


# pre-process data ----
#
temp <- data %>%
  distinct(Coordinates, `Year of trial`, .keep_all = TRUE) %>%
  separate_rows(Coordinates, sep = ";")

temp <- data %>%
  separate(Coordinates, sep = ",", into = c("lat", "long")) %>%
  drop_na(lat, long)

x <-  str_remove(temp$lat, c("latitude", "Lat."))

temp1 <- temp %>%
  mutate(y = char2dms(temp$lat, chd = "°", chm = "'", chs = "\""),
         x = char2dms(temp$long, chd = "°", chm = "'", chs = "\""))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = NA_real_,
    y = NA_real_,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = "maize",
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = FALSE,
    sample_type = NA_character_,
    collector = NA_character_,
    purpose = NA_character_) %>%
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
