# ----
# title       : build census database - faostat, frafao
# description : this script integrates data of 'FAO statistical data' (http://www.fao.org/faostat/en/), 'Global Forest Resources Assessments' (https://fra-data.fao.org/)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-06-05
# version     : 1.0.0
# status      : validate (luts), done (gpw)
# comment     : -
# ----
# geography   : Global
# spatial     : Nation
# period      : 1961 - 2022
# variables   :
# - land      : hectares_covered
# - crops     : hectares_harvested, tons_produced, kiloPerHectare_yield
# - livestock : number_heads
# - tech      : -
# - social    : -
# sampling    : survey, census
# ----

thisNation <- "global"
# source(paste0(mdl0301, "src/96_preprocess_fao.R"))

ds <- c("faostat", "frafao")
gs <- c("gadm")

# 1. dataseries ----
#
regDataseries(name = ds[1],
              description = "FAO statistical data",
              homepage = "http://www.fao.org/faostat/en/",
              version = "2024.06",
              licence_link = "unknown")

regDataseries(name = ds[2],
              description = "Global Forest Resources Assessments",
              homepage = "https://fra-data.fao.org/",
              version = "2023.12.13",
              licence_link = "unknown")


# 2. geometries ----
#
# based on GADM 3.6


# 3. tables ----
#
## crops ----
if(build_crops){

  ### area harvested ----
  schema_faostat2 <-
    setIDVar(name = "al1", columns = 3) %>%
    setIDVar(name = "year", columns = 10) %>%
    setIDVar(name = "method", value = "survey, yearbook [1]") %>%
    setIDVar(name = "crop", columns = 6) %>%
    setObsVar(name = "hectares_harvested", columns = 12)

  regTable(label = "al1",
           subset = "cropsHarvested",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 1961,
           end = 2022,
           schema = schema_faostat2,
           archive = "Production_Crops_Livestock_E_All_Data_(Normalized).zip|Production_Crops_Livestock_E_All_Data_(Normalized).csv",
           archiveLink = "https://bulks-faostat.fao.org/production/Production_Crops_Livestock_E_All_Data_(Normalized).zip",
           downloadDate = ymd("2024-06-03"),
           updateFrequency = "annually",
           metadataLink = "http://www.fao.org/faostat/en/#data/QC/metadata",
           metadataPath = "meta_faostat_2",
           overwrite = TRUE)

  ### tons produced ----
  schema_faostat2 <-
    setIDVar(name = "al1", columns = 3) %>%
    setIDVar(name = "year", columns = 10) %>%
    setIDVar(name = "method", value = "survey, yearbook [1]") %>%
    setIDVar(name = "crop", columns = 6) %>%
    setObsVar(name = "tons_produced", columns = 12)

  regTable(label = "al1",
           subset = "cropsProduction",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 1961,
           end = 2022,
           schema = schema_faostat2,
           archive = "Production_Crops_Livestock_E_All_Data_(Normalized).zip|Production_Crops_Livestock_E_All_Data_(Normalized).csv",
           archiveLink = "https://bulks-faostat.fao.org/production/Production_Crops_Livestock_E_All_Data_(Normalized).zip",
           downloadDate = ymd("2024-06-03"),
           updateFrequency = "annually",
           metadataLink = "http://www.fao.org/faostat/en/#data/QC/metadata",
           metadataPath = "meta_faostat_2",
           overwrite = TRUE)

  ### kiloPerHectare yield ----
  schema_faostat2 <-
    setIDVar(name = "al1", columns = 3) %>%
    setIDVar(name = "year", columns = 10) %>%
    setIDVar(name = "method", value = "survey, yearbook [1]") %>%
    setIDVar(name = "crop", columns = 6) %>%
    setObsVar(name = "kiloPerHectare_yield", factor = 10, columns = 12)

  regTable(label = "al1",
           subset = "cropsYield",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 1961,
           end = 2022,
           schema = schema_faostat2,
           archive = "Production_Crops_Livestock_E_All_Data_(Normalized).zip|Production_Crops_Livestock_E_All_Data_(Normalized).csv",
           archiveLink = "https://bulks-faostat.fao.org/production/Production_Crops_Livestock_E_All_Data_(Normalized).zip",
           downloadDate = ymd("2024-06-03"),
           updateFrequency = "annually",
           metadataLink = "http://www.fao.org/faostat/en/#data/QC/metadata",
           metadataPath = "meta_faostat_2",
           overwrite = TRUE)

  normTable(pattern = paste0("crops.*", ds[1]),
            ontoMatch = "crop",
            query = "al1 == 'Denmark'",
            beep = 10)

}

