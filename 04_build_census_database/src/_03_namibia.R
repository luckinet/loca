# script arguments ----
#
thisNation <- "Namibia"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("countrySTAT")
gs <- c("gadm")


# register dataseries ----
#


# register geometries ----
#


# register census tables ----
#
## countrystat ----
schema_nam_01 <-
  setIDVar(name = "al1", value = "Namibia") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 3) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 4)

regTable(nation = "nam",
         level = 1,
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_nam_01,
         begin = 2002,
         end = 2003,
         archive = "147CPD015.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=NAM&ta=147CPD015&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=NAM&ta=147CPD015&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


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


# normalise geometries ----
#
# only needed if GADM basis has not been built before
# normGeometry(pattern = "gadm",
#              outType = "gpkg",
#              update = updateTables)

normGeometry(pattern = gs[],
             outType = "gpkg",
             update = updateTables)


# normalise census tables ----
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
