# script arguments ----
#
# source(paste0(mdl0301, "src/96_preprocess_usda.R"))
thisNation <- "United States of America"

ds <- c("usda")
gs <- c("gadm", "usda")


# 1. dataseries ----
#
regDataseries(name = "usda",
              description = "US Dept. of Agriculture - National Agricultural Statistics Service",
              homepage = "https://www.nass.usda.gov/Quick_Stats/Lite/index.php",
              version = "2023.12",
              licence_link = "public domain")


# 2. geometries ----
#
regGeometry(al1 = !!thisNation,
            gSeries = gs[2],
            label = list(al2 = "atlas_caps"),
            archive = "StCoGenAll17_WGS84WMAS.zip|StUS17_WGS84WMAS.shp",
            archiveLink = "https://www.nass.usda.gov/Publications/AgCensus/2017/Online_Resources/Ag_Atlas_Maps/mapfiles/StGenAll17_WGS84WMAS.zip",
            downloadDate = ymd("2019-10-10"),
            updateFrequency = "notPlanned")

regGeometry(al1 = !!thisNation,
            gSeries = gs[2],
            label = list(al3 = "atlas_caps"),
            archive = "StCoGenAll17_WGS84WMAS.zip|CoUS17_WGS84WMAS.shp",
            archiveLink = "https://www.nass.usda.gov/Publications/AgCensus/2017/Online_Resources/Ag_Atlas_Maps/mapfiles/StGenAll17_WGS84WMAS.zip",
            downloadDate = ymd("2019-10-10"),
            updateFrequency = "notPlanned")

normGeometry(pattern = gs[2],
             beep = 10)


# 3. tables ----
#
schema_usda <-
  setFormat(na_values = "(D)", thousand = ",") %>%
  setIDVar(name = "al1", columns = .find(pattern = "COUNTRY_NAME", row = 1)) %>%
  setIDVar(name = "al2", columns = .find(pattern = "STATE_NAME", row = 1)) %>%
  setIDVar(name = "al3", columns = .find(pattern = "COUNTY_NAME", row = 1)) %>%
  setIDVar(name = "year", columns = .find(pattern = "YEAR", row = 1))

schema_usda_census <- schema_usda %>%
  setIDVar(name = "methdod", value = "census")

schema_usda_survey <- schema_usda %>%
  setIDVar(name = "methdod", value = "survey")

## crops ----
if(build_crops){

  ### census ----
  schema_usda_census_crops <- schema_usda_census %>%
    setIDVar(name = "crop", columns = .find(pattern = "SHORT_DESC", row = 1)) %>%
    setObsVar(name = "harvested", columns = .find(pattern = "VALUE", row = 1))

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "censusCrops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_usda_census_crops,
           begin = 1997,
           end = 2017,
           archive = "qs.crops_20231026.txt.gz",
           archiveLink = "https://www.nass.usda.gov/datasets/qs.crops_20231103.txt.gz",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### survey ----
  schema_usda_survey_crops <- schema_usda_survey %>%
    setIDVar(name = "crop", columns = .find(pattern = "SHORT_DESC", row = 1)) %>%
    setObsVar(name = "harvested", columns = .find(pattern = "VALUE", row = 1))

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "surveyCrops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_usda_survey_crops,
           begin = 1909,
           end = 2022,
           archive = "qs.crops_20231026.txt.gz",
           archiveLink = "https://www.nass.usda.gov/datasets/qs.crops_20231103.txt.gz",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

  normTable(pattern = paste0("Crops.*", ds[1]),
            ontoMatch = "crop",
            beep = 10)
}

## livestock ----
if(build_livestock){

  ### census ----
  schema_usda_census_livestock <- schema_usda_census %>%
    setIDVar(name = "animal", columns = .find(pattern = "SHORT_DESC", row = 1)) %>%
    setObsVar(name = "headcount", columns = .find(pattern = "VALUE", row = 1))

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "censusLivestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_usda_census_livestock,
           begin = 1997,
           end = 2018,
           archive = "qs.animals_products_20231026.txt.gz",
           archiveLink = "https://www.nass.usda.gov/datasets/qs.animals_products_20231103.txt.gz",
           updateFrequency = "quinquennial",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### survey ----
  schema_usda_survey_livestock <- schema_usda_survey %>%
    setIDVar(name = "animal", columns = .find(pattern = "SHORT_DESC", row = 1)) %>%
    setObsVar(name = "headcount", columns = .find(pattern = "VALUE", row = 1))

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "surveyLivestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_usda_survey_livestock,
           begin = 1919,
           end = 2023,
           archive = "qs.animals_products_20231026.txt.gz",
           archiveLink = "https://www.nass.usda.gov/datasets/qs.animals_products_20231103.txt.gz",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

  normTable(pattern = paste0("Livestock.*", ds[1]),
            ontoMatch = "animal",
            beep = 10)
}

## landuse ----
if(build_landuse){

}
