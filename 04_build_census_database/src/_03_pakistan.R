# script arguments ----
#
thisNation <- "Pakistan"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("faoDatalab")
gs <- c("gadm")


# 1. register dataseries ----
#
regDataseries(name = ds[],
              description = "",
              homepage = "",
              licence_link = "",
              licence_path = "",
              update = updateTables)


# 2. register geometries ----
#
regGeometry(nation = !!thisNation, # or any other "class = value" combination from the gazetteer
            gSeries = gs[],
            level = 2,
            nameCol = "",
            archive = "|",
            archiveLink = "",
            nextUpdate = "",
            updateFrequency = "",
            update = updateTables)


# 3. register census tables ----
#
## crops ----
if(build_crops){

  ### faoDatalab ----
  schema_pak_01 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 2) %>%
    setIDVar(name = "commodities", columns = 6) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 10,
              key = 11, value = "Hectares") %>%
    setObsVar(name = "production", unit = "t", columns = 10,
              key = 11, value = "Metric Tonnes")

  regTable(nation = "pak",
           level = 2,
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_pak_01,
           begin = 1947,
           end = 2017,
           archive = "Pakistan - Sub-National Level 1.csv",
           archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Pakistan%20-%20Sub-National%20Level%201.csv",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Pakistan.pdf",
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
