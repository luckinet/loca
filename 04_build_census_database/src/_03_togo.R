# script arguments ----
#
thisNation <- "Togo"

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
## crops ----
if(build_crops){

  ### countrystat ----
  schema_tgo_00 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_tgo_01 <- schema_tgo_00 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "tgo",
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2001,
           end = 2010,
           schema = schema_tgo_01,
           archive = "217SPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=TGO&ta=217SPD015&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=TGO&ta=217SPD015&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_tgo_02 <- schema_tgo_00 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "tgo",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2001,
           end = 2011,
           schema = schema_tgo_02,
           archive = "217SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=TGO&ta=217SPD010&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=TGO&ta=217SPD010&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_tgo_03 <-
    setIDVar(name = "al1", value = "Togo") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3)

  schema_tgo_04 <- schema_tgo_03 %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "tgo",
           level = 1,
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_tgo_04,
           begin = 2001,
           end = 2014,
           archive = "217CPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=TGO&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_tgo_05 <- schema_tgo_03 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 4)

  regTable(nation = "tgo",
           level = 1,
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_tgo_05,
           begin = 2001,
           end = 2017,
           archive = "217CPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=TGO&ta=217CPD015&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=TGO&ta=217CPD015&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_tgo_06 <- schema_tgo_03 %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "tgo",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_tgo_06,
           begin = 2001,
           end = 2017,
           archive = "217CPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=TGO&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## livestock ----
if(build_livestock){

  ### countrystat ----
  schema_tgo_07 <- schema_tgo_03 %>%
    setObsVar(name = "headcount", unit = "n", columns = 4)

  regTable(nation = "tgo",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_tgo_07,
           begin = 2000,
           end = 2014,
           archive = "217CPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=TGO&ta=217CPD035&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=TGO&ta=217CPD035&tr=-2",
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


