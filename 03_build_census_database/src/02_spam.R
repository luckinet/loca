# author and date of creation ----
#
# Steffen Ehrmann, 08.06.2021


# script description ----
#
# This document serves as a protocol, documenting the process of building the
# database of areal data for LUCKINet.


# load packages ----
#
library(arealDB)
library(tabshiftr)
library(magrittr)
library(checkmate)


# script arguments ----
#
thisNation <- ""
assertSubset(x = thisNation, choices = countries$label) # ensure that nation is valid
assertLogical(x = normalise, len = 1)                  # ensure that normalise is set
updateTables <- TRUE
overwriteTables <- TRUE


# 1. register dataseries ----
#
regDataseries(name = "spam",
              description = "Spatial Production Allocation Model",
              homepage = "https://www.mapspam.info/",
              licence_link = "https://www.mapspam.info/terms/",
              licence_path = "not available",
              update = TRUE)


# 2. register geometries ----
#
regGeometry(nation = "ADM0_NAME",
            gSeries = "spam",
            level = 1,
            nameCol = "ADM0_NAME",
            archive = "GIS.zip|g2008_0.shp",
            archiveLink = "unknown",
            updateFrequency = "notPlanned",
            update = TRUE)

regGeometry(nation = "ADM0_NAME",
            gSeries = "spam",
            level = 2,
            nameCol = "ADM0_NAME|ADM1_NAME",
            archive = "GIS.zip|g2008_1_2010.shp",
            archiveLink = "unknown",
            updateFrequency = "notPlanned",
            update = TRUE)

regGeometry(nation = "ADM0_NAME",
            gSeries = "spam",
            level = 3,
            nameCol = "ADM0_NAME|ADM1_NAME|ADM2_NAME",
            archive = "GIS.zip|g2008_2_2010.shp",
            archiveLink = "unknown",
            updateFrequency = "notPlanned",
            update = TRUE)


# 3. register census tables ----
#
schema_1 <- setCluster() %>%
  setHeader() %>%
  setFormat() %>%
  setIDVar(name = "al2", ) %>%
  setIDVar(name = "year", ) %>%
  setIDVar(name = "commodities", ) %>%
  setObsVar(name = "planted", unit = "ha", )

regTable(nation = "",
         level = ,
         subset = "",
         dSeries = "",
         gSeries = "",
         schema = ,
         begin = ,
         end = ,
         archive = "",
         archiveLink = "",
         updateFrequency = "",
         nextUpdate = "",
         metadataLink = "",
         metadataPath = "",
         update = updateTables,
         overwrite = overwriteTables)


if(normalise){

  # 4. normalise geometries ----
  #
  # only needed if GADM basis has not been built before
  # normGeometry(nation = thisNation,
  #              pattern = "gadm",
  #              outType = "gpkg",
  #              update = updateTables)

  # then register potential other geometries for this nation
  normGeometry(nation = thisNation,
               pattern = "",
               outType = "gpkg",
               update = updateTables)


  # 5. normalise census tables ----
  #
  ## in case the output shall be examined before writing into the DB
  # testing <- normTable(luckinetID = list(commodities = "target"),
  #                      nation = thisNation,
  #                      update = FALSE,
  #                      keepOrig = TRUE)

  # only needed if FAO datasets have not been integrated before
  # normTable(luckinetID = list(commodities = "target"),
  #           nation = thisNation,
  #           pattern = "fao",
  #           source = "datID",
  #           outType = "rds",
  #           update = updateTables)

  normTable(luckinetID = list(commodities = "target"),
            nation = thisNation,
            pattern = "",
            source = "datID",
            outType = "rds",
            update = updateTables)

}
