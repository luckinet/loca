# script arguments ----
#
# source(paste0(mdl0301, "src/96_preprocess_nzstat.R"))
thisNation <- "New Zealand"

ds <- c("nzstat")
gs <- c("gadm36", "nzgis")


# 1. register dataseries ----
#

regDataseries(name = ds[1],
              description = "Stats NZ",
              homepage = "",
              licence_link = "unknown",
              licence_path = "not available")

regDataseries(name = gs[2],
              description = "Stats NZ",
              homepage = "https://datafinder.stats.govt.nz",
              licence_link = "unknown",
              licence_path = "not available")


# 2. register geometries ----
#
# nzgis ----
# When I want to register the goemtery I have to name the file in stage 2:
# 'c("cok", "nzl", "niu", "tkl")_2__nzgis.gpkg'
regGeometry(gSeries = gs[2],
            level = 3,
            nameCol = "TA2019_V_1",
            archive = "newZealand.zip|territorial-authority-2019-generalised.shp",
            archiveLink = "https://datafinder.stats.govt.nz/layer/98755-territorial-authority-2019-generalised/",
            nextUpdate = "unknown",
            updateFrequency = "notPlanned",
            overwrite = TRUE)

regGeometry(gSeries = gs[2],
            level = 2,
            nameCol = "REGC2019_1",
            archive = "newZealand.zip|regional-council-2019-generalised.shp",
            archiveLink = "https://datafinder.stats.govt.nz/layer/98763-regional-council-2019-generalised/",
            nextUpdate = "unknown",
            updateFrequency = "notPlanned",
            overwrite = TRUE)


# 3. register census tables ----
#
schema_nzstat_00 <- setCluster(id = "al1", left = 2, top = 3, height = 85) %>%
  setFormat(na_values = "..") %>%
  setIDVar(name = "al1", value = "New Zealand") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = c(2:6), rows = 3)

