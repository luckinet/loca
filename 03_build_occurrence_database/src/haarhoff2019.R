# script arguments ----
#
thisDataset <- "Haarhoff2019"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1435065358.bib"))

regDataset(name = thisDataset,
           description = "Maize (Zea mays L.) productivity has increased globally as a result of improved genetics and agronomic practices. Plant population and row spacing are two key agronomic factors known to have a strong influence on maize grain yield. A systematic review was conducted to investigate the effects of plant population on maize grain yield, differentiating between rainfall regions, N input, and soil tillage system (conventional tillage [CT] and no-tillage [NT]). Data were extracted from 64 peer-reviewed articles reporting on rainfed field trials, representing 13 countries and 127 trial locations. In arid environments, maize grain yield was low (mean maize grain yield = 2448 kg ha−1) across all plant populations with no clear response to plant population. Variation in maize grain yield was high in semiarid environments where the polynomial regression (p < 0.001, n = 951) had a maximum point at ∼140,000 plants ha−1, which reflected a maize grain yield of 9000 kg ha−1. In subhumid environments, maize grain yield had a positive response to plant population (p < 0.001). Maize grain yield increased for both CT and NT systems as plant population increased. In high-N-input (r2 = 0.19, p < 0.001, n = 2 018) production systems, the response of plant population to applied N was weaker than in medium-N-input (r2 = 0.49, p < 0.001, n = 680) systems. There exists a need for more metadata to be analyzed to provide improved recommendations for optimizing plant populations across different climatic conditions and rainfed maize production systems. Overall, the importance of optimizing plant population to local environmental conditions and farming systems is illustrated.",
           url = "https://doi.org/10.2135/cropsci2018.01.0003",
           download_date = "2022-04-13",
           type = "static",
           licence = "CC BY-NC-ND 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# preprocess data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Appendix C. Supplementary data.xlsx"))

# harmonise data ----
#
add_concept(ontoDir = paste0(dataDir, "ontology.rds"),
            term = ,
            class = ,
            source = thisDataset)

add_relation(ontoDir = paste0(dataDir, "ontology.rds"),

)

# handle coordinates
#
temp <- data %>% distinct(Coordinates, `Year of trial`, .keep_all = TRUE) %>%
  separate_rows(Coordinates, sep = ";")

temp <- data %>% separate(Coordinates, sep = ",", into = c("lat", "long")) %>%
  drop_na(lat, long)

x <-  str_remove(temp$lat, c("latitude", "Lat."))

temp1 <- temp %>%
  mutate(y = char2dms(temp$lat, chd = "°", chm = "'", chs = "\""),
         x = char2dms(temp$long, chd = "°", chm = "'", chs = "\""))


temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = , # x-value of centroid
    y = , # y-value of centroid
    geometry = NA,
    date = , # must be 'POSIXct' object, see lubridate-package. These can be very easily created for instance with dmy(SURV_DATE), if its in day/month/year format
    country = NA_character_,
    irrigated = F,
    area = NA_real_,
    presence = F,
    externalID = NA_character_,
    externalValue = "maize",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = , # "field", "visual interpretation", "experience", "meta study" or "modelled"
    collector = , # "expert", "citizen scientist" or "student"
    purpose = , # "monitoring", "validation", "study" or "map development"
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
