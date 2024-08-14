# ----
# title       : prepare gridded layers
# description : This is the main script for preparing all gridded layers for modelling LUTS
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann, Ruben Remelgado, Luise
# date        : 2024-03-27
# version     : 0.3.0
# status      : working
# comment     : file.edit(paste0(dir_docs, "/documentation/03_prepare_gridded_layers.md"))
# ----

adapt the scripts so that they work with original names
add metadata to register properly

# set module-specific paths ----
#
dir_grid <- .get_path("grid")
dir_grid_data <- .get_path("grid", "_data")
dir_onto_data <- .get_path("onto", "_data")

path_onto <- paste0(dir_onto_data, "lucki_onto.rds")
path_gadm <- paste0(dir_onto_data, "gadm36_levels.gpkg") # paste0(dir_onto_data, "gadm_410-levels.gpkg")
path_template <- paste0(dir_grid_data, "template_", model_name, "_", model_version, ".tif")
path_modelregion <- paste0(dir_grid_data, "modelregion_", model_name, "_", model_version, ".tif")
path_cellSize <- paste0(dir_grid_data, "cellSize_", model_name, "_", model_version, ".tif")

# start database and set some meta information ----
#
adb_init(root = dir_grid_data, version = paste0(model_name, model_version),
         staged = FALSE,
         licence = "https://creativecommons.org/licenses/by-sa/4.0/",
         ontology = list("use" = path_onto, "cover" = path_onto),
         author = list(cre = model_info$authors$cre,
                       aut = model_info$authors$aut$grids,
                       ctb = model_info$authors$ctb$grids))

# run scripts ----
#
source(paste0(dir_grid, "01_global_basis.R"))
source(paste0(dir_grid, "02_model_basis.R"))

# rasterize polygon datasets ----
#
# source(paste0(dir_grid, "03_faostatIndicators.R"))
# source(paste0(dir_grid, "03_gadm.R"))
# source(paste0(dir_grid, "03_iucn.R"))
source(paste0(dir_grid, "03_linearDistance.R"))
# source(paste0(dir_grid, "03_occurrences.R"))
# source(paste0(dir_grid, "03_worldbankIndicators.R"))

# harmonize external gridded datasets ----
#
source(paste0(dir_grid, "04_cciLandcover.R"))
source(paste0(dir_grid, "04_chelsaBio.R"))
source(paste0(dir_grid, "04_chelsaClimate.R"))
source(paste0(dir_grid, "04_dmsp.R"))
source(paste0(dir_grid, "04_iGHS.R"))
source(paste0(dir_grid, "04_mertiDEM.R"))
source(paste0(dir_grid, "04_soilGrids.R"))
source(paste0(dir_grid, "04_soilMoisture.R"))
source(paste0(dir_grid, "04_travelTime.R"))
# source(paste0(dir_grid, "04_worldclim.R"))
