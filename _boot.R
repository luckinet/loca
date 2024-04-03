# ----
# title        : boot loca
# version      : 1.0.0
# description  : This is the main script that boots LOCA, the LUCKINet overall computation algorithm to build the LUCKINet land-use time-series (LUTS).
# license      : https://creativecommons.org/licenses/by-sa/4.0/
# authors      : Steffen Ehrmann
# date         : 2024-03-28
# documentation: file.edit(paste0(dir_docs, "/documentation/00_loca.md"))
# ----

# model version ----
model_name <- "gpw"
model_version <- "0.3.0"

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

# define paths ----
#
message("\n---- loading paths ----")
dir_docs <- .select_path(idivnb609.usr.idiv.de = "/home/se87kuhe/Dokumente/Cerebrum Extra/ehrmann_20220309/projects/LUCKINet/",
                         HOMEBASE = "C:/Users/steff/Documents/Cerebrum Extra/ehrmann_20220309/projects/LUCKINet/")

## to modules ----
dir_mdl01 <- paste0(dir_proj, "01_setup_framework/")
dir_mdl02 <- paste0(dir_proj, "02_build_ontology/")
dir_mdl03 <- paste0(dir_proj, "03_prepare_gridded_layers/")
dir_mdl04 <- paste0(dir_proj, "04_build_census_database/")
dir_mdl05 <- paste0(dir_proj, "05_build_occurrence_database/")
dir_mdl06 <- paste0(dir_proj, "06_suitability_modelling/")
dir_mdl07 <- paste0(dir_proj, "07_build_initial_landuse/")
dir_mdl08 <- paste0(dir_proj, "08_allocation_modelling/")
dir_mdl09 <- paste0(dir_proj, "09_output_validation/")
dir_mdl10 <- paste0(dir_proj, "10_make_visuals/")

## to data directories ----
dir_data <- paste0(dir_proj, "00_data/")
dir_input <- paste0(dir_data, "01_input/")
dir_onto <- paste0(dir_data, "02_ontology/")
dir_grid <- paste0(dir_data, "03_gridded_data/")
dir_census <- paste0(dir_data, "04_census_data/")
dir_occurr <- paste0(dir_data, "05_occurrence_data/")
dir_suit <- paste0(dir_data, "06_suitability_maps/")
dir_iniLand <- paste0(dir_data, "07_initial_landuse_maps/")
dir_alloc <- paste0(dir_data, "08_allocation_maps/")
dir_valid <- paste0(dir_data, "09_model_validation/")
dir_output <- paste0(dir_data, "10_output/")
dir_work <- paste0(dir_data, "99_work/", model_name, "_", model_version, "/")

## to files ----
path_gadm360 <- paste0(dir_input, "gadm36_levels.gpkg")
path_gadm410 <- paste0(dir_input, "gadm_410-levels.gpkg")
path_geoscheme <- paste0(dir_input, "UNSD — Methodology.csv")

path_geoscheme_gadm <- paste0(dir_onto, "geoscheme_to_gadm.rds")
path_onto <- paste0(dir_onto, "lucki_onto.rds")
path_onto_odb <- paste0(dir_occurr, "meta/lucki_onto.rds")
path_onto_adb <- paste0(dir_census, "meta/lucki_onto.rds")
path_gaz <- paste0(dir_onto, "lucki_gazetteer.rds")

path_template <- paste0(dir_grid, "pixel_template.tif")
path_landcover <- paste0(dir_grid, "cci_landcover_yr{YR}.tif")
path_ahID <- paste0(dir_grid, "gadm_admin_lvl{LVL}.tif")

path_profile <- paste0(dir_work, "model_info.RData")
path_cellSize <- paste0(dir_work, "lucki_cellSize.tif")
path_modelregion <- paste0(dir_work, "lucki_modelregion.tif")
path_ahID_model <- paste0(dir_work, "lucki_admin_lvl{LVL}.tif")
path_landcover_model <- paste0(dir_work, "lucki_landcover_yr{YR}.tif")
path_restricted <- paste0(dir_work, "lucki_restrictedCells_yr{YR}.tif")
path_occurrence <- paste0(dir_work, "lucki_occ_cncp{CNCP}_yr{YR}.tif")

path_suitability <- paste0(dir_suit, "lucki_suit_cncp{CNCP}_yr{YR}.tif")

path_allocation <- paste0(dir_alloc, "lucki_alloc_cncp{CNCP}_yr{YR}.tif")

# create directories ----
#
message("\n---- creating directories ----")
dir.create(dir_data, showWarnings = FALSE)
dir.create(dir_input, showWarnings = FALSE)
dir.create(dir_onto, showWarnings = FALSE)
dir.create(dir_census, showWarnings = FALSE)
dir.create(dir_occurr, showWarnings = FALSE)
dir.create(dir_grid, showWarnings = FALSE)
dir.create(dir_suit, showWarnings = FALSE)
dir.create(dir_iniLand, showWarnings = FALSE)
dir.create(dir_alloc, showWarnings = FALSE)
dir.create(dir_valid, showWarnings = FALSE)
dir.create(dir_output, showWarnings = FALSE)
dir.create(dir_work, showWarnings = FALSE)

# build model parameters ----
#
source(paste0(dir_proj, "_profile_", model_name, ".R"))
