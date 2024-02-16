# script description ----
#
# This is the main script for preparing all gridded layers for modelling in LUCA.

## author ----
# Steffen Ehrmann

## version ----
# 1.0.0
profile <- load_profile(name = model_name, version = model_version)

## documentation ----
# file.edit(paste0(projDocs, "/documentation/03 gridded layers.md"))

## open tasks and change-log ----
# file.edit(paste0(projDocs, "/milestones/03 prepare gridded layers.md"))


# 1. start database and set some meta information ----
#
start_gridDB(root = grid_dir)



# 2. run scripts ----
#
## construct basic gridded layers ----
source(paste0(mdl03, "src/construct_basis.R"))

## rasterize vector data ----
source(paste0(mdl03, "src/rasterize_gadm.R"))
source(paste0(mdl03, "src/rasterize_census_database.R"))
source(paste0(mdl03, "src/rasterize_occurrence_database.R"))
source(paste0(mdl03, "src/rasterize_faostat_indicators.R"))
source(paste0(mdl03, "src/rasterize_worldbank_indicators.R"))
source(paste0(mdl03, "src/rasterize_wdpa.R"))

## construct restricted pixels ----
source(paste0(mdl03, "src/construct_restricted_pixels.R"))

## construct distance to objects ----
coastalFlats
reservoirs
river
ocean
lake

## harmonize external gridded datasets ----
source(paste0(mdl03, "src/harmonize_chelsaBio.R"))
# source(paste0(mdl03, "src/harmonize_worldclim.R"))
source(paste0(mdl03, "src/harmonize_chelsaClimate.R")) -> does this include drySeasonLength?
source(paste0(mdl03, "src/harmonize_soilMoisture.R"))
source(paste0(mdl03, "src/harmonize_soilGrids.R"))

## ... ----


# 3. tie everything together ----
source(paste0(mdl03, "src/98_make_database.R"))
