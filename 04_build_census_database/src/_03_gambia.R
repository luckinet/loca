# script arguments ----
#
thisNation <- "Gambia"

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
schema_gmb_00 <-
  setIDVar(name = "al2", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_gmb_01 <- schema_gmb_00 %>%
  setFilter(rows = .find("Kombo Saint Mary", col = 3), invert = TRUE) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6)

regTable(nation = "gmb",
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 1988,
         end = 2001,
         schema = schema_gmb_01,
         archive = "075SPD015.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD015&tr=-2",
         updateFrequency = "annally",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD015&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_gmb_02 <- schema_gmb_00 %>%
  setObsVar(name = "planted", unit = "ha", columns = 6)

regTable(nation = "gmb",
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 1988,
         end = 2012,
         schema = schema_gmb_02,
         archive = "075SPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD016&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD016&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_gmb_03 <- schema_gmb_00 %>%
  setFilter(rows = .find("Kombo Saint Mary", col = 3), invert = TRUE) %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "gmb",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 2,
         begin = 1988,
         end = 2012,
         schema = schema_gmb_03,
         archive = "075SPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD010&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_gmb_04 <-
  setIDVar(name = "al1", value = "Gambia") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 3)

# units are not explicitally specified. Here I assume it is kg/ha
schema_gmb_05 <- schema_gmb_04 %>%
  setObsVar(name = "yield", unit = "kg/ha", columns = 4)

regTable(nation = "gmb",
         subset = "yield",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 1,
         begin = 1987,
         end = 2010,
         schema = schema_gmb_05,
         archive = "075CPD011.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GMB&ta=075CPD011&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GMB&ta=075CPD011&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_gmb_06 <- schema_gmb_04 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 4)

regTable(nation = "gmb",
         level = 1,
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_gmb_06,
         begin = 1987,
         end = 2000,
         archive = "075CPD015.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GMB&ta=075CPD015&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GMB&ta=075CPD015&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_gmb_07 <- schema_gmb_04 %>%
  setObsVar(name = "planted", unit = "ha", columns = 4)

regTable(nation = "gmb",
         level = 1,
         subset = "planted",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_gmb_07,
         begin = 1987,
         end = 2011,
         archive = "075CPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GMB&ta=075CPD016&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GMB&ta=075CPD016&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_gmb_08 <-
  setIDVar(name = "al1", value = "Gambia") %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 3) %>%
  setObsVar(name = "area", unit = "ha", columns = 4, factor = 1000)

regTable(nation = "gmb",
         level = 1,
         subset = "landuse",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_gmb_08,
         begin = 1983,
         end = 2011,
         archive = "075CLI010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GMB&ta=075CLI010&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GMB&ta=075CLI010&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)


schema_gmb_09 <-
  setFilter(rows = .find("Kombo..", col = 3)) %>%
  setIDVar(name = "al3", columns = 3) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 5)

schema_gmb_10 <- schema_gmb_09 %>%
  setObsVar(name = "harvested", unit = "ha", columns = 6)

regTable(nation = "gmb",
         subset = "harvested",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 1988,
         end = 2012,
         schema = schema_gmb_10,
         archive = "075SPD016.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD016&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD016&tr=-2",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

schema_gmb_11 <- schema_gmb_09 %>%
  setObsVar(name = "production", unit = "t", columns = 6)

regTable(nation = "gmb",
         subset = "production",
         dSeries = ds[1],
         gSeries = gs[1],
         level = 3,
         begin = 1988,
         end = 2012,
         schema = schema_gmb_11,
         archive = "075SPD010.csv",
         archiveLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD010&tr=-2",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://countrystat.org/home.aspx?c=GMB&ta=075SPD010&tr=-2",
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
