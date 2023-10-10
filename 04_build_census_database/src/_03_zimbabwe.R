# script arguments ----
#
thisNation <- "Zimbabwe"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("faoDatalab")
gs <- c("gadm36")


# 1. register dataseries ----
#


# 2. register geometries ----
#


# 3. register census tables ----
#
## crops ----
if(build_crops){

  ### faoDatalab ----
  schema_zwe_01 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = 7) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 10,
              key = 9, value = "Harvested Area") %>%
    setObsVar(name = "production", unit = "t", columns = 10,
              key = 9, value = "Production")

  regTable(nation = "zwe",
           level = 2,
           subset = "harvestProd",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_zwe_01,
           begin = 2012,
           end = 2015,
           archive = "Zimbabwe - Sub-National Level 1.csv",
           archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Zimbabwe%20-%20Sub-National%20Level%201.csv",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Zimbabwe.pdf",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## livestock ----
if(build_livestock){

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
