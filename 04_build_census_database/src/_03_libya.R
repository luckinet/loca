# script arguments ----
#
thisNation <- "Libya"

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested

ds <- c("bscl")
gs <- c("")


# register dataseries ----
#
regDataseries(name = ds[1],
              description = "Bureau of Statistics and Census Libya",
              homepage = "http://bsc.ly/",
              licence_link = "",
              licence_path = "",
              update = updateTables)


# register geometries ----
#
## UNITAR-UNOSAT ----
# regGeometry(nation = "Libya",
#             gSeries = "UNITAR-UNOSAT",
#             level = 1,
#             nameCol = "ADM0_EN",
#             archive = "ocha-romena-fd9fb749-5b68-4942-b5f9-115f20b5c00e.zip|lby_admbnda_adm0_unosat_lbsc_20180507.shp",
#             archiveLink = "",
#             updateFrequency = "unknown",
#             update = myUpdate)
#
# regGeometry(nation = "Libya",
#             gSeries = "UNITAR-UNOSAT",
#             level = 2,
#             nameCol = "ADM1_EN",
#             archive = "ocha-romena-fd9fb749-5b68-4942-b5f9-115f20b5c00e.zip|lby_admbnda_adm1_unosat_lbsc_20180507.shp",
#             archiveLink = "",
#             updateFrequency = "unknown",
#             update = myUpdate)
#
# regGeometry(nation = "Libya",
#             gSeries = "UNITAR-UNOSAT",
#             level = 3,
#             nameCol = "ADM2_EN",
#             archive = "ocha-romena-fd9fb749-5b68-4942-b5f9-115f20b5c00e.zip|lby_admbnda_adm2_unosat_lbsc_20180507.shp",
#             archiveLink = "",
#             updateFrequency = "unknown",
#             update = myUpdate)


# register census tables ----
#
schema_1 <- setCluster() %>%
  setFormat() %>%
  setIDVar(name = "al2", ) %>%
  setIDVar(name = "year", ) %>%
  setIDVar(name = "commodity", ) %>%
  setObsVar(name = "planted", unit = "ha", )

regTable(nation = !!thisNation, # or any other "class = value" combination from the gazetteer
         label = ,
         subset = "",
         dSeries = ds[],
         gSeries = gs[],
         schema = ,
         begin = ,
         end = ,
         archive = "",
         archiveLink = "",
         updateFrequency = "",
         nextUpdate = "",
         metadataPath = "",
         metadataLink = "",
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
