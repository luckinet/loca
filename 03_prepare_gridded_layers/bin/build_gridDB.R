# author and date of creation ----
#
# Steffen Ehrmann, 26.02.2022


# script description ----
#
# This is the main script for building a database of gridded data used in
# building theland-use time series of LUCKINet.

# Documentation ----
#
root <- dirname(dirname(rstudioapi::getSourceEditorContext()$path))
getOption("viewer")(rmarkdown::render(input = paste0(root, "/README.md")))


# script arguments ----
#
source(paste0(dirname(dirname(root)), "/01_boot_framework.R"))



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


if(!testDirectoryExists(paste0(dataDir,"processed/"))){
  dir.create(paste0(dataDir,"processed/"))
}


# load metadata ----
#


# run scripts ----
#
## miscellaneous input ----
# source(paste0(modlDir, "src/00_prepare_basis.R"))

## climate ----
# call 'CHELSA_climate-01-download.sh' manually in console
# source(paste0(modlDir, "src/CHELSA_bio-01-postprocess.R"))
# source(paste0(modlDir, "src/CHELSA_climate-02-annualise.R"))

## soil ----
# source(paste0(modlDir, "src/soilMoisture-01-postprocess.R"))
# source(paste0(modlDir, "src/soilGrids-04-postprocess.R"))

## terrain ----

## socio-economic ----
source(paste0(modlDir, "src/FAOSTAT_indicators-01-rasterise.R"))
source(paste0(modlDir, "src/WORLDBANK_indicators-01-rasterise.R"))
