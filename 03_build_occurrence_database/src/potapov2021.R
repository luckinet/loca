# script arguments ----
#
thisDataset <- "Potapov2021"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "rs-294463-v1-citation.ris"))

regDataset(name = thisDataset,
           description = "Spatiotemporally consistent data on global cropland extent is a key to tracking progress toward hunger eradication and sustainable food production1,2. Here, we present an analysis of global cropland area and change for the first two decades of the 21st century derived from satellite data time-series. We estimate 2019 cropland area to be 1,244 Mha with a corresponding total annual net primary production (NPP) of 5.5 Pg C yr-1. From 2003 to 2019, cropland area increased by 9% and crop NPP by 25%, primarily due to agricultural expansion in Africa and South America. Global cropland expansion accelerated over the past two decades, with a near doubling of the annual expansion rate, most notably in Africa. Half of the new cropland area (49%) replaced natural vegetation and tree cover, indicating a conflict with the sustainability goal of protecting terrestrial ecosystems. From 2003 to 2019 global population growth outpaced cropland area expansion, and per capita cropland area decreased by 10%. However, the per capita annual crop NPP increased by 3.5% as a result of intensified agricultural land use. The presented global high-resolution cropland map time-series supports monitoring of sustainable food production at the local, national, and international levels.",
           url = "https://doi.org/10.21203/rs.3.rs-294463/v1",
           download_date = "2022-01-08",
           type = "static",
           licence = "CC BY 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "reference_sample_data.csv"))


# manage ontology ---
#
# harmonise data ----
#
temp <- data %>%
  pivot_longer(cols = c("crop 2003 (0/1)", "crop 2007 (0/1)", "crop 2011 (0/1)",
                        "crop 2015 (0/1)", "crop 2019 (0/1)"),
               names_to = "year", values_to = "cropland") %>%
  mutate(year = str_remove_all(year, "crop "),
         year = str_remove_all(year, " \\(0/1\\)")) %>%
  mutate(
    fid = row_number(),
    type = "point",
    x = `Center X`,
    y = `Center Y`,
    geometry = NA,
    year = as.numeric(year),
    month = NA_real_,
    day = NA_integer_,
    datasetID = thisDataset,
    country = NA_character_,
    irrigated = FALSE,
    area = NA_real_,
    presence = if_else(cropland == 1, TRUE, FALSE),
    externalID = NA_character_,
    externalValue = "AGRICULTURAL AREAS",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "visual interpretation",
    collector = "expert",
    purpose = "validation",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
