# script description ----
#
# This is the main script for configuring and running CLUMondo to allocate
# land-use statistics in space and time.


# authors ----
#
# Steffen Ehrmann


# script arguments ----
#
currentModule <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))
source(paste0(dirname(currentModule), "/01_boot_framework.R"))


# load metadata ----
#
profile <- load_profile(root = dataDir, name = model_name, version = model_version)
files <- load_filenames(profile = profile)


# run scripts ----
#

