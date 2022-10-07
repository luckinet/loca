# author ----
#
# Steffen Ehrmann


# version ----
# 1.0.0 (May 2022)


# script description ----
#


# load packages ----
#
# module load foss/2019b R/4.0.0-2
library(luckiTools)
library(tidyverse)
library(sf)
library(terra)


# set paths ----
#
projDir <- select_path(idivnb283 = "/home/se87kuhe/idiv-mount/groups/MAS/01_projects/LUCKINet/",
                       HOMEBASE = "I:/groups/MAS/01_projects/LUCKINet/",
                       default = "/gpfs1/data/idiv_meyer/01_projects/LUCKINet/")
modlDir <- paste0(projDir, "03_data_evaluation/analyse_input/")

dataDir <- paste0(projDir, "01_data/")
gridDir <- "/gpfs1/data/idiv_meyer/00_data/processed"


# script arguments ----
#
profile <- load_profile(root = dataDir, name = "sandbox", version = "0.1.0")


# load metadata ----
#


# run scripts ----
#
source(paste0(modlDir, "src/esalc_landcover_areas.R"))
source(paste0(modlDir, "src/fao_landcover_areas.R"))

