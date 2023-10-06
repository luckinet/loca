# script arguments ----
#
thisNation <- "Republic of Congo"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("countrySTAT", "cnsee")
gs <- c("gadm36")


# register dataseries ----
#
regDataseries(name = ds[2],
              description = "Centre National de la Statistique et des Etudes Economiques",
              homepage = "http://www.cnsee.org/",
              licence_link = "unknown",
              licence_path = "not available",
              update = updateTables)


# register geometries ----
#


# register census tables ----
#
## countrystat ----
schema_cog_00 <-
  setIDVar(name = "al1", value = "Republic of Congo") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 3)

schema_cog_01 <- schema_cog_00 %>%
  setObsVar(name = "production", unit = "t", columns = 4)

regTable(nation = "cog",
         level = 1,
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_cog_01,
         begin = 2001,
         end = 2010,
         archive = "046CPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=COG&ta=046CPD010&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=COG&ta=046CPD010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_cog_02 <- schema_cog_00 %>%
  setObsVar(name = "planted", unit = "ha", columns = 4)

regTable(nation = "cog",
         level = 1,
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_cog_02,
         begin = 1985,
         end = 1996,
         archive = "046CPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=COG&ta=046CPD016&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=COG&ta=046CPD016&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_cog_03 <- schema_cog_00 %>%
  setObsVar(name = "headcount", unit = "n", columns = 4)

regTable(nation = "cog",
         level = 1,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_cog_03,
         begin = 1988,
         end = 2010,
         archive = "046CPD035.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=COG&ta=046CPD035&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=COG&ta=046CPD035&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

## cnsee ----
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
