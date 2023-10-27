# script arguments ----
#
thisNation <- "Australia"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("abs")
gs <- c("gadm36")



# 1. register dataseries ----
#
regDataseries(name = ds[1],
              description = "Australia Bureau of Statistics",
              homepage = "https://www.abs.gov.au/",
              licence_link = "https://creativecommons.org/licenses/by/3.0/au/",
              licence_path = "unknown",
              update = updateTables)

https://www.abs.gov.au/statistics/industry/agriculture/agricultural-commodities-australia
https://www.abs.gov.au/statistics/industry/agriculture/land-management-and-farming-australia
https://www.abs.gov.au/statistics/environment/environmental-management/national-land-cover-account
https://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/7125.0Main+Features12006-07?OpenDocument

https://www.abs.gov.au/statistics/industry/agriculture/canola-experimental-regional-estimates-using-new-data-sources-and-methods
https://www.abs.gov.au/statistics/industry/agriculture/sugarcane-experimental-regional-estimates-using-new-data-sources-and-methods

https://www.abs.gov.au/ausstats/abs@.nsf/viewContent?readform&view=productsbyCatalogue&Action=expandwithheader&Num=8&#7.%20Agriculture

https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/ASGS_2021_MAIN_STRUCTURE_GPKG_GDA2020.zip


# 2. register geometries ----
#
# regGeometry(nation = !!thisNation, # or any other "class = value" combination from the gazetteer
#             gSeries = gs[],
#             label = list(al_ = ""),
#             archive = "|",
#             archiveLink = "",
#             nextUpdate = "",
#             updateFrequency = "",
#             update = updateTables,
#             overwrite = overwriteTables)


# 3. register census tables ----
#
## crops ----
if(build_crops){

  ### abs ----
  schema_abs_00 <- setCluster(id = "al1", left = 31, top = 10, height = 17) %>%
    setFormat(thousand = ",") %>%
    setIDVar(name = "al1", value = "Australia") %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", columns = c(31:135), rows = 6) %>%
    setIDVar(name = "commodities", columns = 1, rows = 3, split = ".*(?= for)")

  schema_abs_00_01 <- schema_abs_00 %>%
    setObsVar(name = "harvested", unit = "ha", columns = c(31:135),
              key = 2, value = "ha") %>%
    setObsVar(name = "production", unit = "t", columns = c(31:135),
              key = 2, value = "tonnes")

  # table has data from 1861, but tables with values before 1900 are not accepted.
  regTable(nation = "aus",
           level = 2,
           subset = "harvProdWheat",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_abs_00_01,
           begin = 1900,
           end = 2004,
           archive = "WheatAustraliaRaw.xls",
           archiveLink = "https://www.abs.gov.au/statistics",
           updateFrequency = "yearly",
           nextUpdate = "unknown",
           metadataLink = "https://www.abs.gov.au/statistics",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_abs_00_02 <- schema_abs_00 %>%
    setIDVar(name = "year", columns = c(31:134), rows = 6) %>%
    setObsVar(name = "harvested", unit = "ha", columns = c(31:134),
              key = 2, value = "ha") %>%
    setObsVar(name = "production", unit = "t", columns = c(31:134),
              key = 2, value = "tonnes")

  # table has data from 1861, but tables with values before 1900 are not accepted.
  regTable(nation = "aus",
           level = 2,
           subset = "harvProdOat",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_abs_00_02,
           begin = 1900,
           end = 2003,
           archive = "AUS_historical.xls",
           archiveLink = "https://www.abs.gov.au/statistics",
           updateFrequency = "yearly",
           nextUpdate = "unknown",
           metadataLink = "https://www.abs.gov.au/statistics",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "aus",
           level = 2,
           subset = "harvProdBarley",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_abs_00_02,
           begin = 1900,
           end = 2003,
           archive = "AUS_historical.xls",
           archiveLink = "https://www.abs.gov.au/statistics",
           updateFrequency = "yearly",
           nextUpdate = "unknown",
           metadataLink = "https://www.abs.gov.au/statistics",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "aus",
           level = 2,
           subset = "harvProdMaize",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_abs_00_02,
           begin = 1900,
           end = 2003,
           archive = "AUS_historical.xls",
           archiveLink = "https://www.abs.gov.au/statistics",
           updateFrequency = "yearly",
           nextUpdate = "unknown",
           metadataLink = "https://www.abs.gov.au/statistics",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "aus",
           level = 2,
           subset = "harvProdPotato",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_abs_00_02,
           begin = 1900,
           end = 2003,
           archive = "AUS_historical.xls",
           archiveLink = "https://www.abs.gov.au/statistics",
           updateFrequency = "yearly",
           nextUpdate = "unknown",
           metadataLink = "https://www.abs.gov.au/statistics",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


}

## livestock ----
if(build_livestock){

  ### abs ----
  schema_abs_01 <- setCluster(id = "al1", left = 19, top = 7, height = 10) %>%
    setFilter(rows = .find("Australia", col = 1), invert = TRUE) %>%
    setFormat(thousand = ",") %>%
    setIDVar(name = "al1", value = "Australia") %>%
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", columns = c(19:122), rows = 6) %>%
    setIDVar(name = "commodities", columns = 1, rows = 3, split = ".*(?= no)") %>%
    setObsVar(name = "headcount", unit = "n", columns = c(19:122))

  regTable(nation = "aus",
           level = 2,
           subset = "cattle",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_abs_01,
           begin = 1900,
           end = 2003,
           archive = "AUS_historical.xls",
           archiveLink = "https://www.abs.gov.au/statistics",
           updateFrequency = "yearly",
           nextUpdate = "unknown",
           metadataLink = "https://www.abs.gov.au/statistics",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "aus",
           level = 2,
           subset = "sheep",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_abs_01,
           begin = 1900,
           end = 2003,
           archive = "AUS_historical.xls",
           archiveLink = "https://www.abs.gov.au/statistics",
           updateFrequency = "yearly",
           nextUpdate = "unknown",
           metadataLink = "https://www.abs.gov.au/statistics",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "aus",
           level = 2,
           subset = "pig",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_abs_01,
           begin = 1900,
           end = 2003,
           archive = "AUS_historical.xls",
           archiveLink = "https://www.abs.gov.au/statistics",
           updateFrequency = "yearly",
           nextUpdate = "unknown",
           metadataLink = "https://www.abs.gov.au/statistics",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "aus",
           level = 2,
           subset = "horse",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_abs_01,
           begin = 1900,
           end = 2003,
           archive = "AUS_historical.xls",
           archiveLink = "https://www.abs.gov.au/statistics",
           updateFrequency = "yearly",
           nextUpdate = "unknown",
           metadataLink = "https://www.abs.gov.au/statistics",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## landuse ----
if(build_landuse){

}




#### test schemas

# myRoot <- paste0(dataDir, "censusDB/adb_tables/stage2/")
# myFile <- ""
# schema <-
#
# input <- read_csv(file = paste0(myRoot, myFile),
#                   col_names = FALSE,
#                   col_types = cols(.default = "c"))
#
# validateSchema(schema = schema, input = input)
#
# output <- reorganise(input = input, schema = schema)

#### delete this section after finalising script


# 4. normalise geometries ----
#
# not needed


# 5. normalise census tables ----
#
normTable(pattern = ds[1],
          # ontoMatch = "commodity",
          outType = "rds",
          beep = 10,
          update = updateTables)
