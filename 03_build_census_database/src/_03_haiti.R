# script arguments ----
#
thisNation <- "Haiti"

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested

ds <- c("countrySTAT", "faoDatalab")
gs <- c("gadm", "spam")


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
# countrystat ----
schema_hti_00 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_hti_01 <- schema_hti_00 %>%
  setObsVar(name = "planted", unit = "ha", columns = 6)

regTable(nation = "hti",
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2010,
         end = 2010,
         schema = schema_hti_01,
         archive = "093SPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=HTI&tr=-2",
         nextUpdate = "unknown",
         updateFrequency = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_hti_02 <- setCluster(id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Haiti") %>%
  setIDVar(name = "al2", columns = 5) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 7) %>%
  setObsVar(name = "planted", unit = "ha", columns = 8)

regTable(nation = "hti",
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2009,
         end = 2009,
         schema = schema_hti_02,
         archive = "D3S_76193321223846437098690907333482998658.xlsx",
         archiveLink = "http://haiti.countrystat.org/search-and-visualize/fr/",
         nextUpdate = "unknown",
         updateFrequency = "unknown",
         metadataLink = "http://haiti.countrystat.org/search-and-visualize/fr/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_hti_03 <- schema_hti_00 %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

regTable(nation = "hti",
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2010,
         end = 2010,
         schema = schema_hti_03,
         archive = "093SPD035.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=HTI&tr=-2",
         nextUpdate = "unknown",
         updateFrequency = "unknown",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_hti_04 <- setCluster(id = "al1", left = 1, top = 4) %>%
  setIDVar(name = "al1", value = "Haiti") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_hti_05 <- schema_hti_04 %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "hti",
         level = 1,
         subset = "productionRice",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_hti_05,
         begin = 1975,
         end = 1996,
         archive = "D3S_89554542458867715096793523733851553598.xlsx",
         archiveLink = "http://haiti.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://haiti.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "hti",
         level = 1,
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_hti_05,
         begin = 2013,
         end = 2013,
         archive = "D3S_87946494224330745715761960034533027374.xlsx",
         archiveLink = "http://haiti.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://haiti.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

regTable(nation = "hti",
         level = 1,
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_hti_05,
         begin = 2000,
         end = 2016,
         archive = "D3S_46783234352504305878898071105501995686.xlsx",
         archiveLink = "http://haiti.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://haiti.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


# faoDatalab ----
schema_hti_06 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = 6) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 10,
            key = 11, value = "Hectares") %>%
  setObsVar(name = "production", unit = "t", columns = 10,
            key = 11, value = "Metric Tonnes")

regTable(nation = "hti",
         level = 2,
         subset = "productionHarvested",
         dSeries = ds[2],
         gSeries = gs[1],
         schema = schema_hti_06,
         begin = 2014,
         end = 2016,
         archive = "Haiti - Sub-National Level 1.csv",
         archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/Haiti%20-%20Sub-National%20Level%201.csv",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20Haiti.pdf",
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