## crops ----
if(build_crops){

  ### nzstat ----
  schema_nzstat_03 <- schema_nzstat_00 %>%
    setIDVar(name = "commodities", columns = c(15:19), rows = 3, split = "(?<=: ).*") %>%
    setObsVar(name = "planted", unit = "ha", columns = c(15:19))

  regTable(nation = "nzl",
           level = 1,
           subset= "plantedCrops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_nzstat_03,
           begin = 1935,
           end = 2018,
           archive = "newZealand2.zip|admin1.1935-2018.allcropsandgrzing.csv",
           archiveLink = "http://archive.stats.govt.nz/infoshare/",
           updateFrequency = "not planned",
           nextUpdate = "unknown",
           metadataLink = "http://archive.stats.govt.nz/infoshare/Help/further-help.asp#gloss",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_nzstat_04 <- schema_nzstat_00 %>%
    setIDVar(name = "commodities", columns = c(20:24), rows = 3, split = "(?<=: ).*") %>%
    setObsVar(name = "production", unit = "t", columns = c(20:24))

  regTable(nation = "nzl",
           level = 1,
           subset= "productionCrops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_nzstat_04,
           begin = 1935,
           end = 2018,
           archive = "newZealand2.zip|admin1.1935-2018.allcropsandgrzing.csv",
           archiveLink = "http://archive.stats.govt.nz/infoshare/",
           updateFrequency = "not planned",
           nextUpdate = "unknown",
           metadataLink = "http://archive.stats.govt.nz/infoshare/Help/further-help.asp#gloss",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_nzstat_05 <- schema_nzstat_00 %>%
    setIDVar(name = "commodities", columns = c(14, 25:37, 39:42, 46:68, 77:106), rows = 3) %>%
    setObsVar(name = "harvested", unit = "ha", columns = c(14, 25:37, 39:42, 46:68, 77:106))

  regTable(nation = "nzl",
           level = 1,
           subset= "harvestedCrops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_nzstat_05,
           begin = 1935,
           end = 2018,
           archive = "newZealand2.zip|admin1.1935-2018.allcropsandgrzing.csv",
           archiveLink = "http://archive.stats.govt.nz/infoshare/",
           updateFrequency = "not planned",
           nextUpdate = "unknown",
           metadataLink = "http://archive.stats.govt.nz/infoshare/Help/further-help.asp#gloss",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_nzstat_06 <- schema_nzstat_00 %>%
    setIDVar(name = "commodities", columns = c(38, 69:76), rows = 3) %>%
    setObsVar(name = "harvested", unit = "ha", columns = c(38, 69:76))

  regTable(nation = "nzl",
           level = 1,
           subset= "harvestedCrops02",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_nzstat_06,
           begin = 1935,
           end = 2018,
           archive = "newZealand2.zip|admin1.1935-2018.allcropsandgrzing.csv",
           archiveLink = "http://archive.stats.govt.nz/infoshare/",
           updateFrequency = "not planned",
           nextUpdate = "unknown",
           metadataLink = "http://archive.stats.govt.nz/infoshare/Help/further-help.asp#gloss",
           metadataPath = "unknown",
           overwrite = TRUE)

}

## livestock ----
if(build_livestock){

  ### nzstat ----
  schema_nzstat_02 <- schema_nzstat_00 %>%
    setIDVar(name = "commodities", columns = c(7:13, 43:45), rows = 3) %>%
    setObsVar(name = "headcount", unit = "n", columns = c(7:13, 43:45))

  regTable(nation = "nzl",
           level = 1,
           subset= "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_nzstat_02,
           begin = 1935,
           end = 2018,
           archive = "newZealand2.zip|admin1.1935-2018.allcropsandgrzing.csv",
           archiveLink = "http://archive.stats.govt.nz/infoshare/",
           updateFrequency = "not planned",
           nextUpdate = "unknown",
           metadataLink = "http://archive.stats.govt.nz/infoshare/Help/further-help.asp#gloss",
           metadataPath = "unknown",
           overwrite = TRUE)

  # Schema with two clusters is working, however there are two extra lines with NA, from the first cluster.
  # Seems like the height does not work correctly.
  schema_nzstat_07 <- setCluster(id = "al1", left = c(1, 6), top = 7, height = c(37, 39)) %>%
    setFormat(thousand = ",") %>%
    setIDVar(name = "al1", value = "New Zealand") %>%
    setIDVar(name = "year", columns = c(1, 6)) %>%
    setIDVar(name = "commodities", value = "forest area") %>%
    setObsVar(name = "area", unit = "ha", factor = 1000, columns = c(4, 9))

  regTable(nation = "nzl",
           level = 1,
           subset= "plantedForest",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_nzstat_07,
           begin = 1921,
           end = 2018,
           archive = "newZealand2.zip|forest_all.csv",
           archiveLink = "http://archive.stats.govt.nz/infoshare/",
           updateFrequency = "not planned",
           nextUpdate = "unknown",
           metadataLink = "http://archive.stats.govt.nz/infoshare/Help/further-help.asp#gloss",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_nzstat_08 <- setCluster(id = "al1", left = 1, top = 3, height = 30) %>%
    setIDVar(name = "al1", value = "New Zealand") %>%
    setIDVar(name = "al2", columns = c(2:189), rows = 2) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = c(2:3, 5:9, 12:13, 15:19, 22:23, 25:29, 32:33, 35:39, 42:43, 45:49, 52:53, 55:59, 62:63, 65:69, 72:73, 75:79, 82:83, 85:89, 92:93, 95:99, 102:103, 105:109, 112:113, 115:119, 122:123, 125:129, 132:133, 135:139, 142:143, 145:149, 152:153, 155:159, 162:163, 165:169, 172:173, 175:179, 182:183, 185:189), rows = 3) %>%
    setObsVar(name = "headcount", unit = "n", columns = c(2:3, 5:9, 12:13, 15:19, 22:23, 25:29, 32:33, 35:39, 42:43, 45:49, 52:53, 55:59, 62:63, 65:69, 72:73, 75:79, 82:83, 85:89, 92:93, 95:99, 102:103, 105:109, 112:113, 115:119, 122:123, 125:129, 132:133, 135:139, 142:143, 145:149, 152:153, 155:159, 162:163, 165:169, 172:173, 175:179, 182:183, 185:189))

  regTable(nation = "nzl",
           level = 2,
           subset= "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_nzstat_08,
           begin = 1990,
           end = 2018,
           archive = "newZealand2.zip|grazing.1991-2018.admin2.csv",
           archiveLink = "http://archive.stats.govt.nz/infoshare/",
           updateFrequency = "not planned",
           nextUpdate = "unknown",
           metadataLink = "http://archive.stats.govt.nz/infoshare/Help/further-help.asp#gloss",
           metadataPath = "unknown",
           overwrite = TRUE)

  # need to implenetd here a Filter function for columns! to avoid including total cows variables.
  schema_nzstat_09 <-
    setCluster(id = "al1", left = 1, top = 3, height = 14) %>%
    setIDVar(name = "al1", value = "New Zealand") %>%
    setIDVar(name = "al3", columns = c(2:676), rows = 2) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "commodities", columns = c(2:676), rows = 3) %>%
    # setObsVar(name = "headcount", unit = "n", columns = c(2:3, 5:12, 14:21, 23:30, 32:39, 41:48, 50:57, 59:66, 68:75, 77:84, 86:93, 95:102, 104:111, 113:120, 122:129, 131:138,
    #                                                       140:147, 149:156, 158:165, 167:174, 176:183, 185:192, 194:201, 203:210, 212:219, 221:228, 230:237, 239:246, 248:255,
    #                                                       257:264, 266:273, 275:282, 284:291, 293:300, 302:309, 311:318, 320:327, 329:336, 338:345, 347:354, 356:363, 365:372,
    #                                                       374:381, 383:390, 392:399, 401:408, 410:417, 419:426, 428:435, 437:444, 446:453, 455:462, 464:471, 473:480, 482:489,
    #                                                       491:498, 500:507, 509:516, 518:525, 527:534, 536:543, 545:552, 554:561, 563:570, 572:579, 581:588, 590:597, 599:606,
    #                                                       608:615, 617:624, 626:633, 635:642, 644:651, 653:660, 662:669, 671:676)) %>%
    setObsVar(name = "headcount", unit = "n", columns = .find(by = "Total Cattle", row = 3, invert = TRUE))

  regTable(nation = "nzl",
           level = 3,
           subset= "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_nzstat_08,
           begin = 1990,
           end = 2002,
           archive = "newZealand2.zip|grazing.1991-2018.admin3.csv",
           archiveLink = "http://archive.stats.govt.nz/infoshare/",
           updateFrequency = "not planned",
           nextUpdate = "unknown",
           metadataLink = "http://archive.stats.govt.nz/infoshare/Help/further-help.asp#gloss",
           metadataPath = "unknown",
           overwrite = TRUE)

  # how to apply two different filter into one schema!
  schema_nzstat_10 <-
    setFilter(rows = .find("Total cattle", col = 4), invert = TRUE) %>%
    setFilter(rows = .find("New Zealand", col = 2), invert = TRUE) %>%
    # setFilter(rows = c(.find("Total cattle", col = 4), .find("New Zealand", col = 2)), invert = TRUE)
    setIDVar(name = "al1", value = "New Zealand") %>%
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "year", columns = 3) %>%
    setIDVar(name = "commodities", columns = 4) %>%
    setObsVar(name = "headcount", unit = "n", columns = 5)

  regTable(nation = "nzl",
           level = 2,
           subset= "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_nzstat_10,
           begin = 1971,
           end = 2017,
           archive = "livestock-numbers-19712017.csv",
           archiveLink = "http://archive.stats.govt.nz/infoshare/",
           updateFrequency = "not planned",
           nextUpdate = "unknown",
           metadataLink = "http://archive.stats.govt.nz/infoshare/Help/further-help.asp#gloss",
           metadataPath = "unknown",
           overwrite = TRUE)

  schema_nzstat_11 <-
    setFilter(rows = .find("Total cattle", col = 4), invert = TRUE) %>%
    setFilter(rows = .find("New Zealand", col = 2), invert = TRUE) %>%
    setIDVar(name = "al1", value = "New Zealand") %>%
    setIDVar(name = "al3", columns = 2) %>%
    setIDVar(name = "year", columns = 3) %>%
    setIDVar(name = "commodities", columns = 4) %>%
    setObsVar(name = "headcount", unit = "n", columns = 5)

  regTable(nation = "nzl",
           subset= "livestock",
           dSeries = ds[1],
           gSeries = gs[2],
           schema = schema_nzstat_11,
           begin = 1971,
           end = 2019,
           archive = "livestock-numbers-clean-1971-2019.csv",
           archiveLink = "http://archive.stats.govt.nz/infoshare/",
           updateFrequency = "not planned",
           nextUpdate = "unknown",
           metadataLink = "http://archive.stats.govt.nz/infoshare/Help/further-help.asp#gloss",
           metadataPath = "unknown",
           overwrite = TRUE)

}

## landuse ----
if(build_landuse){

  ### nzstat ----
  schema_nzstat_01 <- schema_nzstat_00 %>%
    setObsVar(name = "area", unit = "ha", columns = c(2:6))

  regTable(nation = "nzl",
           level = 1,
           subset= "landUse",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_nzstat_01,
           begin = 1935,
           end = 2018,
           archive = "newZealand2.zip|admin1.1935-2018.allcropsandgrzing.csv",
           archiveLink = "http://archive.stats.govt.nz/infoshare/",
           updateFrequency = "not planned",
           nextUpdate = "unknown",
           metadataLink = "http://archive.stats.govt.nz/infoshare/Help/further-help.asp#gloss",
           metadataPath = "unknown",
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
