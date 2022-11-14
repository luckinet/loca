# author and date of creation ----
#
# Steffen Ehrmann, 23.02.2022


# script description ----
#
# This script summarises rasters of all layers of the same variable into a
# single raster to represent the overall amount of the respective variable.
message("\n---- summarise soilGrids over all soil-layers ----")


# load packages ----
#
# module load foss/2020b R/4.0.4-2
# install.packages("r_packages/luckiTools_0.0.1.tar.gz", repos = NULL, type = "source")
library(luckiTools)
library(terra)
library(sf)
library(stars)
library(tidyverse)
library(checkmate)

# terraOptions(tempdir = "work/ehrmann/Rtmp/", memmax = 16)
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
if(!testDirectoryExists(paste0(dataDir,"processed/soilGrids"))){
  dir.create(paste0(dataDir,"processed/soilGrids"))
}


# load data ----
#
message(" --> pull input files")
inFiles <- list.files(path = paste0(dataDir, "processed/soilGrids"), full.names = TRUE)

targetVars <- c("bdod", "cec", "nitrogen", "ocd", "sand", "soc")

# data processing ----
#
message(" --> average ...")
for(i in seq_along(targetVars)){

  temp <- inFiles[str_detect(string = inFiles, pattern = targetVars[i])]
  message("     ...'", targetVars[i], "'")

  temp <- wrap(rast(temp[1]))

  out <- mean(x = rast(temp), na.rm = TRUE)

  writeRaster(x = out,
              filename = paste0(dataDir, "processed/soilGrids/soilGrids-", targetVars[i], "Total_20200000_1km.tif"),
              overwrite = TRUE,
              filetype = "GTiff",
              datatype = "FLT4S",
              gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))


}

# write output ----
#
message("\n---- done ----")
