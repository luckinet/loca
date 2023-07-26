# script arguments ----
#
thisNation <- "Tanzania"

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
## countrySTAT ----
schema_tza_00 <-
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

# It is unclear what the administrative units in the table bellow represent.
# schema_tza_01 <- schema_tza_00 %>%
#   setObsVar(name = "harvested", unit = "ha", columns = 6)
#
# regTable( nation = "tza",
#          subset = "harvested",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          level = 2,
#          begin = 2008,
#          end = 2012,
#          schema = schema_tza_01,
#          archive = "215SPD115.csv",
#          archiveLink = "http://countrystat.org/home.aspx?c=TZA&ta=215SPD115&tr=-2",
#          updateFrequency = "annually",
#          nextUpdate = "unknown",
#          metadataLink = "http://countrystat.org/home.aspx?c=TZA&ta=215SPD115&tr=-2",
#          metadataPath = "unknown",
#          update = updateTables,
#          overwrite = overwriteTables)


schema_tza_02 <- schema_tza_00 %>%
  setIDVar(name = "al2", columns = 3) %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "tza",
         subset = "prodCereal",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2003,
         end = 2005,
         schema = schema_tza_02,
         archive = "215SPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=TZA&ta=215SPD010&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=TZA&ta=215SPD010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_tza_03 <- schema_tza_00 %>%
  setFilter(rows = .find("Administrative..", col = 3), invert = TRUE) %>%
  setIDVar(name = "al3", columns = 3) %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "tza",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 2003,
         end = 2005,
         schema = schema_tza_03,
         archive = "215SPD110.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=TZA&ta=215SPD110&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=TZA&ta=215SPD110&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_tza_04 <- schema_tza_00 %>%
  setIDVar(name = "al2", columns = 3) %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

regTable(nation = "tza",
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2003,
         end = 2009,
         schema = schema_tza_04,
         archive = "215SPD035.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=TZA&tr=21",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_tza_05 <-
  setIDVar(name = "al1", value = "Tanzania") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 3) %>%
  setObsVar(name = "area", unit = "ha", columns = 4)

regTable(nation = "tza",
         level = 1,
         subset = "landuse",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_tza_05,
         begin = 2000,
         end = 2015,
         archive = "215CLI010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=TZA&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=TZA&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_tza_06 <-
  setIDVar(name = "al1", value = "Tanzania") %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = 4) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 5)

regTable(nation = "tza",
         level = 1,
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_tza_06,
         begin = 1981,
         end = 2012,
         archive = "215IPD015.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=TZA&ta=215IPD015&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=TZA&ta=215IPD015&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_tza_07 <-
  setFilter(rows = .find("Total..", col = 2), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 4) %>%
  setIDVar(name = "year", value = "2008") %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "area", unit = "ha", columns = 5)

regTable(nation = "tza",
         level = 2,
         subset = "landuse",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_tza_07,
         begin = 2008,
         end = 2008,
         archive = "215MLO004.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=TZA&ta=215MLO004&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=TZA&ta=215MLO004&tr=-2",
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
