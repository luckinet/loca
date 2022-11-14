# author and date of creation ----
#
# Steffen Ehrmann, 08.06.2021


# script description ----
#
# This document serves as a protocol, documenting the process of building the
<<<<<<< HEAD
# database of areal data for LUCKINet. File-names contain three fields
# (delimited by "_") according to the schema 'region_country_status.R". The
# regions are the following: 01 = global, 02 = africa, 03 = americas, 04 =
# arabia, 05 = europe, 06 = southeast asia, 07 = central asia. The statuses are
# as follows: 00 = fully integrated, 01 = more or less done, needs a final
# touch, 02 = partly finished, known additional datasources are not yet
# integrated, 03 = various degrees of "not yet finished".
=======
# database of areal data for LUCKINet.
>>>>>>> 1c06ba5f23560af3dff7ab07bd63240393d141f9


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
regDataseries(name = "agCensus",
              description = "AG Census Wiki",
              homepage = "not available",
              licence_link = "not available",
              licence_path = "not available",
              update = TRUE)


# 2. register geometries ----
#
<<<<<<< HEAD
regGeometry(nation = "",
            gSeries = "",
            level = 2,
            nameCol = "",
            archive = "|",
            archiveLink = "",
            nextUpdate = "",
            updateFrequency = "",
            update = updateTables)
=======
>>>>>>> 1c06ba5f23560af3dff7ab07bd63240393d141f9


# 3. register census tables ----
#
<<<<<<< HEAD
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
=======
>>>>>>> 1c06ba5f23560af3dff7ab07bd63240393d141f9


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
