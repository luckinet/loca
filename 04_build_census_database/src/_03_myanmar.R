# script arguments ----
#
thisNation <- "Myanmar"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("UNODC")
gs <- c("gadm36")


# register dataseries ----
#


# register geometries ----
#


# register census tables ----
#
## UNODC ----
schema_mmr_01 <-
  setFormat(thousand = ",") %>%
  setIDVar(name = "al1", value = "Myanmar") %>%
  setIDVar(name = "year", columns = c(1:17), rows = 1) %>%
  setIDVar(name = "commodities", value = "poppy") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(1:17))

regTable(nation = "mmr",
         level = 1,
         subset = "plantedPoppy",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mmr_01,
         begin = 1990,
         end = 2006,
         archive = "Golden_triangle_2006.pdf|p.77",
         archiveLink = "https://www.unodc.org/pdf/research/Golden_triangle_2006.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mmr_02 <-
  setFormat(thousand = ",") %>%
  setIDVar(name = "al1", value = "Myanmar") %>%
  setIDVar(name = "year", columns = c(1:14), rows = 1) %>%
  setIDVar(name = "commodities", value = "poppy") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(1:14))

regTable(nation = "mmr",
         level = 1,
         subset = "plantedPoppy",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mmr_02,
         begin = 2007,
         end = 2020,
         archive = "Myanmar_Opium_survey_2020.pdf",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Myanmar/Myanmar_Opium_survey_2020.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mmr_03 <-
  setFormat(thousand = ",") %>%
  setFilter(rows = .find("total", col = 1), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", rows = 1, columns = c(2:3)) %>%
  setIDVar(name = "commodities", value = "poppy") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:3), relative = TRUE)

regTable(nation = "mmr",
         level = 2,
         subset = "plantedPoppy",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mmr_03,
         begin = 2019,
         end = 2020,
         archive = "Myanmar_Opium_survey_2020.pdf|p.18",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Myanmar/Myanmar_Opium_survey_2020.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mmr",
         level = 2,
         subset = "plantedPoppy",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mmr_03,
         begin = 2014,
         end = 2015,
         archive = "Southeast_Asia_Opium_Survey_2015_web.pdf|p.40",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/sea/Southeast_Asia_Opium_Survey_2015_web.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mmr",
         level = 2,
         subset = "plantedPoppy",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mmr_03,
         begin = 2012,
         end = 2013,
         archive = "SEA_Opium_Survey_2013_web.pdf|p.54",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/sea/SEA_Opium_Survey_2013_web.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mmr",
         level = 2,
         subset = "plantedPoppy",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mmr_03,
         begin = 2010,
         end = 2011,
         archive = "SouthEastAsia_2011_web.pdf|p.52",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/sea/SouthEastAsia_2011_web.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mmr_04 <- schema_mmr_03 %>%
  setFilter(rows = .find("Total", col = 1), invert = TRUE)

regTable(nation = "mmr",
         level = 2,
         subset = "plantedPoppy",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mmr_04,
         begin = 2017,
         end = 2018,
         archive = "Myanmar_Opium_Survey_2018-web.pdf|p.22",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/Myanmar/Myanmar_Opium_Survey_2018-web.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mmr",
         level = 2,
         subset = "plantedPoppy",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mmr_04,
         begin = 2005,
         end = 2006,
         archive = "Golden_triangle_2006.pdf|p.77",
         archiveLink = "https://www.unodc.org/pdf/research/Golden_triangle_2006.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "mmr",
         level = 2,
         subset = "plantedPoppy",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mmr_04,
         begin = 2004,
         end = 2005,
         archive = "Myanmar_opium-survey-2005.pdf|p.15",
         archiveLink = "https://www.unodc.org/pdf/Myanmar_opium-survey-2005.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_mmr_05 <- schema_mmr_03 %>%
  setFilter(rows = .find("Total", col = 1), invert = TRUE) %>%
  setIDVar(name = "year", rows = 1, columns = c(2:4)) %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:4), relative = TRUE)

regTable(nation = "mmr",
         level = 2,
         subset = "plantedPoppy",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mmr_05,
         begin = 2007,
         end = 2009,
         archive = "SEA_Opium_survey_2009.pdf|p.57",
         archiveLink = "https://www.unodc.org/documents/crop-monitoring/SEA_Opium_survey_2009.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mmr_06 <-
  setFormat(thousand = ",") %>%
  setIDVar(name = "al1", value = "Myanmar") %>%
  setIDVar(name = "year", rows = 1, columns = c(1:14)) %>%
  setIDVar(name = "commodities", value = "poppy") %>%
  setObsVar(name = "production", unit = "t", columns = c(1:14))

regTable(nation = "mmr",
         level = 1,
         subset = "productionPoppy",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mmr_06,
         begin = 1990,
         end = 2003,
         archive = "myanmar_opium_survey_2003.pdf|p.14",
         archiveLink = "https://www.unodc.org/pdf/publications/myanmar_opium_survey_2003.pdf",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mmr_07 <-
  setIDVar(name = "al4", columns = 2) %>%
  setIDVar(name = "year", value = "2003") %>%
  setIDVar(name = "commodities", value = "poppy") %>%
  setObsVar(name = "planted", unit = "ha", columns = 3) %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = 4) %>%
  setObsVar(name = "production", unit = "t", columns = 5)

regTable(nation = "mmr",
         level = 4,
         subset = "plantYieldProdPoppy",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mmr_07,
         begin = 2003,
         end = 2003,
         archive = "myanmar_opium_survey_2003.pdf|p.43-44",
         archiveLink = "https://www.unodc.org/pdf/publications/myanmar_opium_survey_2003.pdf",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanmar",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mmr_08 <- setCluster(id = "al1", left = 1, top = 4) %>%
  setIDVar(name = "al1", value = "Myanmar") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", value = "opium") %>%
  setObsVar(name = "production", unit = "t", columns = 2)

regTable(nation = "mmr",
         level = 1,
         subset = "productionOpium",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mmr_08,
         begin = 1990,
         end = 2015,
         archive = "production_opium_myanmar_lvl1_1990_2015.csv", # can't find the original pdf file containing this data
         archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanma",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mmr_09 <- setCluster(id = "commodities", left = 1, top = 3) %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", rows = 1, columns = c(2:9), relative = TRUE) %>%
  setIDVar(name = "commodities", value = "opium") %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = c(2:9), relative = TRUE)

regTable(nation = "mmr",
         level = 2,
         subset = "yieldOpium",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mmr_09,
         begin = 2005,
         end = 2015,
         archive = "yield_opium_myanmar_lvl2_2005_2011_2015.csv", # can't find the original pdf file containing this data
         archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanma",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_mmr_10 <- setCluster(id = "commodities", left = 1, top = 3) %>%
  setIDVar(name = "al2", columns = 1) %>%
  setIDVar(name = "year", rows = 3, columns = c(2:20)) %>%
  setIDVar(name = "commodities", value = "opium") %>%
  setObsVar(name = "planted", unit = "ha", columns = c(2:20))

regTable(nation = "mmr",
         level = 2,
         subset = "plantedOpium",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_mmr_10,
         begin = 2002,
         end = 2020,
         archive = "cultivation_opium_myanmar_lvl2_2002_2020.csv", # can't find the original pdf file containing this data
         archiveLink = "https://www.unodc.org/unodc/en/crop-monitoring/index.html?tag=Myanma",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "unknown",
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
#
# https://github.com/luckinet/tabshiftr/issues
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

