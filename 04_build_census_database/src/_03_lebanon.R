# script arguments ----
#
thisNation <- "Lebanon"

updateTables <- FALSE       # change this to 'TRUE' after everything has been set up and tested
overwriteTables <- FALSE    # change this to 'TRUE' after everything has been set up and tested

ds <- c("cas")
gs <- c("gadm36", "ocha")


# register dataseries ----
#
regDataseries(name = ds[1],
              description = "The Central Administration of Statistics",
              homepage = "http://www.cas.gov.lb/",
              notes = "data are public domain",
              licence_link = "",
              licence_path = "",
              update = updateTables)


# register geometries ----
#
## OCHA ----
# regGeometry(nation = "Lebanon",
#             gSeries = "OCHA", # change the source dataseries here
#             level = 1,
#             nameCol = "admin0Name",
#             archive = "lbn_admbnda_adm0_cdr_20160822.zip|lbn_admbnda_adm0_cdr_20160822.shp",
#             archiveLink = "", #find out link
#             updateFrequency = "unknown",
#             update = myUpdate)
#
# regGeometry(nation = "Lebanon",
#             gSeries = "OCHA", # change the source dataseries here
#             level = 2,
#             nameCol = "admin1Name",
#             archive = "lbn_admbnda_adm1_cdr_20160822.zip|lbn_admbnda_adm1_cdr_20160822.shp",
#             archiveLink = "", #find out link
#             updateFrequency = "unknown",
#             update = myUpdate)
#
# regGeometry(nation = "Lebanon",
#             gSeries = "OCHA", # change the source dataseries here
#             level = 3,
#             nameCol = "admin2Name",
#             archive = "lbn_admbnda_adm2_cdr_20160822.zip|lbn_admbnda_adm2_cdr_20160822.shp",
#             archiveLink = "", #find out link
#             updateFrequency = "unknown",
#             update = myUpdate)
#
# regGeometry(nation = "Lebanon",
#             gSeries = "OCHA", # change the source dataseries here
#             level = 4,
#             nameCol = "admin3Name",
#             archive = "lbn_admbnda_adm3_cdr_20160822.zip|lbn_admbnda_adm3_cdr_20160822.shp",
#             archiveLink = "", #find out link
#             updateFrequency = "unknown",
#             update = myUpdate)


# register census tables ----
#
# schema_Seasonallanduse10 <- makeSchema(schema = list(
#   clusters =
#     list(row = 5, col = 1, width = NULL, height = NULL,
#          id = "commodities"),
#   header = list(row = 5:6, rel = FALSE),
#   meta = list(del = ",", na = NULL, types = NULL),
#   variables = list(
#     al2 =
#       list(type = "id", row = NULL, col = 1, value = NULL,
#            split = NULL, rel = TRUE, dist = FALSE),
#     year =
#       list(type = "id", row = NULL, col = NULL, value = NULL,
#            split = NULL, rel = FALSE, dist = FALSE),
#     commodities =
#       list(type = "id", row = 5, col = NULL, value = NULL,
#            split = NULL, rel = FALSE, dist = FALSE),
#     planted =
#       list(type = "measured", row =NULL, col = c(3,5,7,9,11,13,15),
#            unit = "ha", factor = 0.1, key = NULL, value = NULL,
#            rel = FALSE, dist = FALSE),
#     harvested =
#       list(type = "measured", row = NULL, col = NULL,
#            unit = "ha", factor = 0.1, key = NULL, value = NULL,
#            rel = FALSE, dist = FALSE),
#     yield =
#       list(type = "measured", row = NULL, col = NULL,
#            unit = "t/ha", factor = 1, key = NULL, value = NULL,
#            rel = FALSE, dist = FALSE),
#     production =
#       list(type = "measured", row = NULL, col = NULL,
#            unit = "t", factor = 1, key = NULL, value = NULL,
#            rel = FALSE, dist = FALSE)
#   )))
# regTable(nation = "Lebanon",
#          level = 2,
#          subset = "Seasonal landuse",
#          dSeries = "OCHA",
#          gSeries = "OCHA",
#          begin = 2010,
#          end = 2010,
#          schema = schema_Seasonallanduse10,
#          archive = "SeasonalCult_CropsRegional_L2_Lebanon_2010.xlsx",
#          archiveLink = "unknown",
#          updateFrequency = "notPlanned",
#          metadataLink = "unknown",
#          metadataPath = "unknown",
#          update = TRUE)


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
