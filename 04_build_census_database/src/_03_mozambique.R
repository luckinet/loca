# script arguments ----
#
thisNation <- "Mozambique"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("countrystat", "masa")
gs <- c("gadm36", "mozgis")


# 1. register dataseries ----
#
# regDataseries(name = ds[2],
#               description = "Ministério da Agricultura e Segurança Alimentar",
#               homepage = "http://www.masa.gov.mz/",
#               licence_link = "unknown",
#               licence_path = "not available",
#               update = updateTables)
#
# regDataseries(name = gs[2],
#               description = "Programa de Desenvolvimento Espacial",
#               homepage = "https://www.mozgis.gov.mz",
#               licence_link = "unknown",
#               licence_path = "not available",
#               update = updateTables)


# 2. register geometries ----
#
## mozgis ----
# regGeometry(gSeries = gs[2],
#             level = 1,
#             nameCol = "ADM0_EN",
#             archive = "mozambique.zip|moz_admbnda_adm0_ine_20190607.shp",
#             archiveLink = "https://www.mozgis.gov.mz/portal/home/",
#             updateFrequency = "notPlanned",
#             update = updateTables)
#
# regGeometry(gSeries = gs[2],
#             level = 2,
#             nameCol = "ADM0_EN|ADM1_PT",
#             archive = "mozambique.zip|moz_admbnda_adm1_ine_20190607.shp",
#             archiveLink = "https://www.mozgis.gov.mz/portal/home/",
#             updateFrequency = "notPlanned",
#             update = updateTables)
#
# regGeometry(gSeries = gs[2],
#             level = 3,
#             nameCol = "ADM0_EN|ADM1_PT|ADM2_PT",
#             archive = "mozambique.zip|moz_admbnda_adm2_ine_20190607.shp",
#             archiveLink = "https://www.mozgis.gov.mz/portal/home/",
#             updateFrequency = "notPlanned",
#             update = updateTables)


# 3. register census tables ----
#
## countrystat ----
schema_moz_01 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5) %>%
  setObsVar(name = "planted", unit = "ha", columns = 6)

regTable(nation = "moz",
         subset = "plantedCorn",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin =1997,
         end = 2013,
         schema = schema_moz_01,
         archive = "144SPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=MOZ&ta=144SPD016&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=MOZ&ta=144SPD016&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_moz_02 <-
  setIDVar(name = "al2", columns = 5) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 3) %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "moz",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2002,
         end = 2008,
         schema = schema_moz_02,
         archive = "144SPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=MOZ&ta=144SPD010&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=MOZ&ta=144SPD010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_moz_03 <- setCluster(id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Mozambique") %>%
  setIDVar(name = "al2", columns = 5) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 7) %>%
  setObsVar(name = "production", unit = "t", columns = 8)

regTable(nation = "moz",
         subset = "prodTamarind",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2014,
         end = 2018,
         schema = schema_moz_03,
         archive = "D3S_88291338084031042717655195593699838072.xlsx",
         archiveLink = "http://mozambique.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mozambique.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_moz_04 <- setCluster(id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Mozambique") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5) %>%
  setObsVar(name = "headcount", unit = "n",  columns = 6)

regTable(nation = "moz",
         level = 1,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_moz_04,
         begin = 2005,
         end = 2012,
         archive = "D3S_8351228261982721895422674204631154074.xlsx",
         archiveLink = "http://mozambique.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mozambique.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_moz_05 <- setCluster(id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Mozambique") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6)

regTable(nation = "moz",
         level = 1,
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_moz_05,
         begin = 2002,
         end = 2012,
         archive = "D3S_81484070807992882047118128674261842078.xlsx",
         archiveLink = "http://mozambique.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mozambique.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_moz_06 <- setCluster(id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Mozambique") %>%
  setIDVar(name = "al2", columns = 5) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 7) %>%
  setObsVar(name = "headcount", unit = "n", columns = 8)

