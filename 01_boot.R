# script description ----
#
# This is the main script of the LUCKINet land-use time-series (LUTS) project

# authors ----
# Steffen Ehrmann

# script version ----
# 1.0.0
model_name <- "euroSandbox"
model_version <- "0.1.0"

# documentation ----
projDir <- paste0(dirname(rstudioapi::getActiveDocumentContext()$path), "/")
# file.edit(paste0(projDir, "/01_model_profile_setup.rmd"))

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

#modelling ----
# library(randomForest, warn.conflicts = FALSE)

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
source(paste0(projDir, "/01_load_functions.R"))

# define paths ----
#
message("\n---- loading paths ----")
projDocs <- .select_path(idivnb609.usr.idiv.de = "/home/se87kuhe/Dokumente/Cerebrum Extra/ehrmann_20220309/projects/LUCKINet/",
                         HOMEBASE = "C:/Users/steff/Documents/Cerebrum Extra/ehrmann_20220309/projects/LUCKINet/")

## to modules ----
mdl01 <- paste0(projDir, "01_setup_framework/")
mdl02 <- paste0(projDir, "02_build_ontology/")
mdl03 <- paste0(projDir, "03_prepare_gridded_layers/")
mdl04 <- paste0(projDir, "04_build_census_database/")
mdl05 <- paste0(projDir, "05_build_occurrence_database/")
mdl06 <- paste0(projDir, "06_suitability_modelling/")
mdl07 <- paste0(projDir, "07_build_initial_landuse/")
mdl08 <- paste0(projDir, "08_allocation_modelling/")
mdl09 <- paste0(projDir, "09_output_validation/")
mdl10 <- paste0(projDir, "10_visualisation/")

## to data directories ----
data_dir <- paste0(projDir, "00_data/")
input_dir <- paste0(data_dir, "01_input/")
onto_dir <- paste0(data_dir, "02_ontology/")
grid_dir <- paste0(data_dir, "03_gridded_data/")
census_dir <- paste0(data_dir, "04_census_data/")
occurr_dir <- paste0(data_dir, "05_occurrence_data/")
suit_dir <- paste0(data_dir, "06_suitability_maps/")
iniLand_dir <- paste0(data_dir, "07_initial_landuse_maps/")
alloc_dir <- paste0(data_dir, "08_allocation_maps/")
valid_dir <- paste0(data_dir, "09_model_validation/")
output_dir <- paste0(data_dir, "10_output/")
work_dir <- paste0(data_dir, "99_work/")

## to files ----
gadm360_path <- paste0(input_dir, "gadm36_levels.gpkg")
gadm410_path <- paste0(input_dir, "gadm_410-levels.gpkg")
geoscheme_path <- paste0(input_dir, "UNSD — Methodology.csv")
onto_path <- paste0(onto_dir, "lucki_onto.rds")
gaz_path <- paste0(onto_dir, "lucki_gazetteer.rds")
tmpl_pxls_path <- paste0(grid_dir, "output/lucki_templatePixels.tif")
msk_mdlrgn_path <- paste0(grid_dir, "output/lucki_maskModelregion.tif")
msk_rstrc_path <- paste0(grid_dir, "output/lucki_maskRestricted_YEAR.tif")
poly_ahID1_path <- paste0(grid_dir, "lucki_territories_level1.gpkg")
map_ahID1_path <- paste0(grid_dir, "output/lucki_territories_level1.tif")
map_ahID2_path <- paste0(grid_dir, "output/lucki_territories_level2.tif")
map_ahID3_path <- paste0(grid_dir, "output/lucki_territories_level3.tif")
map_ahID4_path <- paste0(grid_dir, "output/lucki_territories_level4.tif")
map_ahID5_path <- paste0(grid_dir, "output/lucki_territories_level5.tif")
map_ahID6_path <- paste0(grid_dir, "output/lucki_territories_level6.tif")
map_suit_path <- paste0(suit_dir, "lucki_suitability_LUCR_YEAR.tif")
map_lusp_path <- paste0(alloc_dir, "lucki_luSubProp_LUCR_YEAR.tif")

# drivers and other gridded layers
# gridDir <- "/gpfs1/data/idiv_meyer/00_data/processed"
# location of the point database by Caterina: /gpfs1/data/idiv_meyer/01_projects/Caterina/LUCKINet_collaboration/data/point_database_15092020

# create directories ----
#
message("\n---- creating directories ----")
dir.create(data_dir, showWarnings = FALSE)
dir.create(input_dir, showWarnings = FALSE)
dir.create(onto_dir, showWarnings = FALSE)
dir.create(census_dir, showWarnings = FALSE)
dir.create(occurr_dir, showWarnings = FALSE)
dir.create(grid_dir, showWarnings = FALSE)
dir.create(suit_dir, showWarnings = FALSE)
dir.create(iniLand_dir, showWarnings = FALSE)
dir.create(alloc_dir, showWarnings = FALSE)
dir.create(valid_dir, showWarnings = FALSE)
dir.create(output_dir, showWarnings = FALSE)
dir.create(work_dir, showWarnings = FALSE)

# setup model parameters ----
#
message("\n---- load model parameters ----")
source(paste0(projDir, "/01_model_profile.R"))

load(profile_path)
