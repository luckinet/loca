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
regDataseries(name = "gaul",
              description = "Global Administrative Unit Layers",
              homepage = "http://www.fao.org/tempref/AG/Reserved/PPLPF/ftpOUT/GLiPHA/Gaulmaps/gaul_2008/documentation/GAUL%20Doc01%20Ver16.pdf",
              licence_link = "not available",
              licence_path = "not available",
              update = TRUE)


# 2. register geometries ----
#
regGeometry(nation = "ADM0_NAME",
            gSeries = "gaul",
            level = 1,
            nameCol = "ADM0_NAME",
            archive = "gaul_2008.zip|g2008_0.shp",
            archiveLink = "unknown",
            updateFrequency = "notPlanned",
            update = TRUE)

regGeometry(nation = "ADM0_NAME",
            gSeries = "gaul",
            level = 2,
            nameCol = "ADM0_NAME|ADM1_NAME",
            archive = "gaul_2008.zip|g2008_1.shp",
            archiveLink = "unknown",
            updateFrequency = "notPlanned",
            update = TRUE)

regGeometry(nation = "ADM0_NAME",
            gSeries = "gaul",
            level = 3,
            nameCol = "ADM0_NAME|ADM1_NAME|ADM2_NAME",
            archive = "gaul_2008.zip|g2008_2.shp",
            archiveLink = "unknown",
            updateFrequency = "notPlanned",
            update = TRUE)


# 3. register census tables ----
#
# no census tables available for gaul


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
               pattern = "gaul",
               outType = "gpkg",
               update = updateTables)

}
