# script arguments ----
#
thisNation <- "Gabon"

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested

ds <- c("countrystat")
gs <- c("gadm36")


# 1. register dataseries ----
#
regDataseries(name = ds[],
              description = "",
              homepage = "",
              licence_link = "",
              licence_path = "",
              update = updateTables)


# 2. register geometries ----
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
  schema_gab_01 <- setCluster(id = "al1", left = 1, top = 4) %>%
    setIDVar(name = "al1", value = "Gabon") %>%
    setIDVar(name = "al3", columns = 7) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "production", unit = "t", columns = 10, factor = 0.001)

  regTable(nation = "gab",
           level = 3,
           subset = "prodBanana",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gab_01,
           begin = 2017,
           end = 2017,
           archive = "D3S_8457400501264228087190576087673488452.xlsx",
           archiveLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://gabon.countrystat.org/search-and-visualize-data/en",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "gab",
           level = 3,
           subset = "prodCassava",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gab_01,
           begin = 2017,
           end = 2017,
           archive = "D3S_65765297683544622395831926883574866218.xlsx",
           archiveLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_gab_03 <-
    setIDVar(name = "al1", value = "Gabon") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3) %>%
    setObsVar(name = "production", unit = "t", columns = 4)

  regTable(nation = "gab",
           level = 1,
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gab_03,
           begin = 1985,
           end = 2005,
           archive = "074CPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GAB&ta=074CPD010&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GAB&ta=074CPD010&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "gab",
           level = 1,
           subset = "prodCashCrops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gab_03,
           begin = 1985,
           end = 2005,
           archive = "089MPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GAB&ta=089MPD010&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GAB&ta=089MPD010&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_gab_04 <- schema_gab_03 %>%
    setIDVar(name = "commodities", columns = 4)

  regTable(nation = "gab",
           level = 1,
           subset = "prodVeggies",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gab_04,
           begin = 1985,
           end = 2005,
           archive = "089MPD011.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=GAB&ta=089MPD011&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=GAB&ta=089MPD011&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## livestock ----
if(build_livestock){

  ### countrystat ----
  schema_gab_02 <- setCluster(id = "al1", left = 1, top = 4) %>%
    setIDVar(name = "al1", value = "Gabon") %>%
    setIDVar(name = "al2", columns = 7) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5) %>%
    setObsVar(name = "headcount", unit = "n", columns = 8)

  regTable(nation = "gab",
           level = 2,
           subset = "livestockSheep",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_gab_02,
           begin = 2016,
           end = 2016,
           archive = "D3S_57648567727655310905327383039455470511.xlsx",
           archiveLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "gab",
           level = 2,
           subset = "livestockCattle",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gab_02,
           begin = 2016,
           end = 2016,
           archive = "D3S_23325858178721846295138541247501227448.xlsx",
           archiveLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  regTable(nation = "gab",
           level = 2,
           subset = "livestockGoats",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_gab_02,
           begin = 2016,
           end = 2016,
           archive = "D3S_69779645070170687227615176335215745700.xlsx",
           archiveLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://gabon.countrystat.org/search-and-visualize-data/en/",
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
