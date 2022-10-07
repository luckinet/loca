# script arguments ----
#
thisDataset <- "Ratnam2019"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "10.3389-fevo.2019.00008-citation.bib"))

regDataset(name = thisDataset,
           description = "Two dominant biomes that occur across the southern Indian peninsula are dry deciduous “forests” and evergreen forests, with the former occurring in drier regions and the latter in wetter regions, sometimes in close proximity to each other. Here we compare stem and leaf traits of trees from multiple sites across these biomes to show that dry deciduous “forest” species have, on average, lower height: diameter ratios, lower specific leaf areas, higher wood densities and higher relative bark thickness, than evergreen forest species. These traits are diagnostic of these dry deciduous “forests” as open, well-lit, drought-, and fire-prone habitats where trees are conservative in their growth strategies and invest heavily in protective bark tissue. These tree traits together with the occurrence of a C4 grass-dominated understory, diverse mammalian grazers, and frequent fires indicate that large tracts of dry deciduous “forests” of southern India are more accurately classified as mesic deciduous “savannas.”",
           url = "https://doi.org/10.3389/fevo.2019.00008",
           download_date = "2021-08-18",
           type = "static",
           licence = "",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# pre-process data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#

data <- read_csv(file = paste0(thisPath, "frontiers_ratnam.csv"))


# harmonise data ----
#

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = x,
    y = y,
    geometry = NA,
    date = ymd("2019-01-01"),
    country = country,
    irrigated = F,
    area = NA_real_,
    presence = F,
    externalID = NA_character_,
    externalValue = "Naturally Regenerating Forest",
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
