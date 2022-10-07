# script arguments ----
#
thisDataset <- "Oliva2020"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_s41597-020-00658-0-citation.ris"))

regDataset(name = thisDataset,
           description = "We present the MARAS (Environmental Monitoring of Arid and Semiarid Regions) dataset, which stores vegetation and soil data of 426 rangeland monitoring plots installed throughout Patagonia, a 624.500 km2 area of southern Argentina and Chile. Data for each monitoring plot includes basic climatic and landscape features, photographs, 500 point intercepts for vegetation cover, plant species list and biodiversity indexes, 50-m line-intercept transect for vegetation spatial pattern analysis, land function indexes drawn from 11 measures of soil surface characteristics and laboratory soil analysis (pH, conductivity, organic matter, N and texture). Monitoring plots were installed between 2007 and 2019, and are being reassessed at 5-year intervals (247 have been surveyed twice). The MARAS dataset provides a baseline from which to evaluate the impacts of climate change and changes in land use intensity in Patagonian ecosystems, which collectively constitute one of the world´s largest rangeland areas. This dataset will be of interest to scientists exploring key ecological questions such as biodiversity-ecosystem functioning relationships, plant-soil interactions and climatic controls on ecosystem structure and functioning.",
           url = "https://doi.org/10.1038/s41597-020-00658-0",
           download_date = "2021-01-09",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Maras monitoring plots.xlsx"))


# harmonise data ----
#
chd = substr(data$Lat, 3, 3)[1]
chm = "'"
chs = "\""

data$Lat <- str_replace_all(data$Lat, ",", ".")
data$Long <- str_replace_all(data$Long, ",", ".")

temp <- data %>% mutate(x = as.numeric(char2dms(paste0(data$Long,'W'), chd = chd, chm = chm, chs = chs)),
                        y = as.numeric(char2dms(paste0(data$Lat,'S'), chd = chd, chm = chm, chs = chs)))

temp <- temp %>%
  distinct(x, y, Date, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    geometry = NA,
    date = ymd(Date),
    country = Country,
    irrigated = F,
    area = NA_real_,
    presence = F,
    externalID = NA_character_,
    externalValue = "Permanent grazing",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
