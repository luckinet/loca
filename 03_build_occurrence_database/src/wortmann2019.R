# script arguments ----
#
thisDataset <- "Wortmann2019"
description <- "Crop production in sub-Saharan Africa has numerous biotic and abiotic constraints, including nutrient deficiencies. Information on crop response to macronutrients is relatively abundant compared with secondary and micronutrients (SMN). Data from 1339 trial replicates of 280 field trials conducted from 2013 to 2016 in 11 countries were analyzed for the diagnosis of SMN deficiencies. The diagnostic data included relative yield response (RYR) and soil and foliar test results. The RYR to application of a combination of Mg, S, Zn, and B (Mg–S–Zn–B) relative to a comparable N–P–K treatment was a >5% increase for 35% of the legume blocks and 60% of the non-legume blocks. The frequencies of soil test Zn, Cu, and B being below their critical level were 28, 2 and 10% for eastern and southern Africa, respectively, and 55, 58 and 89% for western Africa, while low levels for other SMN were less frequent. The frequency of foliar results indicating low availability were 58% for Zn, 16% for S and less for other SMN. The r2 values for relationships between soil test, foliar test and RYR results were <0.035 with little complementarity except for soil test Zn and B with cassava (Manihot esculenta L. Crantz) RYR in Ghana, and foliar Zn with cereal RYR in Uganda. Positive RYR is powerful diagnostic information and indicative of good profit potential for well-targeted and well-specified SMN application. Geo-referenced RYR, soil analysis and foliar analysis results for diagnosis of SMN deficiencies in 11 countries of sub-Saharan Africa were generally not complementary."
url <- "https://doi.org/10.1007/s10705-018-09968-7 https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "10.1007_s10705-018-09968-7-citation.ris")) # or bibtex_reader()

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("14-12-2021"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Tropical Africa Crop Nutrient Diagnosis data set Jan 2019.xlsx"), sheet = 2)


# harmonise data ----
#
listDate <- str_extract_all(data$Code, "20\\d{2}")
year <- unlist(listDate)
df <- as.data.frame(year)
data <- cbind(data, df)

temp <- data %>%
  distinct(Latitude, Longitude, year, Crop, .keep_all = TRUE) %>%
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
    externalID = as.character(Number),
    externalValue = Crop,
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

# matches <- tibble(new = c(unique(data$Crop)),
#                   old = c("cow pea", "maize", "soybean", "millet",
#                           "peanut", "sorghum", "bean", "cassava",
#                           "pigeon pea", "wheat", "millet"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)

# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
