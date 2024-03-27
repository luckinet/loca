# script description ----
#
# This is the main script for preparing all gridded layers for modelling in LOCA.
#
## authors
# Steffen Ehrmann, Ruben Remelgado
#
## version
# 0.0.3
#
## documentation
# file.edit(paste0(dir_docs, "/documentation/03_prepare_gridded_layers.md"))


# construct basic global layers ----
#
source(paste0(dir_mdl03, "src/01_construct_global_basis.R"))

# construct model-specific layers ----
#
source(paste0(dir_mdl03, "src/02_construct_model_basis.R"))

# construct specific global layers ----
#
source(paste0(dir_mdl03, "src/03_process_landcover.R"))

# rasterize vector data ----
#
source(paste0(dir_mdl03, "src/04_rasterize_gadm.R"))
source(paste0(dir_mdl03, "src/04_rasterize_occurrences.R"))

source(paste0(dir_mdl03, "src/04_rasterize_faostat_indicators.R"))
source(paste0(dir_mdl03, "src/04_rasterize_worldbank_indicators.R"))
source(paste0(dir_mdl03, "src/04_rasterize_wdpa.R"))

# construct distance to objects ----
#
coastalFlats
reservoirs
river
ocean
lake

# harmonize external gridded datasets ----
#
source(paste0(dir_mdl03, "src/06_harmonize_chelsaBio.R"))
# source(paste0(dir_mdl03, "src/06_harmonize_worldclim.R"))
source(paste0(dir_mdl03, "src/06_harmonize_chelsaClimate.R")) -> does this include drySeasonLength?
source(paste0(dir_mdl03, "src/06_harmonize_soilMoisture.R"))
source(paste0(dir_mdl03, "src/06_harmonize_soilGrids.R"))

# ... ----

