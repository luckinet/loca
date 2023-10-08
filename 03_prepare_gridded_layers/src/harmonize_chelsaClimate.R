# author and date of creation ----
#
# Steffen Ehrmann, 15.02.2022


# script description ----
#
# This script summarises rasters of all layers of the same variable into a
# single raster to represent the overall amount of the respective variable.
message("\n---- aggregate monthly CHELSA temperature to yearly values ----")


# load packages ----
#
# module load foss/2020b R/4.0.4-2
# install.packages("r_packages/luckiTools_0.0.1.tar.gz", repos = NULL, type = "source")
library(luckiTools)
library(terra)
library(sf)
library(tidyverse)
library(checkmate)

terraOptions(tempdir = "work/ehrmann/Rtmp/", memmax = 50)
# array <- as.integer(Sys.getenv('SLURM_ARRAY_TASK_ID')) # use this code to grab the array ID for iterating through this script depending on the array. This basically means that the for-loop is opened and looped through by the cluster/array and with this code I get the current iterator.
#SBATCH --array=1-28 #  open the array in the bash script as such


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
if(!testDirectoryExists(paste0(dataDir,"processed/CHELSA_climate"))){
  dir.create(paste0(dataDir,"processed/CHELSA_climate"))
}

inPath <- paste0(dataDir, "original/CHELSA/envicloud/chelsa/chelsa_V2/GLOBAL/monthly/")


# data processing ----
#
for(i in 1998:2004){

  message(" --> '", i, "' ...")

  for(j in c("tas", "tasmin", "tasmax")){

    message("     '", j, "'")

    temp <- rast(list.files(path = paste0(inPath, j), pattern = as.character(i), full.names = TRUE))
    origin(temp) <- c(0, 0)
    temp <- wrap(temp)


    if(j == "tas"){

      out <- mean(x = rast(temp), na.rm = TRUE)
      varName <- "yearMeanTemperature"

    } else if(j == "tasmin"){

      out <- min(x = rast(temp), na.rm = TRUE)
      varName <- "yearMinimumTemperature"

    } else if(j == "tasmax"){

      out <- max(x = rast(temp), na.rm = TRUE)
      varName <- "yearMaxTemperature"

    }


    writeRaster(x = out,
                filename = paste0(dataDir, "processed/CHELSA_climate/CHELSA_climate-", varName, "_", i, "0000_1km.tif"),
                overwrite = TRUE,
                filetype = "GTiff",
                datatype = "FLT4S",
                gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

    rm(out); rm(temp)
    gc()

  }
}


# write output ----
#

# beep(sound = 10)
message("\n     ... done")
