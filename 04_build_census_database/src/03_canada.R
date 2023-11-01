# script arguments ----
#
# source(paste0(mdl0301, "src/96_preprocess_statcan.R"))
thisNation <- "Canada"

ds <- c("statcan")
gs <- c("gadm36")


# 1. register dataseries ----
#
regDataseries(name = ds[1],
              description = "Statistics Canada",
              homepage = "https://www.statcan.gc.ca/eng/start",
              licence_link = "https://www.statcan.gc.ca/eng/reference/licence",
              licence_path = "unknown")


# 2. register geometries ----
#
# regGeometry(nation = !!thisNation, # or any other "class = value" combination from the gazetteer
#             gSeries = gs[],
#             label = list(al_ = ""),
#             archive = "|",
#             archiveLink = "",
#             nextUpdate = "",
#             updateFrequency = "",
#             overwrite = TRUE)


# 3. register census tables ----
#
## crops ----
if(build_crops){

  ### statcan -----
  schema_statcan_crops <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", ) %>%
    setObsVar(name = "planted", unit = "ha", )

  # schema_can_statcan_00 <-
  #   setIDVar(name = "al2", columns = 2) %>%
  #   setIDVar(name = "year", columns = 1) %>%
  #   setIDVar(name = "commodities", columns = 5)
  #
  # schema_can_statcan_01 <- schema_can_statcan_00 %>%
  #   setObsVar(name = "planted", unit = "ha", columns = 12,
  #             key = 4, value = "Seeded area (hectares)") %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = 12,
  #             key = 4, value = "Harvested area (hectares)") %>%
  #   setObsVar(name = "production", unit = "t", columns = 12,
  #             key = 4, value = "Production (metric tonnes)") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = 12,
  #             key = 4, value = "Average yield (kilograms per hectare)")
  #
  # schema_can_statcan_02 <- schema_can_statcan_00 %>%
  #   setObsVar(name = "planted", unit = "ha", columns = 12,
  #             key = 4, value = "Area planted (hectares)") %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = 12,
  #             key = 4, value = "Area harvested (hectares)") %>%
  #   setObsVar(name = "production", unit = "t", columns = 12,
  #             key = 4, value = "Total production (metric tonnes)") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", columns = 12,
  #             key = 4, value = "Average yield per hectare (kilograms)")
  #
  # schema_can_statcan_03 <- schema_can_statcan_00 %>%
  #   setObsVar(name = "planted", unit = "ha", columns = 13,
  #             key = 4, value = "Cultivated area, total") %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = 13,
  #             key = 4, value = "Bearing area") %>%
  #   setObsVar(name = "production", unit = "t", columns = 13,
  #             key = 4, value = "Total production")
  #
  # # the following potato table is in acres and hundreweight, I apply factor to
  # # convert in ha and metric tones for production I use 45.36, because the unit
  # # is 1) hundreweight=100 pounds; 2) there is a factor in the table of
  # # thousands; 3) finally I need to convert pounds to metric tones. for yield I
  # # convert from "hundreweght/acre" to "kg/ha"
  # schema_can_statcan_04 <- schema_can_statcan_00 %>%
  #   setIDVar(name = "commodities", value = "potato") %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.40468564224, columns = 11,
  #             key = 4, value = "Seeded area, potatoes") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.40468564224, columns = 11,
  #             key = 4, value = "Harvested area, potatoes") %>%
  #   setObsVar(name = "production", unit = "t", factor = 45.359237, columns = 11,
  #             key = 4, value = "Production, potatoes") %>%
  #   setObsVar(name = "yield", unit = "kg/ha", factor = 125,535, columns = 11,
  #             key = 4, value = "Average yield, potatoes")
  #
  # schema_can_statcan_05 <- schema_can_statcan_00 %>%
  #   setObsVar(name = "planted", unit = "ha", columns = 13,
  #             key = 4, value = "Cultivated area") %>%
  #   setObsVar(name = "harvested", unit = "ha", columns = 13,
  #             key = 4, value = "Bearing area") %>%
  #   setObsVar(name = "production", unit = "t", columns = 13,
  #             key = 4, value = "Total production")
  #
  # # following table has square feet and tones. square feet also have a factor
  # # thousands in the table, which I also take into consideration with the factor
  # schema_can_statcan_06 <-
  #   setFilter(rows = .find("Canada", col = 2)) %>%
  #   setIDVar(name = "al1", columns = 2) %>%
  #   setIDVar(name = "year", columns = 1) %>%
  #   setIDVar(name = "commodities", value = "mushrooms") %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.009290304, columns = 11,
  #             key = 4, value = "Area beds, total") %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.009290304, columns = 11,
  #             key = 4, value = "Area harvested, total") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.907185, columns = 11,
  #             key = 4, value = "Production (fresh and processed), total")
  #
  # schema_can_statcan_07 <- schema_can_statcan_00 %>%
  #   setIDVar(name = "commodities", value = "flowers") %>%
  #   setObsVar(name = "planted", unit = "ha", columns = 12)
  #
  # # units are converted from in kilograms and square meters to metric tonnes and hectares
  # schema_can_statcan_08 <- schema_can_statcan_00 %>%
  #   setIDVar(name = "commodities", columns = 4) %>%
  #   setObsVar(name = "harvested", unit = "ha", factor = 0.0001, columns = 13,
  #             key = 5, value = "Area harvested") %>%
  #   setObsVar(name = "production", unit = "t", factor = 0.001, columns = 13,
  #             key = 5, value = "Production")
  #
  # # unit is converted from in square meters to hectares
  # schema_can_statcan_09 <- schema_can_statcan_00 %>%
  #   setIDVar(name = "commodities", columns = 4) %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.0001, columns = 12)
  #
  # # some of the following tables are from Census program and have geographical
  # # sub-divisions, which are available as a shp in the statcan website. however,
  # # two Provinces - Yukon and Northwest Territories - do not have these census
  # # agricultural sub-divisions therefore, the data extracted is only for level
  # # of provinces - level 2
  # schema_can_statcan_10 <- schema_can_statcan_00 %>%
  #   setIDVar(name = "commodities", value = "christmas tree") %>%
  #   setObsVar(name = "planted", unit = "ha", columns = 11)
  #
  # # unit is converted from in square meters to hectares
  # schema_can_statcan_11 <- schema_can_statcan_00 %>%
  #   setIDVar(name = "commodities", columns = 4) %>%
  #   setObsVar(name = "planted", unit = "ha", factor = 0.0001, columns = 12)
  #
  # schema_can_statcan_12 <- schema_can_statcan_00 %>%
  #   setIDVar(name = "commodities", columns = 4) %>%
  #   setObsVar(name = "planted", unit = "ha", columns = 12)
  #
  # # unit is square meters and I added factor to convert to hectares
  # schema_can_statcan_13 <- schema_can_statcan_00 %>%
  #   setIDVar(name = "commodities", value = "green house") %>%
  #   setObsVar(name = "area", unit = "ha", factor = 0.0001, columns = 12)

  #### principal crops ----
  https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210000201

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
           overwrite = TRUE)

  #### potatoes ----
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
           overwrite = TRUE)

  #### organic fruit and vegetables (maybe exclude?!) ----
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
           overwrite = TRUE)

  #### flowers ----
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
           overwrite = TRUE)

  #### census - selected crops ----
  regTable(nation = !!thisNation,
           label = "al2",
           subset = "censusSelectedCropsHistoric",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 1921,
           end = 2021,
           archive = "32100154.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100154-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100154_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210015401",
           overwrite = TRUE)

  #### sod and nurseries ----
  regTable(nation = "can",
           level = 2,
           subset = "plantedNurseryArea",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_can_statcan_12,
           begin = 2007,
           end = 2022,
           archive = "3210002901_databaseLoadingData.csv",
           archiveLink = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210002901",
           updateFrequency = "annual",
           nextUpdate = "unknown",
           metadataLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100029-eng.zip",
           metadataPath = "I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/canada/statcan/crops/32100029-eng.zip",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "censusSodNurseries",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2011,
           end = 2016,
           archive = "32100419.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100419-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100419_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210041901",
           overwrite = TRUE)

  #### census - christmas trees ----
  # this is part of landuse in 2021
  regTable(nation = !!thisNation,
           label = "al4",
           subset = "censusChristmastrees",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2011,
           end = 2016,
           archive = "32100421.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100421-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100421_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210042101",
           overwrite = TRUE)

  #### census - field crops and hay ----
  regTable(nation = !!thisNation,
           label = "al4",
           subset = "censusFieldCropsHay",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2011,
           end = 2016,
           archive = "32100416.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100416-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100416_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210041601",
           overwrite = TRUE)

  #### fruit ----
  https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210026301

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
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "censusFruit",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2011,
           end = 2016,
           archive = "32100417.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100417-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100417_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210041701",
           overwrite = TRUE)

  #### vegetables ----
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
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "censusVegetables",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2011,
           end = 2016,
           archive = "32100418.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100418-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100418_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210041801",
           overwrite = TRUE)

  #### corn and soybean (gmo) ----
  https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210004201

  #### greenhouse and mushrooms ----
  regTable(nation = !!thisNation,
           label = "al2",
           subset = "surveyGreenhouse",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 1955,
           end = 2022,
           archive = "32100456.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100456-eng.zip",
           updateFrequency = "annual",
           nextUpdate = "unknown",
           metadataLink = "32100456_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210045601",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al2",
           subset = "SurveyMushrooms",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 1964,
           end = 2022,
           archive = "32100356.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100356-eng.zip",
           updateFrequency = "annual",
           nextUpdate = "unknown",
           metadataLink = "32100356_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210035601",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al2",
           subset = "censusGreenhouseMushroomsHistoric",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 1981,
           end = 2021,
           archive = "32100159.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100159-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100159_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210015901",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al2",
           subset = "censusGreenhouseMushrooms",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2011,
           end = 2016,
           archive = "32100420.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100420-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100420_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210042001",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "censusMushrooms",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2021,
           end = 2021,
           archive = "32100361.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100361-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100361_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210036101",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "censusGreenhouse",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2021,
           end = 2021,
           archive = "32100360.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100360-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100360_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210036001",
           overwrite = TRUE)

}

