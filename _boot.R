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
model_name <- "denmark"
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

## to modules ----
dir_framework_mdl <- paste0(dir_proj, "01_setup_framework/")
dir_onto_mdl <- paste0(dir_proj, "02_build_ontology/")
dir_census_mdl <- paste0(dir_proj, "03_build_census_database/")
dir_occur_mdl <- paste0(dir_proj, "04_build_occurrence_database/")
dir_grid_mdl <- paste0(dir_proj, "05_prepare_gridded_layers/")
dir_suit_mdl <- paste0(dir_proj, "06_suitability_modelling/")
dir_init_mdl <- paste0(dir_proj, "07_build_initial_landuse/")
dir_alloc_mdl <- paste0(dir_proj, "08_allocation_modelling/")
dir_val_mdl <- paste0(dir_proj, "09_output_validation/")
dir_vis_mdl <- paste0(dir_proj, "10_make_visuals/")

## to data directories ----
dir_data <- paste0(dir_proj, "00_data/")
dir_data_in <- paste0(dir_data, "input/")
dir_data_wip <- paste0(dir_data, "working/")
dir_data_out <- paste0(dir_data, "output/")
dir_onto_wip <- paste0(dir_data_wip, "02_ontology/")
dir_onto_out <- paste0(dir_data_out, "02_ontology/")
dir_census_wip <- paste0(dir_data_wip, "03_census_data/")
dir_census_out <- paste0(dir_data_out, "03_census_data/")
dir_occurr_wip <- paste0(dir_data_wip, "04_occurrence_data/")
dir_occurr_out <- paste0(dir_data_out, "04_occurrence_data/")
dir_grid_wip <- paste0(dir_data_wip, "05_gridded_data/")
dir_grid_out <- paste0(dir_data_out, "05_gridded_data/")
dir_suit_wip <- paste0(dir_data_wip, "06_suitabilit_maps/")
dir_suit_out <- paste0(dir_data_out, "06_suitabilit_maps/")
dir_init_wip <- paste0(dir_data_wip, "07_initial_landuse_maps/")
dir_init_out <- paste0(dir_data_out, "07_initial_landuse_maps/")
dir_alloc_wip <- paste0(dir_data_wip, "08_allocation_maps/")
dir_alloc_out <- paste0(dir_data_out, "08_allocation_maps/")
dir_val_wip <- paste0(dir_data_wip, "09_validation/")
dir_val_out <- paste0(dir_data_out, "09_validation/")

## to files ----
path_profile <- paste0(dir_data_wip, "model_info_VER.RData")
path_gadm360 <- paste0(dir_data_in, "gadm36_levels.gpkg")
path_gadm410 <- paste0(dir_data_in, "gadm_410-levels.gpkg")
path_geoscheme <- paste0(dir_data_in, "UNSD — Methodology.csv")
path_geoscheme_gadm <- paste0(dir_onto_wip, "geoscheme_to_gadm.rds")
path_onto <- paste0(dir_onto_wip, "lucki_onto.rds")
path_gaz <- paste0(dir_onto_wip, "lucki_gazetteer.rds")
path_onto_odb <- paste0(dir_occurr_wip, "meta/lucki_onto.rds")
path_onto_adb <- paste0(dir_census_wip, "meta/lucki_onto.rds")
path_template <- paste0(dir_grid_wip, "pixel_template.tif")

path_landcover_cci <- paste0(dir_grid_out, "cci_landcover/YR.tif")

path_modelregion <- paste0(dir_grid_wip, "modelregion_", model_name, "_", model_version, ".tif")
path_cellSize <- paste0(dir_grid_wip, "cellSize_", model_name, "_", model_version, ".tif")
path_ahID <- paste0(dir_grid_wip, "admin_LVL_", model_name, "_", model_version, ".tif")
path_landcover <- paste0(dir_grid_wip, "landcover_YR_", model_name, "_", model_version, ".tif")
path_restricted <- paste0(dir_grid_wip, "restrictedCells_YR_", model_name, "_", model_version, ".tif")
path_occurrence <- paste0(dir_grid_wip, "occ_CNCP_YR_", model_name, "_", model_version, ".tif")


# define the licenses ----
#
lic_jrc <- "https://data.jrc.ec.europa.eu/licence/com_reuse"
lic_gpl3 <- "https://www.gnu.org/licenses/gpl-3.0.txt"
lic_by4 <- "https://creativecommons.org/licenses/by/4.0/"
lic_byncsa3 <- "https://creativecommons.org/licenses/by-nc-sa/3.0/"
lic_cc0 <- "https://creativecommons.org/publicdomain/zero/1.0"


# build model parameters ----
#
source(paste0(dir_proj, "_profile_", model_name, ".R"))
