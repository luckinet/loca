# script arguments ----
#
thisNation <- "Bhutan"

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested

ds <- c("countryStat")
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

  ## countryStat ----
  schema_btn_00 <-
    setIDVar(name = "al2", columns = 3) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 5)

  schema_btn_01 <- schema_btn_00 %>%
    setObsVar(name = "harvested", unit = "ha", columns = 6)

  regTable(nation = "btn",
           subset = "harvested",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2000,
           end = 2012,
           schema = schema_btn_01,
           archive = "018SPD015.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BTN&ta=018SPD015&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BTN&ta=018SPD015&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_btn_02 <- schema_btn_00 %>%
    setObsVar(name = "production", unit = "t", columns = 6)

  regTable(nation = "btn",
           subset = "production",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin = 2000,
           end = 2012,
           schema = schema_btn_02,
           archive = "018SPD010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BTN&ta=018SPD010&tr=-2",
           updateFrequency = "daily",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BTN&ta=018SPD010&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

  schema_btn_04 <-
    setIDVar(name = "al1", value = "Bhutan") %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 3) %>%
    setObsVar(name = "planted", unit = "ha", columns = 4)

  regTable(nation = "btn",
           level = 1,
           subset = "planted",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_btn_04,
           begin = 2005,
           end = 2013,
           archive = "018CPD016.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BTN&ta=018CPD016&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BTN&ta=018CPD016&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## livestock ----
if(build_livestock){

  ## countryStat ----
  schema_btn_03 <- schema_btn_00 %>%
    setObsVar(name = "headcount", unit = "n", columns = 6)

  regTable(nation = "btn",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 2,
           begin=  2000,
           end = 2012,
           schema = schema_btn_03,
           archive = "018SPD035.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BTN&ta=018SPD035&tr=-2",
           updateFrequency = "annually",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BTN&ta=018SPD035&tr=-2",
           metadataPath = "unknown",
           update = updateTables,
           overwrite = overwriteTables)

}

## landuse ----
if(build_landuse){

  ## countryStat ----
  schema_btn_05 <-
    setIDVar(name = "al1", value = "Bhutan") %>%
    setIDVar(name = "year", value = "2010") %>%
    setIDVar(name = "commodities", columns = 3) %>%
    setObsVar(name = "area", unit = "ha", factor = 1000, columns = 4)

  regTable(nation = "btn",
           subset = "landUse",
           dSeries = ds[1],
           gSeries = gs[1],
           level = 1,
           begin = 2010,
           end = 2010,
           schema = schema_btn_05,
           archive = "018CLI010.csv",
           archiveLink = "http://countrystat.org/home.aspx?c=BTN&ta=018CLI010&tr=-2",
           updateFrequency = "unknown",
           nextUpdate = "unknown",
           metadataLink = "http://countrystat.org/home.aspx?c=BTN&ta=018CLI010&tr=-2",
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