## livestock ----
if(build_livestock){

  ### statcan ----
  schema_statcan_livestock <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "crop", ) %>%
    setObsVar(name = "planted", unit = "ha", )

  # schema_can_statcan_14 <- schema_can_statcan_00 %>%
  #   setIDVar(name = "commodities", columns = 4) %>%
  #   setObsVar(name = "bee colonies", unit = "n", columns = 12)
  #
  # schema_can_statcan_15 <- schema_can_statcan_00 %>%
  #   setIDVar(name = "commodities", columns = 4) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = 12)
  #
  # schema_can_statcan_16 <- schema_can_statcan_00 %>%
  #   setFilter(rows = .find("Ending..", col = 4)) %>%
  #   setIDVar(name = "commodities", columns = 4) %>%
  #   setIDVar(name = "season", columns = 5) %>%
  #   setObsVar(name = "headcount", unit = "n", factor = 1000, columns = 12)
  #
  # schema_can_statcan_17 <- schema_can_statcan_00 %>%
  #   setFilter(rows = .find("At July 1", col = 5)) %>%
  #   setIDVar(name = "commodities", columns = 4) %>%
  #   setIDVar(name = "season", columns = 5) %>%
  #   setObsVar(name = "headcount", unit = "n", factor = 1000, columns = 13)
  #
  # schema_can_statcan_18 <- schema_can_statcan_17 %>%
  #   setObsVar(name = "headcount", unit = "n", factor = 1000, columns = 12)
  #
  # schema_can_statcan_19 <- schema_can_statcan_00 %>%
  #   setIDVar(name = "season", columns = 4) %>%
  #   setObsVar(name = "headcount", unit = "n", columns = 12)

  #### all livestock ----
  regTable(nation = !!thisNation,
           label = "al2",
           subset = "allLivestock",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 1921,
           end = 2021,
           archive = "32100155.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100155-eng.zip",
           updateFrequency = "annual",
           nextUpdate = "unkown",
           metadataPath = "32100155_MetaData.csv",
           metadataLink = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210015501",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "allLivestock",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2011,
           end = 2016,
           archive = "32100427.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100427-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100427_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210042701",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "allLivestock",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2021,
           end = 2021,
           archive = "32100373.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100373-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100373_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210037301",
           overwrite = TRUE)

  #### cattle ----
  regTable(nation = !!thisNation,
           label = "al2",
           subset = "cattle",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 1931,
           end = 2023,
           archive = "32100130.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100130-eng.zip",
           updateFrequency = "annual",
           nextUpdate = "unkown",
           metadataPath = "32100130_MetaData.csv",
           metadataLink = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210013001",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "cattle",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2011,
           end = 2016,
           archive = "32100424.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100424-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100424_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210042401",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "cattle",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2021,
           end = 2021,
           archive = "32100370.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100370-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100370_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210037001",
           overwrite = TRUE)

  #### pigs ----
  regTable(nation = !!thisNation,
           label = "al2",
           subset = "pigs",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2008,
           end = 2023,
           archive = "32100160.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100160-eng.zip",
           updateFrequency = "annual",
           nextUpdate = "unknown",
           metadataPath = "32100160_MetaData.csv",
           metadataLink = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210016001",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "pigs",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2011,
           end = 2016,
           archive = "32100426.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100426-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100426_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210042601",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "pigs",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2021,
           end = 2021,
           archive = "32100372.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100372-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100372_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210037201",
           overwrite = TRUE)

  #### sheep  ----
  regTable(nation = !!thisNation,
           label = "al2",
           subset = "sheep",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 1906,
           end = 2023,
           archive = "32100129.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100129-eng.zip",
           updateFrequency = "annual",
           nextUpdate = "unknown",
           metadataPath = "32100129_MetaData.csv",
           metadataLink = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210012901",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "sheep",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2011,
           end = 2016,
           archive = "32100425.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100425-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100425_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210042501",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "sheep",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2021,
           end = 2021,
           archive = "32100371.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100425-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100371_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210042501",
           overwrite = TRUE)

  #### poultry ----
  regTable(nation = !!thisNation,
           label = "al2",
           subset = "poultry",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 1970,
           end = 2023,
           archive = "32100120.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100120-eng.zip",
           updateFrequency = "annual",
           nextUpdate = "unknown",
           metadataPath = "32100120_MetaData.csv",
           metadataLink = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210012001",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "poultry",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2011,
           end = 2016,
           archive = "32100428.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100428-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100428_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210042801",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "poultry",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2021,
           end = 2021,
           archive = "32100374.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100374-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100374_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210037401",
           overwrite = TRUE)

  #### bees ----
  regTable(nation = !!thisNation,
           label = "al2",
           subset = "",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 1924,
           end = 2022,
           archive = "32100353.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100353-eng.zip",
           updateFrequency = "annual",
           nextUpdate = "unknown",
           metadataPath = "32100353_MetaData.csv",
           metadataLink = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210035301",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "bees",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2011,
           end = 2016,
           archive = "32100432.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100432-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100432_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210043201",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "bees",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2021,
           end = 2021,
           archive = "32100378.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100378-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100378_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210037801",
           overwrite = TRUE)

  #### mink, fox ----
  regTable(nation = !!thisNation,
           label = "al2",
           subset = "minkFox",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 1970,
           end = 2020,
           archive = "32100116.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100116-eng.zip",
           updateFrequency = "annual",
           nextUpdate = "unknown",
           metadataLink = "32100116_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210011601",
           overwrite = TRUE)

}

