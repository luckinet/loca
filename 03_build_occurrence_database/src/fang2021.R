# script arguments ----
#
thisDataset <- "Fang2021"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "dataset939444.bib"))

regDataset(name = thisDataset,
           description = "Field measured structural variables, particularly continuous in-situ data are pivotal for mechanism study and remote sensing validation. Multiple continuous field measurement campains were conducted in northeastern China crop fields: Honghe (2012, 2013, 2019) and Hailun (2016) . The Honghe site (47.65{\textdegree}N, 133.51{\textdegree}E) is covered with large homogeneous paddy rice and the Hailun site (47.41{\textdegree}N, 126.82{\textdegree}E) is planted with maize, sorghum, and soybean. Continuous measurements were made throughout almost the entire growing season, ranging from day of year (DOY) 160 to 280. For each site, five plots were selected. Typically, four elemental sampling units (approximately 15 m$\ast$15 m) were sampled for each plot to reduce random sampling error. Destructive sampling, Digital hemispheric photography (DHP), LAI-2200 canopy analyzer, and AccuPAR meausrements were carried out in the field measurement simultaneously. The green leaf area index (GAI), yellow leaf area index (YAI), and plant area index (PAI, including the area of leaf, stem, and ear) were measured with destructive sampling. The effective leaf area index (LAIeff), leaf area index (LAI), fractional of vegetation cover (FCOVER), and clumping index (CI) were derived from DHP and LAI-2200. Since DHP and LAI-2200 cannot separate the stem from leaf, the LAI obtained from DHP and LAI-2200 can be regarded as the PAI. The fraction of absorbed photosynthetically active radiation (FAPAR) was measured with AccuPAR using the four flux method.  High-resolution LAI reference maps of these sites were also produced from cloud-free HJ-1 (30 m), Landsat 7 ETM+ (30 m), and Sentinel-2A MSI (20 m) images. The HJ-1 images were rectified to the Landsat 7 ETM+ images and were atmospherically corrected and transformed to surface reflectance data. The high-resolution reference LAI was derived from surface reflectance using the look-up table approach based on the ACRM model simulation. The reference LAI shows high consistency with field LAI (R2=0.85, bias=0.22, and RMSE=0.66). The reference LAI mean and standard deviation values within an extent of 3 km $\ast$ 3 km in each site were extracted and provided in the dataset. The dataset is useful for the study of vegetation structural parameters and the validation of remote sensing products.",
           url = "https://doi.org/10.1594/PANGAEA.939444",
           download_date = "2022-01-13",
           type = "static",
           licence = "CC-BY-4.0",
           contact = NA_character_,
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "NECC.xlsx"), n_max = 10, sheet = 2)

# harmonise data ----
#

temp <- data %>%
  mutate(
    year = case_when(
      NAME == "Honghe_A" ~ paste0("2014_2015_2016"),
      NAME == "Honghe_B" ~ paste0("2014_2015_2016"),
      NAME == "Honghe_C" ~ paste0("2014_2015_2016"),
      NAME == "Honghe_D" ~ paste0("2014_2015_2016"),
      NAME == "Honghe_E" ~ paste0("2014_2015_2016"),
      NAME == "Hailun_A" ~ paste0("2016"),
      NAME == "Hailun_B" ~ paste0("2016"),
      NAME == "Hailun_C" ~ paste0("2016"),
      NAME == "Hailun_D" ~ paste0("2016"),
      NAME == "Hailun_E" ~ paste0("2016"))) %>%
  separate_rows(year, sep = "_")

temp <- temp %>%
  mutate(
    fid = row_number(),
    x = Latitude,
    y = Longitude,
    date = ymd(paste0(year, "-01-01")),
    datasetID = thisDataset,
    country = "China",
    irrigated = NA_character_,
    presence = TRUE,
    externalID = `SITE #`,
    type = "areal",
    area = 30,
    geometry = NA,
    externalValue = tolower(`Crop Type`),
    LC1_orig = `Land Cover`,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "validation",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
