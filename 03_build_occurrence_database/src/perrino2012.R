# script arguments ----
#
thisDataset <- "Perrino2012"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "A phytosociological study was conducted in the National Park of Alta Murgia in the Apulia region (Southern Italy) to determine the adverse effects of metal contamination of soils on the distribution of plant communities. The phytosociological analyses have shown a remarkable biodiversity of vegetation on non-contaminated soils, while biodiversity appeared strongly reduced on metal-contaminated soils. The area is naturally covered by a wide steppic grassland dominated by Stipa austroitalica Martinovsky subsp. austroitalica. Brassicaceae such as Sinapis arvensis L. are the dominating species on moderated contaminated soils, whereas spiny species of Asteraceae such as Silybum marianum (L.) Gaertn. and Carduus pycnocephalus L. subsp. pycnocephalus are the dominating vegetation on heavily metal-contaminated soils. The presence of these spontaneous species on contaminated soils suggest their potential for restoration of degraded lands by phytostabilization strategy."
url <- "https://doi.org/10.1594/PANGAEA.789801, https://doi.org/10.1080/15226514.2013.798626"
license <- "CC-BY-3.0"



# reference ----
#
bib <- ris_reader(paste0(thisPath, "Perrino_2012.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2022-02-20",
           type = "static",
           licence = license,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_tsv(file = paste0(thisPath, "Perrino_2012.tab"), skip = 36)

# harmonise data ----
#

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    date = ymd(`Date/Time`),
    country = "Italy",
    irrigated = F,
    area = NA_real_,
    presence = F,
    externalID = `Sample label`,
    externalValue = "Herbaceous associations",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
