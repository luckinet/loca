# script arguments ----
#
thisNation <- "Republic of Congo"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("cnsee")
gs <- c("gadm36")


# 1. register dataseries ----
#
# ! see 02_countryStat !
#
regDataseries(name = ds[2],
              description = "Centre National de la Statistique et des Etudes Economiques",
              homepage = "http://www.cnsee.org/",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)


# 2. register geometries ----
#


# 3. register census tables ----
#
## crops ----
if(build_crops){

}

## livestock ----
if(build_livestock){

}

## landuse ----
if(build_landuse){

  ### cnsee ----
  schema_cog_04 <- setCluster(id = "al1", left = 5, top = 2) %>%
    setIDVar(name = "al1", value = "Republic of Congo") %>%
    setIDVar(name = "year", columns = c(5:9), rows = 2) %>%
    setIDVar(name = "commodities", value = "forest") %>%
    setObsVar(name = "area", unit = "ha", factor = 1000, columns = c(5:9))

  regTable(nation = "cog",
           level = 1,
           subset = "forest",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_cog_04,
           begin = 2005,
           end = 2009,
           archive = "Annuaire Statistique du Congo 2009.pdf|p.307",
           archiveLink = "http://www.cnsee.org/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://www.cnsee.org/",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

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

