# script arguments ----
#
thisNation <- "Guinea-Bissau"

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


# register census tables ----
#
## countrystat ----
schema_gnb_00 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_gnb_01 <- schema_gnb_00 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6)

regTable(nation = "gnb",
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 1988,
         end = 2011,
         schema = schema_gnb_01,
         archive = "175SPD015.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GNB&ta=175SPD015&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GNB&ta=175SPD015&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_gnb_02 <- schema_gnb_00 %>%
  setObsVar(name = "planted", unit = "ha", columns = 6)

regTable(nation = "gnb",
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 1988,
         end = 2011,
         schema = schema_gnb_02,
         archive = "175SPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GNB&ta=175SPD016&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GNB&ta=175SPD016&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_gnb_03 <- schema_gnb_00 %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "gnb",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 1988,
         end = 2010,
         schema = schema_gnb_03,
         archive = "175SPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GNB&ta=175SPD010&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GNB&ta=175SPD010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_gnb_04 <- schema_gnb_00 %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

regTable(nation = "gnb",
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 1986,
         end = 2011,
         schema = schema_gnb_04,
         archive = "175SPD035.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GNB&ta=175SPD035&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GNB&ta=175SPD035&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_gnb_05 <-
  setIDVar(name = "al1", value = "Guinea-Bissau") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 3)

schema_gnb_06 <- schema_gnb_05 %>%
  setObsVar(name = "planted", unit = "ha", columns = 4)

regTable(nation = "gnb",
         level = 1,
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_gnb_06,
         begin = 1988,
         end = 2011,
         archive = "175CPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD016&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD016&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_gnb_07 <- schema_gnb_05 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 4)

regTable(nation = "gnb",
         level = 1,
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_gnb_07,
         begin = 1988,
         end = 2011,
         archive = "175CPD015.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD015&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD015&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_gnb_08 <- schema_gnb_05 %>%
  setObsVar(name = "production", unit = "t", columns = 4)

regTable(nation = "gnb",
         level = 1,
         subset = "prodAnimalFeed",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_gnb_08,
         begin = 1988,
         end = 2011,
         archive = "175CPD025.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD025&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD025&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_gnb_09 <- schema_gnb_05 %>%
  setObsVar(name = "production", unit = "t", columns = 4)

regTable(nation = "gnb",
         level = 1,
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_gnb_09,
         begin = 1988,
         end = 2013,
         archive = "175CPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD010&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_gnb_10 <- schema_gnb_05 %>%
  setObsVar(name = "headcount", unit = "n", columns = 4)

regTable(nation = "gnb",
         level = 1,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_gnb_10,
         begin = 1986,
         end = 2011,
         archive = "175CPD035.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD035&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GNB&ta=175CPD035&tr=-2",
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
