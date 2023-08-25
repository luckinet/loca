# script arguments ----
#
thisNation <- "Canada"

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested

ds <- c("statcan")
gs <- c("gadm36")


# 1. register dataseries ----
#
regDataseries(name = ds[1],
              description = "Statistics Canada",
              homepage = "https://www.statcan.gc.ca/eng/start",
              licence_link = "https://www.statcan.gc.ca/eng/reference/licence",
              licence_path = "unknown",
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

}

## livestock ----
if(build_livestock){

}

## landuse ----
if(build_landuse){

}


# statcan -----
# crops-----
schema_can_statcan_00 <-
  setIDVar(name = "al2", columns = 2) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_can_statcan_01 <- schema_can_statcan_00 %>%
  setObsVar(name = "planted", unit = "ha", columns = 12,
            key = 4, value = "Seeded area (hectares)") %>%
  setObsVar(name = "harvested", unit = "ha", columns = 12,
            key = 4, value = "Harvested area (hectares)") %>%
  setObsVar(name = "production", unit = "t", columns = 12,
            key = 4, value = "Production (metric tonnes)") %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = 12,
            key = 4, value = "Average yield (kilograms per hectare)")

regTable(nation = "can",
         level = 2,
         subset = "principalCrops",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_01,
         begin = 1908,
         end = 2021,
         archive = "3210035901_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210035901",
         updateFrequency = "annual",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100359-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100359-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

schema_can_statcan_02 <- schema_can_statcan_00 %>%
  setObsVar(name = "planted", unit = "ha", columns = 12,
            key = 4, value = "Area planted (hectares)") %>%
  setObsVar(name = "harvested", unit = "ha", columns = 12,
            key = 4, value = "Area harvested (hectares)") %>%
  setObsVar(name = "production", unit = "t", columns = 12,
            key = 4, value = "Total production (metric tonnes)") %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = 12,
            key = 4, value = "Average yield per hectare (kilograms)")

regTable(nation = "can",
         level = 2,
         subset = "marketedVegetables",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_02,
         begin = 2002,
         end = 2020,
         archive = "3210036501_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210036501",
         updateFrequency = "annual",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100365-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100365-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

schema_can_statcan_03 <- schema_can_statcan_00 %>%
  setObsVar(name = "planted", unit = "ha", columns = 13,
            key = 4, value = "Cultivated area, total") %>%
  setObsVar(name = "harvested", unit = "ha", columns = 13,
            key = 4, value = "Bearing area") %>%
  setObsVar(name = "production", unit = "t", columns = 13,
            key = 4, value = "Total production")

regTable(nation = "can",
         level = 2,
         subset = "marketedFruits",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_03,
         begin = 2002,
         end = 2020,
         archive = "3210036401_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210036401",
         updateFrequency = "annual",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100364-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100364-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)


# the following potato table is in acres and hundreweight, I apply factor to convert in ha and metric tones
# for production I use 45.36, because the unit is 1) hundreweight=100 pounds; 2) there is a factor in the table of thousands; 3) finally I need to convert pounds to metric tones.
# for yield I convert from "hundreweght/acre" to "kg/ha"
schema_can_statcan_04 <- schema_can_statcan_00 %>%
  setIDVar(name = "commodities", value = "potato") %>%
  setObsVar(name = "planted", unit = "ha", factor = 0.40468564224, columns = 11,
            key = 4, value = "Seeded area, potatoes") %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.40468564224, columns = 11,
            key = 4, value = "Harvested area, potatoes") %>%
  setObsVar(name = "production", unit = "t", factor = 45.359237, columns = 11,
            key = 4, value = "Production, potatoes") %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 125,535, columns = 11,
            key = 4, value = "Average yield, potatoes")

