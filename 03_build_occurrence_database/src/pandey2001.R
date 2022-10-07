# script arguments ----
#
thisDataset <- "Pandey2001"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "S1161030101000983.bib"))

regDataset(name = thisDataset,
           description = "Every year, increasing areas of irrigated land are being planted to tropical wheat (Triticum aestivum L.) in the Sahel. However, knowledge on how irrigation and nitrogen (N) supply can be simultaneously manipulated to realize maximum yield potential is limited. A 2 year field study was conducted to determine wheat response to differential seasonal irrigation regimes ranging from 300 to 690 mm applied water and 5 N levels of 0 40, 80, 120 and 160 kg N ha−1. Grain yield and all primary yield components increased linearly in response to irrigation in both seasons. Water use generally increased linearly with increased seasonal irrigation and applied N. A quadratic response in grain yield and kernel number m−2 was observed with increasing N levels in all irrigation regimes both seasons. Grain yield, spikes m−2, kernels spike−1, number of kernels m−2 and kernel weight responses to irrigation were greater at the higher N rates. Spikes m−2 were reduced with water deficit. In both years, the average reduction in number of kernels m−2 at the maximum irrigation deficit was 40.6 and 45% at 0 and 160 kg N ha−1, respectively. Similar reduction occurred in kernels−1 spike, where water deficit decreased this component an average of 21.4 and 31.8% at the lowest and highest N rates, respectively. Water deficit over both years reduced kernel weight by 12 and 19.4% at the lowest and highest N rates. This study showed that optimizing irrigation and N supply in a Sahelian environment can produce economic grain yield, and maximize economic return from wheat production. Nitrogen rate must be matched with the irrigation water available to increase water use efficiency and maximize profits.",
           url = "https://doi.org/10.1016/S1161-0301(01)00098-3",
           download_date = "2021-10-22",
           type = "static",
           licence = NA_character_,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_delim(paste0(thisPath, "Pandey2001.csv"), delim = ";", trim_ws = T)


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)


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
    luckinetID = 546,
    datasetID = thisDataset,
    month = NA_real_,
    day = NA_real_,
    country = "Niger",
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
