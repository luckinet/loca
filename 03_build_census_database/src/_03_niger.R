# script arguments ----
#
thisNation <- "Niger"

updateTables <- TRUE
overwriteTables <- TRUE

ds <- c("countrySTAT")
gs <- c("gadm36")


# register dataseries ----
#


# register geometries ----
#


# register census tables ----
#
## countryStat ----
schema_ner_00 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_ner_01 <- schema_ner_00 %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "ner",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2000,
         end = 2011,
         schema = schema_ner_01,
         archive = "158SPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD010&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ner_02 <- schema_ner_00 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6)

regTable(nation = "ner",
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 2000,
         end = 2011,
         schema = schema_ner_02,
         archive = "158SPD015.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD015&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD015&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ner_03 <- schema_ner_00 %>%
  setObsVar(name = "planted", unit = "ha", columns = 6)

regTable(nation = "ner",
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 1996,
         end = 2002,
         schema = schema_ner_03,
         archive = "158SPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD016&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD016&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_ner_04 <- schema_ner_00 %>%
  setObsVar(name = "headcount", unit = "n", columns = 6)

regTable(nation = "ner",
         subset = "livestock",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 1970,
         end = 2010,
         schema = schema_ner_04,
         archive = "158SPD035.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD035&tr=-2",
         updateFrequency = "unknown",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=NER&ta=158SPD035&tr=-2",
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