regTable(nation = "moz",
         level = 2,
         subset = "livestockCattle",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_moz_06,
         begin = 2014,
         end = 2018,
         archive = "D3S_45144279647651940626724760324953181850.xlsx",
         archiveLink = "http://mozambique.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://mozambique.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_moz_07 <-
  setIDVar(name = "al1", value = "Mozambique") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 3)

schema_moz_08 <- schema_moz_07 %>%
  setObsVar(name = "planted", unit = "ha", columns = 4)

regTable(nation = "moz",
         level = 1,
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_moz_08,
         begin = 2002,
         end = 2012,
         archive = "144CPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=MOZ&ta=144CPD016&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=MOZ&ta=144CPD016&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_moz_09 <- schema_moz_07 %>%
  setObsVar(name = "production", unit = "t", columns = 4)

regTable(nation = "moz",
         level = 1,
         subset = "production",
         dSeries = ds[1],
         gSeries = gd[1],
         schema = schema_moz_09,
         begin = 2002,
         end = 2012,
         archive = "144CPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=MOZ&ta=144CPD010&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=MOZ&ta=144CPD010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


## masa----
# schema_masa1 <- makeSchema()
#
# regTable(nation = "Mozambique",
#          subset = "headcountCattle",
#          level = 2,
#          dSeries = "masa",
#          gSeries = "mozgis",
#          schema = ,
#          begin = 2007,
#          end = 2017,
#          archive = "mozambique.zip|headcount.cattle.2007-2017.csv",
#          archiveLink = "http://www.masa.gov.mz/pecuaria/producao-animal/",
#          updateFrequency = "unknown",
#          metadataLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
#          metadataPath = "unavailable",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mozambique",
#          subset = "headcountSwine",
#          level = 2,
#          dSeries = "masa",
#          gSeries = "mozgis",
#          schema = ,
#          begin = 2007,
#          end = 2017,
#          archive = "mozambique.zip|headcount.swine.2007-2017.csv",
#          archiveLink = "http://www.masa.gov.mz/pecuaria/producao-animal/",
#          updateFrequency = "unknown",
#          metadataLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
#          metadataPath = "unavailable",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mozambique",
#          subset = "plantedArea",
#          level = 2,
#          dSeries = "masa",
#          gSeries = "mozgis",
#          schema = ,
#          begin = 2009,
#          end = 2009,
#          archive = "mozambique.zip|Censo Agro 2013 Pecuario 2009 2013 2010 Resultados Definitivos -2.pdf",
#          archiveLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
#          updateFrequency = "unknown",
#          metadataLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
#          metadataPath = "unavailable",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mozambique",
#          subset = "plantedArea_Production",
#          level = 2,
#          dSeries = "masa",
#          gSeries = "mozgis",
#          schema = ,
#          begin = 2012,
#          end = 2014,
#          archive = "mozambique.zip|Anuario_Estatistico-2012_2014.pdf",
#          archiveLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
#          updateFrequency = "unknown",
#          metadataLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
#          metadataPath = "unavailable",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mozambique",
#          subset = "plantedArea_Production",
#          level = 2,
#          dSeries = "masa",
#          gSeries = "mozgis",
#          schema = ,
#          begin = 2015,
#          end = 2015,
#          archive = "mozambique.zip|Anuario_Estatistico2016.pdf",
#          archiveLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
#          updateFrequency = "unknown",
#          metadataLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
#          metadataPath = "unavailable",
#          update = updateTables,
#          overwrite = overwriteTables)
#
# regTable(nation = "Mozambique",
#          subset = "sugarCane",
#          level = 1,
#          dSeries = "masa",
#          gSeries = "mozgis",
#          schema = ,
#          begin = 2012,
#          end = 2014,
#          archive = "mozambique.zip|Anuario_Estatistico-2012_2014.pdf",
#          archiveLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
#          updateFrequency = "unknown",
#          metadataLink = "http://www.masa.gov.mz/estatisticas/inquerito-agricola-integrado/",
#          metadataPath = "unavailable",
#          update = updateTables,
#          overwrite = overwriteTables)


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
