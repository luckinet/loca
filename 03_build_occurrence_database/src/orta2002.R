# script arguments ----
#
thisDataset <- "Orta2002"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1007_BF03543431-citation.ris")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "The yield response of winter wheat to water deficit was measured in the western Turkey during the 1998–1999 and 1999–2000 cropping season. Four wheat genotypes (MV-17, Flamura 85, Saraybosna and Kate-A-1) were grown under five different irrigation treatments varied in amount. The amounts ranged from zero to 100 % of soil water replenishment in 25 % increments. As a result, irrigation significantly increased crop water use and therefore grain yield. When compared with the no irrigation treatment, the average grain yield increased by about 37 %, 48 %, 53 % and 66 % with the application of 25 %, 50 %, 75 % and full crop water requirement Grain yield was linearly related to seasonal ET with a slope of 1.21 kg m-3 for Flamura 85, 1.22 kg m-3 for Saraybosna, 1.39 kg m-3 for Kate-A-1 and 1.69 kg m-3 for MV-17. The yield of MV-17, Flamura 85 and Kate-A-1 were similar to each other and higher than that of Saraybosna. The yield response factor (ky), representing relative yield decrease to relative evapotranspiration deficit, was found as 0.79, 0.74, and 0.56 for Saraybosna, MV-17, and both Flamura 85 and Kate-A-1, respectively.",
           url = "https://doi.org/10.1007/BF03543431",
           download_date = "2022-01-10",
           type = "static",
           licence = NA_character_,
           contact = "ismetbaser@hotmail.com",
           disclosed = "no",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_delim(paste0(thisPath, "Orta2002.csv"), delim = ";", trim_ws = T)


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)


#preprocess

# harmonise data ----
#
chd = substr(data$lat, 3, 3)[1]
chm = substr(data$lat, 6, 6)[1]

# transform coordinates
temp <- data %>%
  mutate(y = as.numeric(char2dms(paste0(data$lat,'N'), chd = chd, chm = chm,)),
         x = as.numeric(char2dms(paste0(data$long,'E'), chd = chd, chm = chm,)))

temp <- temp %>%
  mutate(
    fid = row_number(),
    luckinetID = 282,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    country = "Turkey",
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = commodities,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, year, month, day, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())

# before preparing data for storage, test that all required variables are available
assertNames(x = names(temp),
            must.include = c("datasetID", "fid", "country", "x", "y", "epsg",
                             "year", "month", "day", "irrigated",
                             "externalID", "externalValue", "LC1_orig", "LC2_orig", "LC3_orig",
                             "sample_type", "collector", "purpose"))


# write output ----
#
saveDataset(object = temp, dataset = thisDataset)
