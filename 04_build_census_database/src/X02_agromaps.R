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
assertLogical(x = normalise, len = 1)                  # ensure that normalise is set
updateTables <- TRUE
overwriteTables <- TRUE

# source(paste0(modlDir, "src/99_preprocess_agromaps.R"))


# 1. register dataseries ----
#
regDataseries(name = "agromaps",
              description = "Agro-MAPS",
              homepage = "http://ebrary.ifpri.org/cdm/ref/collection/p15738coll3/id/66",
              licence_link = "unknown",
              licence_path = "not available",
              update = TRUE)


# 2. register geometries ----
#
# no specific geoms available


# 3. register census tables ----
#
schema_agromaps1 <- setHeader(rows = 1) %>%
  setIDVar(name = "al1", columns = 4) %>%
  setIDVar(name = "al2", columns = 2) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 8) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 11) %>%
  setObsVar(name = "production", unit = "t", columns = 10) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = 12)

regTable(nation = NULL,
         level = 2,
         dSeries = "agromaps",
         gSeries = "gadm", # this might in fact be gaul?!
         begin = 1970,
         end = 2011,
         schema = schema_agromaps1,
         archive = "dumpAgromaps.csv",
         archiveLink = "unknown",
         nextUpdate = "notPlanned",
         updateFrequency = "notPlanned",
         metadataLink = "unknown",
         metadataPath = "unknown",
         update = updateTables,
         overwrite = overwriteTables)

  schema_agromaps2 <- setHeader(rows = 1) %>%
  setIDVar(name = "al1", columns = 4) %>%
  setIDVar(name = "al3", columns = 2) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "commodities", columns = 8) %>%
  setObsVar(name = "harvested", unit = "ha", columns = 11) %>%
  setObsVar(name = "production", unit = "t", columns = 10) %>%
  setObsVar(name = "yield", unit = "kg/ha", factor = 1000, columns = 12)

regTable(nation = NULL,
         level = 3,
         dSeries = "agromaps",
         gSeries = "gadm", # this might in fact be gaul?!
         begin = 1970,
         end = 2011,
         schema = schema_agromaps2,
         archive = "dumpAgromaps.csv",
         archiveLink = "unknown",
         nextUpdate = "notPlanned",
         updateFrequency = "notPlanned",
         metadataLink = "unknown",
         metadataPath = "unknown",
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
            pattern = "agromaps",
            source = "datID",
            outType = "rds",
            update = updateTables)

}
