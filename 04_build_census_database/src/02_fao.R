# script arguments ----
#
thisNation <- "global"


# 1. dataseries ----
#
ds <- c("faostat", "frafao")
gs <- c("gadm")

regDataseries(name = ds[1],
              description = "FAO statistical data",
              homepage = "http://www.fao.org/faostat/en/",
              version = "2023.12.13",
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

  ### faostat ----
  schema_faostat2 <-
    setIDVar(name = "al1", columns = 2) %>%
    setIDVar(name = "year", columns = 8) %>%
    setIDVar(name = "method", value = "survey, yearbook [1]") %>%
    setIDVar(name = "crop", columns = 4) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 10,
              key = 6, value = "Area harvested") %>%
    setObsVar(name = "production", unit = "t", columns = 10,
              key = 6, value = "Production") %>%
    setObsVar(name = "yield", unit = "kg/ha", factor = 10, columns = 10,
              key = 6, value = "Yield")

  regTable(label = "al1",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 1961,
           end = 2017,
           schema = schema_faostat2,
           archive = "Production_Crops_E_All_Data_(Normalized).zip|Production_Crops_E_All_Data_(Normalized).csv",
           archiveLink = "http://fenixservices.fao.org/faostat/static/bulkdownloads/Production_Crops_E_All_Data_(Normalized).zip",
           nextUpdate = "asNeeded",
           updateFrequency = "annually",
           metadataLink = "http://www.fao.org/faostat/en/#data/QC/metadata",
           metadataPath = "meta_faostat_2",
           overwrite = TRUE)

  normTable(pattern = paste0("crops.*", ds[1]),
            # query = "al1 == 'Germany'",
            ontoMatch = "crop",
            outType = "csv",
            beep = 10)

}

## livestock ----
if(build_livestock){

  ### faostat ----
  schema_faostat1 <-
    setIDVar(name = "al1", columns = 2) %>%
    setIDVar(name = "year", columns = 8) %>%
    setIDVar(name = "method", value = "survey, yearbook [1]") %>%
    setIDVar(name = "animal", columns = 4) %>%
    setObsVar(name = "headcount", unit = "n", columns = 10)

  regTable(label = "al1",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 1961,
           end = 2017,
           schema = schema_faostat1,
           archive = "Production_Livestock_E_All_Data_(Normalized).zip|Production_Livestock_E_All_Data_(Normalized).csv",
           archiveLink = "http://fenixservices.fao.org/faostat/static/bulkdownloads/Production_Livestock_E_All_Data_(Normalized).zip",
           nextUpdate = "asNeeded",
           updateFrequency = "annually",
           metadataLink = "https://www.fao.org/faostat/en/#data/QCL/metadata",
           metadataPath = "meta_faostat_1",
           overwrite = TRUE)

  normTable(pattern = paste0("livestock.*", ds[1]),
            # query = "al1 == 'Germany'",
            ontoMatch = "animal",
            outType = "csv",
            beep = 10)

}

## landuse ----
if(build_landuse){

  ### faostat ----
  schema_faostat3 <-
    setIDVar(name = "al1", columns = 2) %>%
    setIDVar(name = "year", columns = 8) %>%
    setIDVar(name = "method", value = "survey, yearbook [1]") %>%
    setIDVar(name = "landuse", columns = 4) %>%
    setObsVar(name = "area", unit = "ha", factor = 1000, columns = 10,
              key = 6, value = "Area")

  regTable(label = "al1",
           subset = "landuse",
           dSeries = ds[1],
           gSeries = gs[1],
           begin = 1961,
           end = 2018,
           schema = schema_faostat3,
           archive = "Inputs_LandUse_E_All_Data_(Normalized).zip|Inputs_LandUse_E_All_Data_(Normalized).csv",
           archiveLink = "http://fenixservices.fao.org/faostat/static/bulkdownloads/Inputs_LandUse_E_All_Data_(Normalized).zip",
           nextUpdate = "asNeeded",
           updateFrequency = "annually",
           metadataLink = "http://www.fao.org/faostat/en/#data/QC/metadata",
           metadataPath = "FAOStat_landuse_metadata.xlsx",
           overwrite = TRUE)

  ### frafao ----
  schema_frafao1 <- setCluster(id = "year") %>%
    setIDVar(name = "al1", columns = 1) %>%
    setIDVar(name = "year", columns = 3, rows = 1, split = "\\d+") %>%
    setIDVar(name = "method", value = "survey, yearbook [1]") %>%
    setIDVar(name = "landuse", columns = c(3, 6), rows = 1) %>%
    setObsVar(name = "area", unit = "ha", factor = 1000, columns = c(3, 6))

  regTable(label = "al1",
           dSeries = ds[2],
           gSeries = gs[1],
           begin = 1995,
           end = 1995,
           schema = schema_frafao1,
           archive = "Annex 3_ Data tables.htm",
           archiveLink = "http://www.fao.org/3/w4345e/w4345e0n.htm#TopOfPage",
           nextUpdate = "notPlanned",
           updateFrequency = "noPlanned",
           metadataLink = "http://www.fao.org/3/w4345e/w4345e00.htm",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_frafao2 <- setCluster(id = "landuse", left = 11, top = 4, width = 5) %>%
    setIDVar(name = "al1", columns = 1) %>%
    setIDVar(name = "year", columns = c(11:15), rows = 4) %>%
    setIDVar(name = "method", value = "survey, yearbook [1]") %>%
    setIDVar(name = "landuse", columns = 11, rows = 3) %>%
    setObsVar(name = "area", unit = "ha", factor = 1000, columns = c(11:15))

  regTable(label = "al1",
           subset = "primaryForest",
           dSeries = ds[2],
           gSeries = gs[1],
           begin = 1990,
           end = 2015,
           schema = schema_frafao2,
           archive = "FRA2015.zip|FRA2015_data.xlsx",
           archiveLink = "http://www.fao.org/fileadmin/user_upload/FRA/spreadsheet/FRA_data/FRA2015.zip",
           nextUpdate = "notPlanned",
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
           nextUpdate = "notPlanned",
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
           nextUpdate = "notPlanned",
           updateFrequency = "noPlanned",
           metadataLink = "http://www.fao.org/forest-resources-assessment/past-assessments/fra-2015/en/",
           metadataPath = "unknown",
           overwrite = TRUE)

  normTable(pattern = paste0("landuse.*", ds[1]),
            # query = "al1 == 'Germany'",
            ontoMatch = "landuse",
            beep = 10)

  normTable(pattern = ds[2],
            # query = "al1 == 'Germany'",
            ontoMatch = "landuse",
            outType = "csv",
            beep = 10)

}
