# script arguments ----
#
thisNation <- "Trinidad and Tobago"

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

  ## faoDatalab ----
  # The table has -Tobago, Trinidad- as two regions. "Tobago" is a gadm geometry, but "Trinidad" is not
  # Thus some commodities have two ObsVar for the production. The table can be normalised on level 1.
  schema_tto_01 <-
    setIDVar(name = "al1", columns = 1) %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "production", unit = "t", columns = 10)

  regTable(nation = "tto",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_tto_01,
           begin = 2012,
           end = 2017,
           archive = "Trinidad & Tobago - Sub-National Level 1.csv",
           archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Trinidad%20%26%20Tobago%20-%20Sub-National%20Level%201.csv",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Ethiopia.pdf",
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
