# author and date of creation ----
#
# Steffen Ehrmann, 26.02.2022


# script description ----
#
# This script summarises rasters of all layers of the same variable into a
# single raster to represent the overall amount of the respective variable.
message("\n---- rename CHELSA climatologies ----")


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
if(!testDirectoryExists(paste0(dataDir,"processed/CHELSA_bio"))){
  dir.create(paste0(dataDir,"processed/CHELSA_bio"))
}


# load data ----
#
message(" --> pull input files")
inFiles <- list.files(path = paste0(dataDir, "original/CHELSA/envicloud/chelsa/chelsa_V2/GLOBAL/climatologies/1981-2010/bio"), full.names = TRUE)

newName <- map(seq_along(inFiles), function(ix){
  temp <- str_split(inFiles[ix], "/")[[1]]
  temp <- str_split(tail(temp, 1), string = , "_")[[1]]
  temp <- temp[-c(1, length(temp)-1, length(temp))]
  first <- temp[1]
  other <- temp[-1]
  paste0(first, paste0(toupper(substring(other, 1, 1)), substring(other, 2), collapse = ""), collapse = "")
}) %>% unlist()


# data processing ----
#
message(" --> saving with new name")
for(i in 24:71){

  message(" --> '", newName[i], "' ...")
  temp <- wrap(rast(inFiles[i]))

  writeRaster(x = rast(temp),
              filename = paste0(dataDir, "processed/CHELSA_bio/CHELSA_bio-", newName[i], "_20100000_1km.tif"),
              overwrite = TRUE,
              filetype = "GTiff",
              datatype = "FLT4S",
              gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

}


# write output ----
#

# beep(sound = 10)
message("\n     ... done")
