# script arguments ----
#
thisNation <- "Burkina Faso"

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested

ds <- c("countrySTAT", "faoDatalab")
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
schema_bfa_00 <-
  setIDVar(name = "al2", columns = 5) %>%
  setIDVar(name = "year", columns = 3) %>%
  setIDVar(name = "commodities", columns = 2)

schema_bfa_01 <- schema_bfa_00 %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "bfa",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 1984,
         end = 2011,
         schema = schema_bfa_01,
         archive = "233SPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233SPD010&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233SPD010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_bfa_02 <-
  setIDVar(name = "al3", columns = 5) %>%
  setIDVar(name = "year", columns = 3) %>%
  setIDVar(name = "commodities", columns = 2)

schema_bfa_03 <- schema_bfa_02 %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "bfa",
         subset = "prodCereals",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 1993,
         end = 2012,
         schema = schema_bfa_03,
         archive = "233EPA01.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BFA&tr=21",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "bfa",
         subset = "prodOther",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 1993,
         end = 2012,
         schema = schema_bfa_03,
         archive = "233EPA02.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA02&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA02&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "bfa",
         subset = "prodCash",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 1993,
         end = 2012,
         schema = schema_bfa_03,
         archive = "233EPA03.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA03&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA03&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "bfa",
         subset = "prodVeggies",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 1993,
         end = 2012,
         schema = schema_bfa_03,
         archive = "233EPA04.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA04&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA04&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_bfa_04 <-
  setIDVar(name = "al3", columns = 4) %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = 6) %>%
  setObsVar(name = "production", unit = "t", columns = 7)

regTable(nation = "bfa",
         subset = "prodTreeFruit",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 1993,
         end = 2012,
         schema = schema_bfa_04,
         archive = "233EPA005.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BFA&tr=21",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_bfa_05 <- schema_bfa_00 %>%
  setObsVar(name = "planted", unit = "ha", columns = 6)

regTable(nation = "bfa",
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 1984,
         end = 2011,
         schema = schema_bfa_05,
         archive = "233SPD16.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233SPD16&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233SPD16&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_bfa_06 <-
  setIDVar(name = "al3",columns = 4) %>%
  setIDVar(name = "year",columns = 5) %>%
  setIDVar(name = "commodities", columns = 2) %>%
  setObsVar(name = "planted", unit = "ha", columns = 6)

regTable(nation = "bfa",
         subset = "plantedCereals",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 1993,
         end = 2012,
         schema = schema_bfa_06,
         archive = "233EPA06.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA06&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA06&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "bfa",
         subset = "plantedOther",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 1993,
         end = 2012,
         schema = schema_bfa_06,
         archive = "233EPA07.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA07&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA07&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "bfa",
         subset = "plantedCash",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 1993,
         end = 2012,
         schema = schema_bfa_06,
         archive = "233EPA08.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA08&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA08&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "bfa",
         subset = "plantedVeggies",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 1993,
         end = 2012,
         schema = schema_bfa_06,
         archive = "233EPA09.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA09&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA09&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# the unit is not specified in the metadata. I assume kg/ha, because for example, the values go up to 35 000 for potatoes.
schema_bfa_07 <- schema_bfa_02 %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = 6)

regTable(nation = "bfa",
         subset = "yieldother",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 1993,
         end = 2012,
         schema = schema_bfa_07,
         archive = "233EPA12.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA12&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA12&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "bfa",
         subset = "yieldRoot",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 1993,
         end = 2012,
         schema = schema_bfa_07,
         archive = "233EPA13.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA13&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA13&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "bfa",
         subset = "yieldCash",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 1993,
         end = 2012,
         schema = schema_bfa_07,
         archive = "233EPA14.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA14&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA14&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# following table does not have any values filled in for the ObsVars
regTable(nation = "bfa",
         subset = "yieldFruit",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 1993,
         end = 2012,
         schema = schema_bfa_07,
         archive = "233EPA15.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA15&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BFA&ta=233EPA15&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


## new country STAT ----
schema_bfa_08 <- setCluster (id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Burkina Faso") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_bfa_09 <- schema_bfa_08 %>%
  setFilter(rows = .find("^(01).*", col = 4)) %>%
  setObsVar(name = "production", unit = "t", columns = 6,
            key = 3, value = "Production quantity") %>%
  setObsVar(name = "production seeds", unit = "t", columns = 6,
            key = 3, value = "Seeds quantity")

regTable(nation = "bfa",
         level = 1,
         subset = "prodAndSeeds",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_bfa_09,
         begin = 1984,
         end = 2013,
         archive = "D3S_46481989252513598874824440938653879317.xlsx",
         archiveLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_bfa_10 <- schema_bfa_08 %>%
  setFilter(rows = .find("^(01).*", col = 4)) %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "bfa",
         level = 1,
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_bfa_10,
         begin = 2014,
         end = 2016,
         archive = "D3S_37934833331568832037553091478602125982.xlsx",
         archiveLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_bfa_11 <- schema_bfa_08 %>%
  setObsVar(name = "planted", unit = "ha", columns = 6)

regTable(nation = "bfa",
         level = 1,
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_bfa_11,
         begin = 1984,
         end = 2013,
         archive = "D3S_62980309661879018415558450627323164577.xlsx",
         archiveLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_bfa_12 <- schema_bfa_08 %>%
  setFilter(rows = .find("Live animals", col = 3)) %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

regTable(nation = "bfa",
         level = 1,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_bfa_12,
         begin = 1990,
         end = 2013,
         archive = "D3S_3280676867047913049002268615569497300.xlsx",
         archiveLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_bfa_13 <- setCluster(id = "al1", left = 1, top = 5) %>%
  setFilter(row = .find("Live animals", col = 3)) %>%
  setIDVar(name = "al1", value = "Burkina Faso") %>%
  setIDVar(name = "al2", columns = 5) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 7) %>%
  setObsVar(name = "headcount", unit = "n", columns = 8)

regTable(nation = "bfa",
         level = 2,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_bfa_13,
         begin = 2003,
         end = 2009,
         archive = "D3S_91744175275246691887564531755662702755.xlsx",
         archiveLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://burkinafaso.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


## faoDatalab ----
schema_bfa_14 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = 6) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 10,
            key = 11, value = "Hectares") %>%
  setObsVar(name = "production", unit = "t", columns = 10,
            key = 11, value = "Metric Tonnes")

regTable(nation = "bfa",
         level = 2,
         subset = "productionHarvested",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_bfa_14,
         begin = 1995,
         end = 2018,
         archive = "Burkina Faso - Sub-National Level 1.csv",
         archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Burkina%20Faso%20-%20Sub-National%20Level%201.csv",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Burkina%20Faso.pdf",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_bfa_15 <-
  setIDVar(name = "al3", columns = 3) %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = 6) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 10,
            key = 11, value = "Hectares") %>%
  setObsVar(name = "production", unit = "t", columns = 10,
            key = 11, value = "Metric Tonnes")

regTable(nation = "bfa",
         level = 3,
         subset = "productionHarvested",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_bfa_15,
         begin = 2008,
         end = 2018,
         archive = "Burkina Faso - Sub-National Level 2.csv",
         archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Burkina%20Faso%20-%20Sub-National%20Level%202.csv",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Burkina%20Faso.pdf",
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

