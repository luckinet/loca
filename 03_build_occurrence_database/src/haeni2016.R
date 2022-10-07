# script arguments ----
#
thisDataset <- "Haeni2016"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Haeni_2016a.bib"))

regDataset(name = thisDataset,
           description = "Measurements of tree heights and crown sizes are essential in long-term monitoring of spatially distributed forests to assess the health of forests over time. In Switzerland, in 1994 and 1997, more than 4'500 trees have been recorded in a 8x8 km plot within the Sanasilva Inventory, which comprises the Swiss Level I sites of the International Co-operative Programme on Assessment and Monitoring of Air Pollution Effects on Forests' (ICP Forests). Tree heights and crown sizes were measured for the dominant and co-dominant trees (n = 1,723), resulting in a data set from 171 plots in Switzerland, spreading over a broad range of climatic gradient and forest characteristics (species recorded = 20). Average tree height was 22.1 m, average DBH 34.6 cm and crown diameter 6.5 m. The data set presented here is open to use and shall foster research in allometric equation modelling.",
           url = "https://doi.org/10.1594/PANGAEA.864521",
           download_date = "2021-10-18",
           type = "static",
           licence = "CC-BY-3.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#
data <- read_tsv(file = paste0(thisPath, "Haeni_2016a.tab"), skip = 20)


# harmonise data ----
#
temp <- data %>%
  drop_na(Latitude, Longitude) %>%
  mutate(
    datasetID = thisDataset,
    type = "point",
    geometry = NA,
    x = Longitude,
    y = Latitude,
    geometry = NA,
    year = "1994_1995_1996_1997",
    country = "Switzerland",
    irrigated = F,
    area = NA_real_,
    presence = F,
    externalID = as.character(ID),
    externalValue = "Naturally Regenerating Forest",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring",
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  mutate(
    fid = row_number(),
    date = ymd(paste0(year, "-01-01"))) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")

