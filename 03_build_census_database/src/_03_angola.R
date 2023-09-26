# script arguments ----
#
thisNation <- "Angola"

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested

ds <- c("countryStat")
gs <- c("gadm36")


# 1. register dataseries ----
#


# 2. register geometries ----
#


# 3. register census tables ----
#
## crops ----
if(build_crops){

  ### countryStat ----
  schema_ago_00 <-
    setIDVar(name = "al2", columns = 5) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3)

  schema_ago_01 <- schema_ago_00 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "ago",
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2001,
           end = 2014,
           schema = schema_ago_01,
           archive = "007SPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD015&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD015&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_ago_02 <- schema_ago_00 %>%
    setObsVar(name = "planted", unit = "ha", columns = 6)

  regTable(nation = "ago",
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2001,
           end = 2014,
           schema = schema_ago_02,
           archive = "007SPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD016&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD016&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_ago_03 <- schema_ago_00 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "ago",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2001,
           end = 2014,
           schema = schema_ago_03,
           archive = "007SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD010&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "ago",
           subset = "prodAnimalFeed",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2001,
           end = 2009,
           schema = schema_ago_03,
           archive = "007SPD025.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD025&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD025&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_ago_05 <- schema_ago_00 %>%
    setObsVar(name = "production seeds", unit = "t", columns = 6)

  regTable(nation = "ago",
           subset = "prodSeeds",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2001,
           end = 2012,
           schema = schema_ago_05,
           archive = "007SPD020.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD020&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD020&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_ago_06 <- setCluster (id = "al1", left = 1, top = 6) %>%
    setIDVar(name = "al1", value = "Angola") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_ago_07 <- schema_ago_06 %>%
    setObsVar(name = "planted", unit = "ha", columns = 6,
              key = 3, value = "Area sown")%>%
    setObsVar(name = "harvested", unit = "ha", columns = 6,
              key = 3, value = "Area Harvested")

  regTable(nation = "ago",
           level = 1,
           subset = "plantedHarvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ago_07,
           begin = 2002,
           end = 2015,
           archive = "D3S_74775277060499247506914652101975304319.xlsx",
           archiveLink = "http://angola.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_ago_08 <- schema_ago_06 %>%
    setFilter(rows = .find("^(01).*", col = 4)) %>%
    setObsVar(name = "production", unit = "t", columns = 6,
              key = 3, value = "Production quantity") %>%
    setObsVar(name = "production seeds", unit = "t", columns = 6,
              key = 3, value = "Seeds quantity")

  regTable(nation = "ago",
           level = 1,
           subset = "prodAndSeeds",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ago_08,
           begin = 2001,
           end = 2015,
           archive = "D3S_52070384980890289555543361154639173281.xlsx",
           archiveLink = "http://angola.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://angola.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## livestock ----
if(build_livestock){

  ### countryStat ----
  schema_ago_04 <- schema_ago_00 %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "ago",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2005,
           end = 2013,
           schema = schema_ago_04,
           archive = "007SPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD035&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=AGO&ta=007SPD035&tr=-2",
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
          # ontoMatch = "commodity",
          outType = "rds",
          update = updateTables)



