# script arguments ----
#
thisDataset <- "Zhang2002"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1007_s00271-002-0059-x-citation.ris")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "Winter wheat and summer maize are the staple crops in the piedmont of Mt. Taihang in the North China Plain. High levels of production depend largely on the use of irrigation. However, irrigation is causing a rapid decline of the groundwater table. To assure sustainable agricultural development in this densely populated region, improvement is needed in farmland water-use efficiency (WUE) to reduce the overall application of irrigation water. This paper investigated two ways to improve WUE, which could be easily implemented by local farmers. One way was to regulate the irrigation scheduling of winter wheat. The other was to utilize straw mulching with winter wheat and maize to reduce soil evaporation. Field experimental results, carried out at Luancheng Station from 1997 to 2000, showed that the common practice of irrigating winter wheat four times each season did not produce as high a yield as three irrigations in a dry year, or one irrigation in a wet year. The latter produced the highest grain production and highest relative WUE. Measurements of evapotranspiration and soil evaporation using a large-scale weighing lysimeter and microlysimeters showed that about 30% of the total evapotranspiration was from soil evaporation. Straw mulching reduced soil evaporation by 40 mm for winter wheat and 43 mm for maize in the 1998/1999 seasons. WUE was improved by over 10%. The combination of these two measures could reduce irrigation applications in the region.",
           url = "https://doi.org/10.1007/s00271-002-0059-x",
           type = "static",
           licence = "",
           bibliography = bib,
           download_date = "2021-12-17",
           contact = "see corresponding author",
           disclosed = "yes",
           update = TRUE)


# read dataset ----
#
data <- read_delim(paste0(thisPath, "Zhang2002.csv"), delim = ";", trim_ws = T)


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)
luckinetID = 282,


# harmonise data ----
#
# transform coordinates
data <- data %>% mutate(
  x = as.numeric(char2dms(paste0(data$long,'E'), chd = 'd', chm = 'm')),
  y = as.numeric(char2dms(paste0(data$lat,'N'), chd = 'd', chm = 'm')))

# mutate and add values
temp <- data %>%
  mutate(
    month = NA_real_,
    day = NA_real_,
    year = year,
    irrigated = NA_real_,
    externalID = ID,
    externalValue = commodities,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field sampling",
    collector = "expert",
    purpose = "study",
    epsg = 4326,
    datasetID = thisDataset,
    externalValue = NA_real_,
    fid = row_number()) %>%
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
