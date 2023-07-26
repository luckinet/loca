# script arguments ----
#
thisNation <- "El Salvador"

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested

ds <- c("faoDatalab")
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
## faoDatalab ----
schema_slv_01 <-
  setIDVar(name = "al2",columns = 3 ) %>%
  setIDVar(name = "year", columns = 2) %>%
  setIDVar(name = "commodities", columns = 6) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 10,
            key = 11, value = "Hectares") %>%
  setObsVar(name = "production", unit = "t", columns = 10,
            key = 11, value = "Metric Tonnes")

regTable(nation = "slv",
         level = 2,
         subset = "crops",
         dSeries = ds[1],
         gSeries = gs[1],
         schema = schema_slv_01,
         begin = 2010,
         end = 2017,
         archive = "El Salvador - Sub-National Level 2.csv",
         archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/El%20Salvador%20-%20Sub-National%20Level%202.csv",
         updateFrequency = "annually",
         nextUpdate = "unknown",
         metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20El%20Salvador.pdf",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

# the following table does not have a proper regions, we do not have geometries for them
# regTable(nation = "slv",
#         level = 2,
#         subset = "crops",
#         dSeries = ds[1],
#         gSeries = "",
#         schema = schema_slv_faoDatalab_01,
#         begin = 2010,
#         end = 2017,
#         archive = "El Salvador - Sub-National Level 1.csv",
#         archiveLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-10/El%20Salvador%20-%20Sub-National%20Level%201.csv",
#         updateFrequency = "annually",
#         nextUpdate = "unknown",
#         metadataLink = "http://www.fao.org/datalab/website/web/sites/default/files/2020-11/Data%20Validation%20for%20El%20Salvador.pdf",
#         metadataPath = "unknown",
#         update = updateTables,
#         overwrite = overwriteTables)


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
