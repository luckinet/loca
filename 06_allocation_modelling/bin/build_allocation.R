# script description ----
#
# This is the main script for configuring and running CLUMondo to allocate
# land-use statistics in space and time.


# authors ----
#
# Steffen Ehrmann, Carsten Meyer


# Documentation ----
#
root <- dirname(dirname(rstudioapi::getSourceEditorContext()$path))
getOption("viewer")(rmarkdown::render(input = paste0(root, "/README.md")))


# script arguments ----
#
source(paste0(dirname(dirname(root)), "/01_boot_framework.R"))


# load metadata ----
#
profile <- load_profile(root = dataDir, name = model_name, version = model_version)
files <- load_filenames(profile = profile)


# run scripts ----
#

