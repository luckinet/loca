# script description ----
#
# This is the main script for prepareing all gridded layers for modelling in LUCA.


# authors ----
#
# Steffen Ehrmann


# script arguments ----
#
currentModule <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))
source(paste0(dirname(currentModule), "/01_boot_framework.R"))


# start database and set some meta information ----
#
if(!testDirectoryExists(gridDBDir)){
  start_gridDB(root = gridDBDir)
}


# load metadata ----
#
profile <- load_profile(root = dataDir, name = model_name, version = model_version)
files <- load_filenames(profile = profile)
# template <- rast(xmin = -180, xmax = 180, ymin = -90, ymax = 90, ncols = 43200, nrows = 21600)


# run scripts ----
#
## miscellaneous input ----
# source(paste0(mdl0303, "src/00_prepare_basis.R"))

## climate ----
# call 'CHELSA_climate-01-download.sh' manually in console
# source(paste0(mdl0303, "src/CHELSA_bio-01-postprocess.R"))
# source(paste0(mdl0303, "src/CHELSA_climate-02-annualise.R"))
source(paste0(mdl0303, "src/WorldClim.R"))

## soil ----
# source(paste0(mdl0303, "src/soilMoisture-01-postprocess.R"))
# source(paste0(mdl0303, "src/soilGrids-04-postprocess.R"))

## terrain ----

## socio-economic ----
# source(paste0(mdl0303, "src/FAOSTAT_indicators-01-rasterise.R"))
# source(paste0(mdl0303, "src/WORLDBANK_indicators-01-rasterise.R"))