## livestock ----
if(build_livestock){

  ### number heads ----
  schema_faostat1 <-
    setIDVar(name = "al1", columns = 3) %>%
    setIDVar(name = "year", columns = 10) %>%
    setIDVar(name = "method", value = "survey, yearbook [1]") %>%
    setIDVar(name = "animal", columns = 6) %>%
    setObsVar(name = "number_heads", columns = 12)

  regTable(label = "al1",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 1961,
           end = 2022,
           schema = schema_faostat1,
           archive = "Production_Crops_Livestock_E_All_Data_(Normalized).zip|Production_Crops_Livestock_E_All_Data_(Normalized).csv",
           archiveLink = "https://bulks-faostat.fao.org/production/Production_Crops_Livestock_E_All_Data_(Normalized).zip",
           downloadDate = ymd("2024-06-03"),
           updateFrequency = "annually",
           metadataLink = "https://www.fao.org/faostat/en/#data/QCL/metadata",
           metadataPath = "meta_faostat_1",
           overwrite = TRUE)

  normTable(pattern = paste0("livestock.*", ds[1]),
            ontoMatch = "animal",
            # query = "al1 == 'Brazil'",
            beep = 10)

}

## landuse ----
if(build_landuse){

  ### faostat ----
  schema_faostat3 <-
    setIDVar(name = "al1", columns = 3) %>%
    setIDVar(name = "year", columns = 9) %>%
    setIDVar(name = "method", value = "survey, yearbook [1]") %>%
    setIDVar(name = "use", columns = 5) %>%
    setObsVar(name = "hectares_covered", factor = 1000, columns = 11,
              key = 7, value = "Area")

  regTable(label = "al1",
           subset = "landuse",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 1961,
           end = 2021,
           schema = schema_faostat3,
           archive = "Inputs_LandUse_E_All_Data_(Normalized).zip|Inputs_LandUse_E_All_Data_(Normalized).csv",
           archiveLink = "http://fenixservices.fao.org/faostat/static/bulkdownloads/Inputs_LandUse_E_All_Data_(Normalized).zip",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "annually",
           metadataLink = "https://www.fao.org/faostat/en/#data/RL/metadata",
           metadataPath = "FAOStat_landuse_metadata.xlsx",
           overwrite = TRUE)

  ### frafao ----
  schema_frafao1 <- setCluster(id = "year") %>%
    setIDVar(name = "al1", columns = 1) %>%
    setIDVar(name = "year", columns = 3, rows = 1, split = "\\d+") %>%
    setIDVar(name = "method", value = "survey, yearbook [1]") %>%
    setIDVar(name = "use", columns = c(3, 6), rows = 1) %>%
    setObsVar(name = "hectares_covered", factor = 1000, columns = c(3, 6))

  regTable(label = "al1",
           dSeries = ds[2],
           gSeries = gs[1],
           begin = 1995,
           end = 1995,
           schema = schema_frafao1,
           archive = "Annex 3_ Data tables.htm",
           archiveLink = "http://www.fao.org/3/w4345e/w4345e0n.htm#TopOfPage",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "noPlanned",
           metadataLink = "http://www.fao.org/3/w4345e/w4345e00.htm",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_frafao2 <- setCluster(id = "use", left = 11, top = 4, width = 5) %>%
    setIDVar(name = "al1", columns = 1) %>%
    setIDVar(name = "year", columns = c(11:15), rows = 4) %>%
    setIDVar(name = "method", value = "survey, yearbook [1]") %>%
    setIDVar(name = "use", columns = 11, rows = 3) %>%
    setObsVar(name = "hectares_covered", factor = 1000, columns = c(11:15))

  regTable(label = "al1",
           subset = "primaryForest",
           dSeries = ds[2],
           gSeries = gs[1],
           begin = 1990,
           end = 2015,
           schema = schema_frafao2,
           archive = "FRA2015.zip|FRA2015_data.xlsx",
           archiveLink = "http://www.fao.org/fileadmin/user_upload/FRA/spreadsheet/FRA_data/FRA2015.zip",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "noPlanned",
           metadataLink = "http://www.fao.org/forest-resources-assessment/past-assessments/fra-2015/en/",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(label = "al1",
           subset = "naturalRegen",
           dSeries = ds[2],
           gSeries = gs[1],
           begin = 1990,
           end = 2015,
           schema = schema_frafao2,
           archive = "FRA2015.zip|FRA2015_data.xlsx",
           archiveLink = "http://www.fao.org/fileadmin/user_upload/FRA/spreadsheet/FRA_data/FRA2015.zip",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "noPlanned",
           metadataLink = "http://www.fao.org/forest-resources-assessment/past-assessments/fra-2015/en/",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(label = "al1",
           subset = "plantedForest",
           dSeries = ds[2],
           gSeries = gs[1],
           begin = 1990,
           end = 2015,
           schema = schema_frafao2,
           archive = "FRA2015.zip|FRA2015_data.xlsx",
           archiveLink = "http://www.fao.org/fileadmin/user_upload/FRA/spreadsheet/FRA_data/FRA2015.zip",
           downloadDate = ymd("2019-10-10"),
           updateFrequency = "noPlanned",
           metadataLink = "http://www.fao.org/forest-resources-assessment/past-assessments/fra-2015/en/",
           metadataPath = "unknown",
           overwrite = TRUE)

  normTable(pattern = paste0("landuse.*", ds[1]),
            ontoMatch = "use",
            query = "al1 == 'Denmark'",
            beep = 10)

  normTable(pattern = ds[2],
            ontoMatch = "use",
            query = "al1 == 'Denmark'",
            beep = 10)

}
