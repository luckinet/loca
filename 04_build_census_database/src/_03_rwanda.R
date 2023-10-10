# script arguments ----
#
thisNation <- "Rwanda"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("countrystat")
gs <- c("gadm36")


# register dataseries ----
#


# register geometries ----
#


# 3. register census tables ----
#
## crops ----
if(build_crops){

  ### countrystat ----
  schema_rwa_01 <-
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "rwa",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 3,
           begin = 2007,
           end = 2009,
           schema = schema_rwa_01,
           archive = "184SPD110.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=RWA&ta=184SPD110&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=RWA&ta=184SPD110&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_rwa_02 <-
    setIDVar(name = "al3", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setIDVar(name = "season", columns = 7) %>%
    setObsVar(name = "harvested", unit = "ha", columns = 8)

  regTable(nation = "rwa",
           level = 3,
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_rwa_02,
           begin = 2007,
           end = 2010,
           archive = "184MIN001.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=RWA&ta=184MIN001&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=RWA&ta=184MIN001&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_rwa_03 <-
    setIDVar(name = "al1", value = "Rwanda") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3)

  schema_rwa_04 <- schema_rwa_03 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 4)

  regTable(nation = "rwa",
           level = 1,
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_rwa_04,
           begin = 2002,
           end = 2013,
           archive = "184CPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=RWA&ta=184CPD015&tr=-2",
           updateFrequency = "daily",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=RWA&ta=184CPD015&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_rwa_05 <- schema_rwa_03 %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "rwa",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_rwa_05,
           begin = 2002,
           end = 2013,
           archive = "184CPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=RWA&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_rwa_06 <- schema_rwa_03 %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "rwa",
           level = 1,
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_rwa_06,
           begin = 2002,
           end = 2013,
           archive = "184CPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=RWA&ta=184CPD016&tr=-2",
           updateFrequency = "daily",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=RWA&ta=184CPD016&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## livestock ----
if(build_livestock){

  ### countrystat ----
  schema_rwa_07 <- schema_rwa_03 %>%
    setObsVar(name = "headcount", unit = "n", columns = 4)

  regTable(nation = "rwa",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_rwa_07,
           begin = 1999,
           end = 2012,
           archive = "184CPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=RWA&ta=184CPD035&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=RWA&ta=184CPD035&tr=-2",
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
