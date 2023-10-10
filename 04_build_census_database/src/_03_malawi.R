# script arguments ----
#
thisNation <- "Malawi"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("countrystat")
gs <- c("gadm36")


# 1. register dataseries ----
#


# 2. register geometries ----
#


# 3. register census tables ----
#
schema_mwi_00 <- setCluster(id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Malawi") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

## crops ----
if(build_crops){

  ### countrystat ----
  schema_mwi_02 <- schema_mwi_00 %>%
    setFilter(rows = .find("^(01..)", col = 4)) %>%
    setObsVar(name = "production", unit = "t", columns = 6,
              key = 3, value = "Production quantity") %>%
    setObsVar(name = "production seeds", unit = "t", columns = 6,
              key = 3, value = "Seeds quantity")

  regTable(nation = "mwi",
           level = 1,
           subset = "prodAndProdSeeds",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mwi_02,
           begin = 1983,
           end = 2016,
           archive = "D3S_36347240044015309795312780492448875425.xlsx",
           archiveLink = "http://malawi.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://malawi.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_mwi_03 <- schema_mwi_00 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "mwi",
           level = 1,
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mwi_03,
           begin = 1983,
           end = 2013,
           archive = "D3S_50384267447891200108277099862048539897.xlsx",
           archiveLink = "http://malawi.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://malawi.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## livestock ----
if(build_livestock){

  ### countrystat ----
  schema_mwi_01 <- schema_mwi_00 %>%
    setFilter(rows = .find("Live..", col = 3)) %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "mwi",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_mwi_01,
           begin = 1975,
           end = 2015,
           archive = "D3S_35222218128324229028659037819008500474.xlsx",
           archiveLink = "http://malawi.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://malawi.countrystat.org/search-and-visualize-data/en/",
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
#
# https://github.com/luckinet/tabshiftr/issues
#### delete this section after finalising script


# 4. normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              outType = "gpkg",
#              update = updateTables)

normGeometry(pattern = gs[],
             outType = "gpkg",
             update = updateTables)


# 5. normalise census tables ----
#
## in case the output shall be examined before writing into the DB
# testing <- normTable(nation = thisNation,
#                      update = FALSE,
#                      keepOrig = TRUE)
#
# only needed if FAO datasets have not been integrated before
# normTable(pattern = "fao",
#           outType = "rds",
#           update = updateTables)

normTable(pattern = ds[],
          ontoMatch = "commodity",
          outType = "rds",
          update = updateTables)
