# script arguments ----
#
thisNation <- "Kenya"

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested

ds <- c("countrystat")
gs <- c("gadm36")


# register dataseries ----
#
regDataseries(name = ds[],
              description = "",
              homepage = "",
              licence_link = "",
              licence_path = "",
              update = updateTables)


# register geometries ----
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

  ### countrystat ----
  schema_ken_00 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_ken_01 <- schema_ken_00 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "ken",
           subset = "harvested",
           dSeries = ds[1],
           gSeries = "agCensus",
           level = 2,
           begin = 2006,
           end = 2008,
           schema = schema_ken_01,
           archive = "114SPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=KEN&ta=114SPD015&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=KEN&ta=114SPD015&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_ken_02 <- schema_ken_00 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "ken",
           subset = "production",
           dSeries = ds[1],
           gSeries = "agCensus",
           level = 2,
           begin = 2006,
           end = 2008,
           schema = schema_ken_02,
           archive = "114SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=KEN&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=KEN&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  schema_ken_03 <- setCluster(id = "al1", left = 1, top = 5) %>%
    setIDVar(name = "al1", value = "Kenya") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_ken_04 <- schema_ken_03 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6,
              key = 3, value = "Area Harvested") %>%
    setObsVar(name = "planted", unit = "ha", columns = 6,
              key = 3, value = "Area sown")

  regTable(nation = "ken",
           subset = "harvestedPlanted",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 1,
           begin = 2001,
           end = 2013,
           schema = schema_ken_04,
           archive = "D3S_62065387851102482797729027739141358167.xlsx",
           archiveLink = "http://kenya.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://kenya.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  schema_ken_05 <- schema_ken_03 %>%
    setFilter(rows = .find("^(01.)", col = 4)) %>%
    setObsVar(name = "production", unit = "t", columns = 6,
              key = 3, value = "Production quantity") %>%
    setObsVar(name = "production seeds", unit = "t", columns = 6,
              key = 3, value = "Seeds quantity")

  regTable(nation = "ken",
           level = 1,
           subset = "prodAndProdSeeds",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ken_05,
           begin = 2001,
           end = 2013,
           archive = "D3S_25597083389488464538871539034222710277.xlsx",
           archiveLink = "http://kenya.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://kenya.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## livestock ----
if(build_livestock){

  ### countrystat ----
  schema_ken_06 <-
    setIDVar(name = "al2", columns = 4) %>%
    setIDVar(name = "al3", columns = 6) %>%
    setIDVar(name = "year", value = "2009") %>%
    setIDVar(name = "commodities", columns = 2) %>%
    setObsVar(name = "headcount", unit = "n", columns = 7)

  regTable(nation = "ken",
           level = 3,
           subset = "livestockCattle",
           dSeries = ds[1],
           gSeries = "agCensus",
           schema = schema_ken_06,
           begin = 2009,
           end = 2009,
           archive = "114AAC020.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=KEN&ta=114AAC020&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=KEN&ta=114AAC020&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)


  schema_ken_07 <-
    setIDVar(name = "al1", value = "Kenya") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3)

  schema_ken_08 <- schema_ken_07 %>%
    setObsVar(name = "headcount", unit = "n", columns = 4)

  regTable(nation = "ken",
           level = 1,
           subset = "livetsock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ken_08,
           begin = 2000,
           end = 2013,
           archive = "114CPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=KEN&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=KEN&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## landuse ----
if(build_landuse){

  ### countrystat ----
  schema_ken_09 <- schema_ken_07 %>%
    setObsVar(name = "area", unit = "ha", factor = 1000, columns = 4)

  regTable(nation = "ken",
           level = 1,
           subset = "landUse",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_ken_09,
           begin = 2007,
           end = 2007,
           archive = "114CLI010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=KEN&ta=114CLI010&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=KEN&ta=114CLI010&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}


# register census tables ----
#


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
