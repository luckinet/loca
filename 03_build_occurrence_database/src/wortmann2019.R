# script arguments ----
#
thisDataset <- "Wortmann2019"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#

bib <- ris_reader(paste0(thisPath, "10.1007_s10705-018-09968-7-citation.ris"))

regDataset(name = thisDataset,
           description = "Crop production in sub-Saharan Africa has numerous biotic and abiotic constraints, including nutrient deficiencies. Information on crop response to macronutrients is relatively abundant compared with secondary and micronutrients (SMN). Data from 1339 trial replicates of 280 field trials conducted from 2013 to 2016 in 11 countries were analyzed for the diagnosis of SMN deficiencies. The diagnostic data included relative yield response (RYR) and soil and foliar test results. The RYR to application of a combination of Mg, S, Zn, and B (Mg–S–Zn–B) relative to a comparable N–P–K treatment was a >5% increase for 35% of the legume blocks and 60% of the non-legume blocks. The frequencies of soil test Zn, Cu, and B being below their critical level were 28, 2 and 10% for eastern and southern Africa, respectively, and 55, 58 and 89% for western Africa, while low levels for other SMN were less frequent. The frequency of foliar results indicating low availability were 58% for Zn, 16% for S and less for other SMN. The r2 values for relationships between soil test, foliar test and RYR results were <0.035 with little complementarity except for soil test Zn and B with cassava (Manihot esculenta L. Crantz) RYR in Ghana, and foliar Zn with cereal RYR in Uganda. Positive RYR is powerful diagnostic information and indicative of good profit potential for well-targeted and well-specified SMN application. Geo-referenced RYR, soil analysis and foliar analysis results for diagnosis of SMN deficiencies in 11 countries of sub-Saharan Africa were generally not complementary.",
           url = "https://doi.org/10.1007/s10705-018-09968-7",
           type = "static",
           licence = "",
           bibliography = bib,
           download_date = "2021-12-14",
           contact = "see corresponding author",
           disclosed = "yes",
           update = TRUE)


# read dataset ----
#
data <- read_excel(paste0(thisPath, "Tropical Africa Crop Nutrient Diagnosis data set Jan 2019.xlsx"), sheet = 2)


# manage ontology ---
#
matches <- tibble(new = c(unique(data$Crop)),
                  old = c("cow pea", "maize", "soybean", "millet",
                          "peanut", "sorghum", "bean", "cassava",
                          "pigeon pea", "wheat", "millet"))


getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)

# harmonise data ----
#

listDate <- str_extract_all(data$Code, "20\\d{2}")
year <- unlist(listDate)
df <- as.data.frame(year)
data <- cbind(data, df)

# mutate
temp <- data %>%
  distinct(Latitude, Longitude, year, Crop, .keep_all = TRUE) %>%
  mutate(
    date = ymd(paste0(year, "-01-01")),
    irrigated = F,
    externalID = as.character(Number),
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    x = Longitude,
    y = Latitude,
    country = Country,
    presence = T,
    type = "point",
    area = NA_real_,
    geometry = NA,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326,
    presence = T,
    area = NA_real_,
    type = "point",
    datasetID = thisDataset,
    externalValue = Crop,
    fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
