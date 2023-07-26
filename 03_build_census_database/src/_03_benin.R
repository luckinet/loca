# script arguments ----
#
thisNation <- "Benin"

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested

ds <- c("countrySTAT")
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
schema_ben_00 <-
  setIDVar(name = "al3", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_ben_01 <- schema_ben_00 %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "ben",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 1995,
         end = 2012,
         schema = schema_ben_01,
         archive = "053SPD110.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BEN&ta=053SPD110&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BEN&ta=053SPD110&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ben_02 <- schema_ben_00 %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

regTable(nation = "ben",
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 2000,
         end = 2013,
         schema = schema_ben_02,
         archive = "053SPD135.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=BEN&ta=053SPD135&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=BEN&ta=053SPD135&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


## new country STAT ----
schema_ben_03 <- setCluster (id = "al1", left = 1, top = 5) %>%
  setIDVar(name = "al1", value = "Benin") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_ben_04 <- schema_ben_03 %>%
  setFilter(rows = .find("^(01).*", col = 4)) %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "ben",
         level = 1,
         subset = "productionCrops",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ben_04,
         begin = 1995,
         end = 2015,
         archive = "D3S_41740911309657383405693317877964610672.xlsx",
         archiveLink = "http://benin.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://benin.countrystat.org/search-and-visualize-data/en/",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = updateTables)

schema_ben_05 <- schema_ben_03 %>%
  setFilter(rows = .find("Live..", col = 3)) %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

regTable(nation = "ben",
         level = 1,
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_ben_05,
         begin = 2000,
         end = 2013,
         archive = "D3S_31065608234090692436490577176461964860.xlsx",
         archiveLink = "http://benin.countrystat.org/search-and-visualize-data/en/",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://benin.countrystat.org/search-and-visualize-data/en/",
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
          # ontoMatch = "commodity",
          outType = "rds",
          update = updateTables)


