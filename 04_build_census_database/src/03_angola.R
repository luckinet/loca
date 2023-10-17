# script arguments ----
#
# see "97_oldCode.R"
thisNation <- "Angola"

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested

ds <- c("")
gs <- c("")


# 1. register dataseries ----
#
# ! see 02_countryStat.R !
#
# regDataseries(name = ds[],
#               description = "",
#               homepage = "",
#               licence_link = "",
#               licence_path = "",
#               update = updateTables)


# 2. register geometries ----
#
# regGeometry(nation = !!thisNation, # or any other "class = value" combination from the gazetteer
#             gSeries = gs[],
#             level = 2,
#             nameCol = "",
#             archive = "|",
#             archiveLink = "",
#             nextUpdate = "",
#             updateFrequency = "",
#             update = updateTables)


# 3. register census tables ----
#
if(build_crops){
  ## crops ----

}

if(build_livestock){
  ## livestock ----

}

if(build_landuse){
  ## landuse ----

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
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              outType = "gpkg",
#              update = updateTables)

# normGeometry(pattern = gs[],
#              outType = "gpkg",
#              update = updateTables)


# 5. normalise census tables ----
#
## in case the output shall be examined before writing into the DB
# testing <- normTable(nation = thisNation,
#                      update = FALSE,
#                      keepOrig = TRUE)

# normTable(pattern = ds[],
#           ontoMatch = ,
#           outType = "rds",
#           update = updateTables)
