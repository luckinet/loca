# script arguments ----
#
thisNation <- "Nigeria"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("countryStat")
gs <- c("gadm36")


# 1. register dataseries ----
#


# 2. register geometries ----
#


# 3. register census tables ----
#
schema_nga_00 <-
  setIDVar(name = "al2", columns = 4) %>%
  setIDVar(name = "year", columns = 5) %>%
  setIDVar(name = "commodities", columns = 2)

## crops ----
if(build_crops){

  ### countrystat ----

  schema_nga_01 <- schema_nga_00 %>%
    setObsVar(name = "planted", unit = "ha", columns = 6)

  regTable(nation = "nga",
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 1995,
           end = 2012,
           schema = schema_nga_01,
           archive = "159SPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=NGA&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_nga_02 <- schema_nga_00 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "nga",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 1995,
           end = 2012,
           schema = schema_nga_02,
           archive = "159SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=NGA&tr=21",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "unknown",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  schema_nga_03 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Nigeria") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_nga_04 <- schema_nga_03 %>%
    setObsVar(name = "planted", unit = "ha", columns = 6,
              key = 3, value = "Area sown") %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6,
              key = 3, value = "Area Harvested")

  regTable(nation = "nga",
           level = 1,
           subset = "plantedHarvested",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_nga_04,
           begin = 1995,
           end = 2017,
           archive = "D3S_18068359945866645835594090130523560210.xlsx",
           archiveLink = "http://nigeria.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://nigeria.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## livestock ----
if(build_livestock){

  ### countrystat ----
  schema_nga_05 <- schema_nga_03 %>%
    setFilter(rows = .find("Live..", col = 3)) %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "nga",
           level = 1,
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_nga_05,
           begin = 2000,
           end = 2010,
           archive = "D3S_36052193455802116654692282592282918066.xlsx",
           archiveLink = "http://nigeria.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://nigeria.countrystat.org/search-and-visualize-data/en/",
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