regTable(nation = "can",
         level = 2,
         subset = "potatoes",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_04,
         begin = 1908,
         end = 2021,
         archive = "3210035801_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210035801",
         updateFrequency = "annual",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100358-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100358-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

schema_can_statcan_05 <- schema_can_statcan_00 %>%
  setObsVar(name = "planted", unit = "ha", columns = 13,
            key = 4, value = "Cultivated area") %>%
  setObsVar(name = "harvested", unit = "ha", columns = 13,
            key = 4, value = "Bearing area") %>%
  setObsVar(name = "production", unit = "t", columns = 13,
            key = 4, value = "Total production")

regTable(nation = "can",
         level = 2,
         subset = "organicFruitAndVegetables",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_05,
         begin = 2019,
         end = 2020,
         archive = "3210021201_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210021201",
         updateFrequency = "annual",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100212-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100212-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

# following table has square feet and tones.
# square feet also have a factor thousands in the table, which I also take into consideration with the factor
schema_can_statcan_06 <-
  setFilter(rows = .find("Canada", col = 2)) %>%
  setIDVar(name = "al1", columns = 2) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", value = "mushrooms") %>%
  setObsVar(name = "planted", unit = "ha", factor = 0.009290304, columns = 11,
            key = 4, value = "Area beds, total") %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.009290304, columns = 11,
            key = 4, value = "Area harvested, total") %>%
  setObsVar(name = "production", unit = "t", factor = 0.907185, columns = 11,
            key = 4, value = "Production (fresh and processed), total")

regTable(nation = "can",
         level = 1,
         subset = "mushrooms",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_06,
         begin = 1964,
         end = 2020,
         archive = "3210035601_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210035601",
         updateFrequency = "annual",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100356-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100356-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

schema_can_statcan_07 <- schema_can_statcan_00 %>%
  setIDVar(name = "commodities", value = "flowers") %>%
  setObsVar(name = "planted", unit = "ha", columns = 12)

regTable(nation = "can",
         level = 2,
         subset = "plantedFieldGrownCutFlowers",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_07,
         begin = 2016,
         end = 2020,
         archive = "3210045201_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210045201",
         updateFrequency = "annual",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100452-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100452-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

# units are converted from in kilograms and square meters to metric tonnes and hectares
schema_can_statcan_08 <- schema_can_statcan_00 %>%
  setIDVar(name = "commodities", columns = 4) %>%
  setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = 13,
            key = 5, value = "Area harvested") %>%
  setObsVar(name = "production", unit = "t", factor = 0.001, columns = 13,
            key = 5, value = "Production")

regTable(nation = "can",
         level = 2,
         subset = "greenHouseFruitAndVegetables",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_08,
         begin = 2006,
         end = 2020,
         archive = "3210045601_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210045601",
         updateFrequency = "annual",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100456-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100456-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

# unit is converted from in square meters to hectares
schema_can_statcan_09 <- schema_can_statcan_00 %>%
  setIDVar(name = "commodities", columns = 4) %>%
  setObsVar(name = "planted", unit = "ha", factor = 0.0001, columns = 12)

regTable(nation = "can",
         level = 2,
         subset = "greenHouseAreaAndMushrooms",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_09,
         begin = 1981,
         end = 2016,
         archive = "3210015901_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210015901",
         updateFrequency = "quinquennial",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100159-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100159-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

# some of the following tables are from Census program and have geographical sub-divisions, which are available as a shp in the statcan website.
# however, two Provinces - Yukon and Northwest Territories - do not have these census agricultural sub-divisions
# therefore, the data extracted is only for level of provinces - level 2
schema_can_statcan_10 <- schema_can_statcan_00 %>%
  setIDVar(name = "commodities", value = "christmas tree") %>%
  setObsVar(name = "planted", unit = "ha", columns = 11)

regTable(nation = "can",
         level = 2,
         subset = "plantedChristmasTrees",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_10,
         begin = 2011,
         end = 2016,
         archive = "3210042101_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210042101",
         updateFrequency = "quinquennial",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100421-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100421-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

# unit is converted from in square meters to hectares
schema_can_statcan_11 <- schema_can_statcan_00 %>%
  setIDVar(name = "commodities", columns = 4) %>%
  setObsVar(name = "planted", unit = "ha", factor = 0.0001, columns = 12)

regTable(nation = "can",
         level = 2,
         subset = "greenHouseProductsAndMushrooms",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_11,
         begin = 2011,
         end = 2016,
         archive = "3210042001_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210042001",
         updateFrequency = "quinquennial",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100420-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100420-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

schema_can_statcan_12 <- schema_can_statcan_00 %>%
  setIDVar(name = "commodities", columns = 4) %>%
  setObsVar(name = "planted", unit = "ha", columns = 12)

regTable(nation = "can",
         level = 2,
         subset = "plantedSodAndNurseryProducts",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_12,
         begin = 2011,
         end = 2016,
         archive = "3210041901_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210041901",
         updateFrequency = "quinquennial",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100419-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100419-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "can",
         level = 2,
         subset = "plantedVegetables",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_12,
         begin = 2011,
         end = 2016,
         archive = "3210041801_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210041801",
         updateFrequency = "quinquennial",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100418-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100418-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "can",
         level = 2,
         subset = "plantedFruitsAndNuts",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_12,
         begin = 2011,
         end = 2016,
         archive = "3210041701_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210041701",
         updateFrequency = "quinquennial",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100417-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100417-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "can",
         level = 2,
         subset = "plantedHayAndFieldCrops",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_12,
         begin = 2011,
         end = 2016,
         archive = "3210041601_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210041601",
         updateFrequency = "quinquennial",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100416-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100416-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "can",
         level = 2,
         subset = "plantedNurseryArea",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_12,
         begin = 2007,
         end = 2020,
         archive = "3210002901_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210002901",
         updateFrequency = "annual",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100029-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100029-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "can",
         level = 2,
         subset = "plantedHistoricalDataCrops",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_12,
         begin = 1921,
         end = 2016,
         archive = "3210015401_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210015401",
         updateFrequency = "annual",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100154-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100154-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

# unit is square meters and I added factor to convert to hectares
schema_can_statcan_13 <- schema_can_statcan_00 %>%
  setIDVar(name = "commodities", value = "green house") %>%
  setObsVar(name = "area", unit = "ha", factor = 0.0001, columns = 12)

regTable(nation = "can",
         level = 2,
         subset = "greenHouseTotalArea",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_13,
         begin = 2007,
         end = 2020,
         archive = "3210001801_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210001801",
         updateFrequency = "annual",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100018-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100018-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

# livestock----
# two commodities: bee colonies and gallons of other bees?
# schema_can_statcan_14 <- schema_can_statcan_00 %>%
#   setIDVar(name = "commodities", columns = 4) %>%
#   setObsVar(name = "bee colonies", unit = "n", columns = 12)
#
# regTable(nation = "can",
#          level = 2,
#          subset = "BeesColonies",
#          dSeries = ds[1],
#          gSeries = gs[1],
#          schema = schema_can_statcan_14,
#          begin = 2011,
#          end = 2016,
#          archive = "3210043201_databaseLoadingData.csv",
#          archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210043201",
#          updateFrequency = "quinquennial",
#          nextUpdate = "unknown",
#          metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100432-eng.zip",
#          metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100432-eng.zip",
#          update = updateTables,
#          overwrite = overwriteTables)

schema_can_statcan_15 <- schema_can_statcan_00 %>%
  setIDVar(name = "commodities", columns = 4) %>%
  setObsVar(name = "headcount", unit = "n", columns = 12)

regTable(nation = "can",
         level = 2,
         subset = "otherLivestockCensus",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_15,
         begin = 2011,
         end = 2016,
         archive = "3210042701_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210042701",
         updateFrequency = "quinquennial",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100427-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100427-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "can",
         level = 2,
         subset = "pigsCensus",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_15,
         begin = 2011,
         end = 2016,
         archive = "3210042601_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210042601",
         updateFrequency = "quinquennial",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100426-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100426-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "can",
         level = 2,
         subset = "sheepCensus",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_15,
         begin = 2011,
         end = 2016,
         archive = "3210042501_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210042501",
         updateFrequency = "quinquennial",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100425-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100425-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "can",
         level = 2,
         subset = "cattleCensus",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_15,
         begin = 2011,
         end = 2016,
         archive = "3210042401_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210042401",
         updateFrequency = "quinquennial",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100424-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100424-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "can",
         level = 2,
         subset = "livestockCensusHistorcial",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_15,
         begin = 1921,
         end = 2016,
         archive = "3210015501_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210015501",
         updateFrequency = "quinquennial",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100155-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100155-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

schema_can_statcan_16 <- schema_can_statcan_00 %>%
  setFilter(rows = .find("Ending..", col = 4)) %>%
  setIDVar(name = "commodities", columns = 4) %>%
  setIDVar(name = "season", columns = 5) %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = 12)

regTable(nation = "can",
         level = 2,
         subset = "hogsSupplyDisposition",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_16,
         begin = 2007,
         end = 2021,
         archive = "3210020001_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210020001",
         updateFrequency = "annual",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100200-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100200-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "can",
         level = 2,
         subset = "sheepSupplyDisposition",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_16,
         begin = 2000,
         end = 2021,
         archive = "3210014101_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210014101",
         updateFrequency = "annual",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100141-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100141-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "can",
         level = 2,
         subset = "cattleSupplyDisposition",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_16,
         begin = 2000,
         end = 2021,
         archive = "3210013901_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210013901",
         updateFrequency = "annual",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100139-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100139-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

schema_can_statcan_17 <- schema_can_statcan_00 %>%
  setFilter(rows = .find("At July 1", col = 5)) %>%
  setIDVar(name = "commodities", columns = 4) %>%
  setIDVar(name = "season", columns = 5) %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = 13)

regTable(nation = "can",
         level = 2,
         subset = "cattleTotal",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_17,
         begin = 1931,
         end = 2021,
         archive = "3210013001_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210013001",
         updateFrequency = "annual",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100130-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100130-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

schema_can_statcan_18 <- schema_can_statcan_17 %>%
  setObsVar(name = "headcount", unit = "n", factor = 1000, columns = 12)

regTable(nation = "can",
         level = 2,
         subset = "sheepTotal",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_18,
         begin = 1906,
         end = 2021,
         archive = "3210012901_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210012901",
         updateFrequency = "annual",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100129-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100129-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "can",
         level = 2,
         subset = "hogsTotal",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_18,
         begin = 2008,
         end = 2021,
         archive = "3210016001_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210016001",
         updateFrequency = "annual",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100160-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100160-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)

schema_can_statcan_19 <- schema_can_statcan_00 %>%
  setIDVar(name = "season", columns = 4) %>%
  setObsVar(name = "headcount", unit = "n", columns = 12)

regTable(nation = "can",
         level = 2,
         subset = "minkFoxTotal",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_19,
         begin = 1970,
         end = 2018,
         archive = "3210011601_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210011601",
         updateFrequency = "annual",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100116-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100116-eng.zip",
         update = updateTables,
         overwrite = overwriteTables)


# land use ----
schema_can_statcan_20 <-
  setIDVar(name = "al2", columns = 2) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 4) %>%
  setObsVar(name = "area", unit = "ha", columns = 12)

regTable(nation = "can",
         level = 2,
         subset = "landUseTypes",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_can_statcan_20,
         begin = 2011,
         end = 2016,
         archive = "3210040601_databaseLoadingData.csv",
         archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210040601",
         updateFrequency = "quinquennial",
         nextUpdate = "unknown",
         metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100406-eng.zip",
         metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100406-eng.zip",
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

