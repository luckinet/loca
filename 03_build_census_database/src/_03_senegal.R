# script arguments ----
#
thisNation <- "Senegal"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("countrySTAT", "faoDatalab")
gs <- c("gadm36")


# register dataseries ----
#


# register geometries ----
#


# register census tables ----
#
## countrySTAT ----
schema_sen_01 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5) %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

regTable(nation = "sen",
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 1997,
         end = 2011,
         schema = schema_sen_01,
         archive = "195WIP008.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=SEN&ta=195WIP008&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=SEN&ta=195WIP008&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_sen_02 <- setCluster(id = "year", left = 1, top = 6) %>%
  setFilter(rows = .find("Senegal", col = 3), invert = TRUE) %>%
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", value = "2017") %>%
  setIDVar(name = "commodities", columns = 5) %>%
  setObsVar(name = "planted", unit = "ha", columns = 8,
            key = 7, value = "Production value") %>%
  setObsVar(name = "production", unit = "t", columns = 8,
            key = 7, value = "Production quantity") %>%
  setObsVar(name = "yield", unit = "Kg/ha", columns = 8,
            key = 7, value = "Yield")

regTable(nation = "sen",
         subset = "plantedProdYield",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2017,
         end = 2017,
         schema = schema_sen_02,
         archive = "D3S_34926228041252392115081506989814244913.xlsx",
         archiveLink = "http://senegal.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://senegal.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_sen_03 <- setCluster(id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Senegal") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_sen_04 <- schema_sen_03 %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "sen",
         level = 1,
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_sen_04,
         begin = 2011,
         end = 2017,
         archive = "D3S_41060683618196319745076994969183224823.xlsx",
         archiveLink = "http://senegal.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://senegal.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_sen_05 <- schema_sen_03 %>%
  setFilter(rows = .find("Live..", col = 3)) %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

regTable(nation = "sen",
         level = 1,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_sen_05,
         begin = 1997,
         end = 2012,
         archive = "D3S_36304856734075633687706538763899072144.xlsx",
         archiveLink = "http://senegal.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://senegal.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_sen_06 <- schema_sen_03 %>%
  setFilter(rows = .find("^(01).*", col = 4)) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6,
            key = 3, value = "Area Harvested") %>%
  setObsVar(name = "production", unit = "t", columns = 6,
            key = 3, value = "Production quantity")

regTable(nation = "sen",
         level = 1,
         subset = "productionHarvested",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_sen_06,
         begin = 1997, #the table has data starting from 1990, but until 1997 there is only dairy and animal products.
         end = 2013,
         archive = "D3S_19046083079020706024675779238570537101.xlsx",
         archiveLink = "http://senegal.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://senegal.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


## faoDatalab ----
schema_sen_07 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = 6) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 10,
            key = 11, value = "Hectares") %>%
  setObsVar(name = "production", unit = "t", columns = 10,
            key = 11, value = "Metric Tonnes")

regTable(nation = "sen",
         level = 2,
         subset = "productionHarvested",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_sen_07,
         begin = 2009,
         end = 2019,
         archive = "Senegal - Sub-National Level 1.csv",
         archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Senegal%20-%20Sub-National%20Level%201.csv",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Senegal_0.pdf",
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
