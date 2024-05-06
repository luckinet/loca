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


# set paths ----
#
projDir <- select_path(idivnb283 = "/home/se87kuhe/idiv-mount/groups/MAS/01_projects/LUCKINet/",
                       HOMEBASE = "I:/groups/MAS/01_projects/LUCKINet/",
                       default = "/gpfs1/data/idiv_meyer/01_projects/LUCKINet/")
modlDir <- paste0(projDir, "02_data_processing/03_data_evaluation/analyse_output/")

dataDir <- paste0(projDir, "01_data/")


# script arguments ----
#


# load metadata ----
#


# run scripts ----
#
source(paste0(dir_val_mdl, "src/census_availability.R"))
source(paste0(dir_val_mdl, "src/census_patterns.R"))
source(paste0(dir_val_mdl, "src/occurrence_availability.R"))
source(paste0(dir_val_mdl, "src/occurrence_patterns.R"))

