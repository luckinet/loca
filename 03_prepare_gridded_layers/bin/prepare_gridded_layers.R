# ----
# title        : prepare gridded layers (module 3)
# version      : 0.3.0
# description  : This is the main script for preparing all gridded layers for modelling LUTS
# license      : https://creativecommons.org/licenses/by-sa/4.0/
# authors      : Ruben Remelgado, Steffen Ehrmann
# date         : 2024-03-27
# documentation: file.edit(paste0(dir_docs, "/documentation/03_prepare_gridded_layers.md"))
# ----

source(paste0(dir_mdl03, "src/01_construct_global_basis.R"))
source(paste0(dir_mdl03, "src/02_construct_model_basis.R"))
source(paste0(dir_mdl03, "src/03_process_landcover.R"))

source(paste0(dir_mdl03, "src/04_rasterize_gadm.R"))
source(paste0(dir_mdl03, "src/04_rasterize_occurrences.R"))
source(paste0(dir_mdl03, "src/04_rasterize_faostat_indicators.R"))
source(paste0(dir_mdl03, "src/04_rasterize_worldbank_indicators.R"))
source(paste0(dir_mdl03, "src/04_rasterize_wdpa.R"))

coastalFlats
reservoirs
river
ocean
lake

source(paste0(dir_mdl03, "src/06_harmonize_chelsaBio.R"))
# source(paste0(dir_mdl03, "src/06_harmonize_worldclim.R"))
source(paste0(dir_mdl03, "src/06_harmonize_chelsaClimate.R")) -> does this include drySeasonLength?
source(paste0(dir_mdl03, "src/06_harmonize_soilMoisture.R"))
source(paste0(dir_mdl03, "src/06_harmonize_soilGrids.R"))

