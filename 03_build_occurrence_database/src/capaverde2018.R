# script arguments ----
#
thisDataset <- "Capaverde2018"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1744742950.bib"))

regDataset(name = thisDataset,
           description = "The distribution patterns of animal species at local scales have been explained by direct influences of vegetation structure, topography, food distribution, and availability. However, these variables can also interact and operate indirectly on the distribution of species. Here, we examined the direct and indirect effects of food availability (fruits and insects), vegetation clutter, and elevation in structuring phyllostomid bat assemblages in a continuous terra firme forest in Central Amazonia. Bats were captured in 49 plots over 25-km² of continuous forest. We captured 1138 bats belonging to 52 species with 7056 net*hours of effort. Terrain elevation was the strongest predictor of species and guild compositions, and of bat abundance. However, changes in elevation were associated with changes in vegetation clutter, and availability of fruits and insects consumed by bats, which are likely to have had direct effects on bat assemblages. Frugivorous bat composition was more influenced by availability of food-providing plants, while gleaning-animalivore composition was more influenced by the structural complexity of the vegetation. Although probably not causal, terrain elevation may be a reliable predictor of bat-assemblage structure at local scales in other regions. In situations where it is not possible to collect local variables, terrain elevation can substitute other variables, such as vegetation structure, and availability of fruits and insects.",
           url = "https://doi.org/10.1111/btp.12546",
           download_date = "2021-08-11",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Bats_Ducke_data_metadata.xlsx"), sheet = 3)


# harmonise data ----
#
temp <- data %>%
  mutate(
    fid = row_number(),
    x = LONG,
    y = LAT,
    year = "2013_2014",
    datasetID = thisDataset,
    country = "Brazil",
    irrigated = FALSE,
    externalID = as.character(Plots),
    externalValue = "Undisturbed Forest",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    presence = FALSE,
    area = 250*40,
    type = "areal",
    geometry = NA,
    epsg = 4326) %>%
    separate_rows(year, sep = "_") %>%
  mutate(year = ymd(paste0(year, "-01-01"))) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
