# script arguments ----
#
thisDataset <- "Gallagher2017"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- ris_reader(paste0(thisPath, "citation-321084560.ris"))

regDataset(name = thisDataset,
           description = "This data publication contains pre- and post-treatment fuel loading data for 22 prescribed burns (RxBs) and 4 wildfires from 2012-2015 in the New Jersey Pinelands, specifically in Ocean and Burlington Counties. The data include: forest floor loading, shrub loading, forest census data, and canopy fuels via a profiling light detection and ranging (LiDAR) system for both before and after fuel reduction treatments. These data were collected as part of a Joint Fire Science Program project designed to collect landscape-scale fuels data before and after prescribed fires to quantify consumption, collect data for the parameterization and evaluation of computational flow-dynamics models for simulating fire behavior, and synthesize data for the evaluation of fuels treatment effectiveness. Data are available as either a Microsoft Access database file or as individual comma-delimited ASCII text files.",
           url = "https://doi.org/10.2737/RDS-2017-0061",
           download_date = "2022-01-25",
           type = "static",
           licence = "",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#

data <- read_csv(paste0(thisPath, "/Data/CSV/PLOT_SAMPLE_LOC.csv"))


# harmonise data ----
#

temp <- data %>%
  mutate(
    x = LONG,
    y = LAT,
    year ="2014_2015",
    datasetID = thisDataset,
    country = "United States",
    irrigated = FALSE,
    externalID = ID,
    externalValue = "Naturally regenerating forest",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    presence = FALSE,
    area = NA_real_,
    type = "point",
    geometry = NA,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
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
