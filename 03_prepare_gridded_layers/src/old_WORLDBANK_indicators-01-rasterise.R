# author and date of creation ----
#
# Steffen Ehrmann, 23.02.2022


# script description ----
#
# This script builds rasters of all sort of national level socio-economic
# indicator variables from FAOstat by downscaling them to a 1km² grid.
message("\n---- rasterise WORLDBANK indicators (at 1km²) ----")

library(luckiTools)
library(terra)
library(sf)
library(stars)
library(tidyverse)
library(checkmate)


# set paths ----
#
projDir <- select_path(idivnb283 = "/media/se87kuhe/external1/projekte/LUCKINet/",
                       default = "/gpfs1/data/idiv_meyer/01_projects/LUCKINet/")
dataDir <- select_path(idivnb283 = paste0(projDir, "01_data/"),
                       default = "/gpfs1/data/idiv_meyer/00_data/")
modlDir <- paste0(projDir, "02_data_processing/01_prepare_gridded_layers/")


# script arguments ----
#
# make sure paths have been set
assertDirectoryExists(x = dataDir)

# create directories
if(!testDirectoryExists(paste0(dataDir,"processed/WORLDBANK_indicators"))){
  dir.create(paste0(dataDir,"processed/WORLDBANK_indicators"))
}


# load data ----
#
message(" --> pull input files")
inFiles <- list.files(path = paste0(dataDir, "gridded_data/"))
if(!"WORLDBANK_indicators" %in% inFiles){
  untar(exdir = paste0(dataDir, "gridded_data/WORLDBANK_indicators"), tarfile = paste0(dataDir, "gridded_data/worldbank_20220223.tar.xz"))
}

targetFiles <- list.files(path = paste0(dataDir, "gridded_data/WORLDBANK_indicators"), full.names = TRUE)

# data processing ----
#

for(i in seq_along(targetFiles)){






  writeRaster(x = ,
              filename = ,
              overwrite = TRUE,
              filetype = "GTiff",
              datatype = "FLT4S",
              gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))
}

# write output ----
#
message("\n---- done ----")
