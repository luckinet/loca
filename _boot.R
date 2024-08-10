# ----
# title       : boot loca
# description : This is the main script that boots LOCA, the LUCKINet overall computation algorithm to build the LUCKINet land-use time-series (LUTS).
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-08-04
# version     : 1.0.0
# status      : done
# comment     : file.edit(paste0(dir_docs, "/documentation/00_loca.md"))
# ----

# model version ----
model_name <- "luts"
model_version <- "0.1.0"


# documentation ----
dir_proj <- paste0(rstudioapi::getActiveProject(), "/")


# load packages ----
#
message("\n---- loading packages ----")

## utils ----
library(beepr)
library(Rcpp)
library(bibtex)
library(readxl)
library(xlsx)
library(rlang)
library(fuzzyjoin)
library(progress)
library(arrow)
library(tidytext)
library(archive)

## data management ----
library(tidyverse, warn.conflicts = FALSE)
library(lubridate, warn.conflicts = FALSE)
library(checkmate)
library(arealDB)
library(tabshiftr)
library(ontologics)
library(bitfield)

## database access ----
library(eurostat)

## geospatial ----
library(gdalUtilities)
library(terra, warn.conflicts = FALSE)
library(sf, warn.conflicts = FALSE)
library(parzer)

## modelling ----
# library(randomForest, warn.conflicts = FALSE)

## visuals
library(ggthemes)

# hpc parameters ----
#
# module load foss/2020b R/4.0.4-2
# source /home/$USER/myPy/bin/activate
#
# terraOptions(tempdir = "work/ehrmann/Rtmp/", memmax = 16)
# array <- as.integer(Sys.getenv('SLURM_ARRAY_TASK_ID')) # use this code to grab the array ID for iterating through this script depending on the array. This basically means that the for-loop is opened and looped through by the cluster/array and with this code I get the current iterator.
# SBATCH --array=1-28 #  open the array in the bash script


# load custom functions ----
#
message("\n---- loading custom functions ----")
source(paste0(dir_proj, "/_functions.R"))

options(error = function() beep(9))

# define paths ----
#
message("\n---- loading paths ----")
dir_docs <- .select_path(idivnb609.usr.idiv.de = "/home/se87kuhe/Dokumente/Cerebrum Extra/ehrmann_20220309/projects/LUCKINet/",
                         HOMEBASE = "C:/Users/steff/Documents/Cerebrum Extra/ehrmann_20220309/projects/LUCKINet/")

# build model pipeline ----
#
source(paste0(dir_proj, "_profile_", model_name, ".R"))