## landuse ----
if(build_landuse){

  ### statcan ----
  schema_statcan_landuse <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = 4) %>%
    setObsVar(name = "area", unit = "ha", columns = 12)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "landuse",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2011,
           end = 2016,
           archive = "32100406.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100406-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100406_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210040601",
           overwrite = TRUE)

  regTable(nation = !!thisNation,
           label = "al4",
           subset = "landuse",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2021,
           end = 2021,
           archive = "32100249.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100249-eng.zip",
           updateFrequency = "quinquennial",
           nextUpdate = "unknown",
           metadataLink = "32100249_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3210024901",
           overwrite = TRUE)

  #### land under glass ----
  https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210001901

  regTable(nation = !!thisNation,
           label = "al2",
           subset = "greenHouseTotalArea",
           dSeries = ds[1],
           gSeries = gs[],
           schema = ,
           begin = 2007,
           end = 2022,
           archive = "32100018.csv",
           archiveLink = "https://www150.statcan.gc.ca/n1/tbl/csv/32100018-eng.zip",
           updateFrequency = "annual",
           nextUpdate = "unknown",
           metadataLink = "32100018_MetaData.csv",
           metadataPath = "https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3210001801",
           overwrite = TRUE)


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
#              outType = "gpkg")

normGeometry(pattern = gs[],
             outType = "gpkg")


# 5. normalise census tables ----
#
## in case the output shall be examined before writing into the DB
# testing <- normTable(nation = thisNation,
#                      update = FALSE,
#                      keepOrig = TRUE)
#
# only needed if FAO datasets have not been integrated before
# normTable(pattern = "fao",
#           outType = "rds")

normTable(pattern = ds[],
          ontoMatch = "commodity",
          outType = "rds")

