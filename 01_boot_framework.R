# script description ----
#
# This is the main script of the LUCKINet land-use time-series (LUTS) project


# authors ----
#
# Steffen Ehrmann


# version ----
#
model_name <- "euro"
model_version <- "0.0.9999"
model_years <- c(2010:2020)
model_extent <-  c(-31.26819, 40.21807, 27.63736, 82.5375)


# install packages ----
#
# install.packages(c("terra", "sf", "gdalUtilities", "parzer))
# install.packages("tidyverse", "ggplot2")
# install.packages("checkmate")
# install.packages(c("shiny", "shinythemes", "leaflet"))
# install.packages(c("arealDB", "tabshiftr", "ontologics", "geometr"))

# devtools::install_github("luckinet/tabshiftr")
# devtools::install_github("luckinet/ontologics")
# devtools::install_github("luckinet/arealDB")

# load packages ----
#
# cluster resources
# module load foss/2020b R/4.0.4-2
# source /home/$USER/myPy/bin/activate

# utils
library(beepr)
library(clipr)
library(Rcpp)
library(handlr)
library(bibtex)
library(readxl)
library(rlang)

# data management
library(tidyverse, warn.conflicts = FALSE)
library(lubridate, warn.conflicts = FALSE)
library(checkmate)
library(arealDB, warn.conflicts = FALSE)
library(tabshiftr)
library(ontologics)
# library(queuebee)

# database access
library(eurostat)

# geospatial
library(gdalUtilities)
library(terra, warn.conflicts = FALSE)
library(sf, warn.conflicts = FALSE)
# library(stars)
library(geometr, warn.conflicts = FALSE)
library(CoordinateCleaner)
library(parzer)

# modelling
library(randomForest, warn.conflicts = FALSE)


# Cluster parameters ----
#
# terraOptions(tempdir = "work/ehrmann/Rtmp/", memmax = 16)
# array <- as.integer(Sys.getenv('SLURM_ARRAY_TASK_ID')) # use this code to grab the array ID for iterating through this script depending on the array. This basically means that the for-loop is opened and looped through by the cluster/array and with this code I get the current iterator.
#SBATCH --array=1-28 #  open the array in the bash script as such


# load custom functions ----
#
# currentModule <- dont store this variable here, it's taken from the scrip that calls boot_framework
source(paste0(dirname(currentModule), "/02_boot_functions.R"))


# set paths ----
#
# main directory
projDir <- select_path(#idivnb283 = "/home/se87kuhe/idiv-mount/groups/MAS/01_projects/luca/",
                       idivnb283 = "/media/se87kuhe/external1/projekte/loca/",
                       # idivnb283 = "/home/se87kuhe/Documents/projekte/luca/",
                       # HOMEBASE = "I:/groups/MAS/01_projects/luca/",
                       HOMEBASE = "C:/Daten (F)/projekte/loca/",
                       `LAPTOP-QI7VRALS` = "I:/MAS/01_projects/luca/",
                       IDIVNB53 = "I:/MAS/01_projects/luca/",
                       IDIVTS02 = "I:/MAS/01_projects/luca/",
                       frontend1 = "/data/idiv_meyer/01_projects/luca/")

# data
dataDir <- paste0(projDir, "00_data/")

# modules
mdl01 <- paste0(projDir, "01_setup_framework/")
mdl02 <- paste0(projDir, "02_build_ontology/")
mdl0301 <- paste0(projDir, "03_build_census_database/")
mdl0302 <- paste0(projDir, "03_build_occurrence_database/")
mdl0303 <- paste0(projDir, "03_prepare_gridded_layers/")
mdl04 <- paste0(projDir, "04_suitability_modelling/")
mdl05 <- paste0(projDir, "05_build_initial_landuse/")
mdl06 <- paste0(projDir, "06_allocation_modelling/")
mdl07 <- paste0(projDir, "07_output_validation/")
mdl08 <- paste0(projDir, "08_visualisation/")

# drivers and other gridded layers
gridDir <- "/gpfs1/data/idiv_meyer/00_data/processed"

# ontology and gazetteer
ontoDir <- paste0(dataDir, "tables/luckiOnto.rds")
gazDir <- paste0(dataDir, "tables/gazetteer.rds")

# databases
censusDBDir <- paste0(dataDir, "censusDB/")
occurrenceDBDir <- paste0(dataDir, "occurrenceDB/")
gridDBDir <- paste0(dataDir, "gridDB")
gadmDir <- paste0(dataDir, "/input/gadm36_levels.gpkg")
countryDir <- paste0(dataDir, "/input/countries.rds")
workingFiles <- paste0(dataDir, "input/workingFiles.csv")
# location of the point database by Caterina: /gpfs1/data/idiv_meyer/01_projects/Caterina/LUCKINet_collaboration/data/point_database_15092020

