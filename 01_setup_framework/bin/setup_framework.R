# script description ----
#
# In this script all the housekeeping is carried out that is required to set up
# the framework for its next run.


# authors ----
#
# Steffen Ehrmann


# Documentation ----
#
currentModule <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))
getOption("viewer")(rmarkdown::render(input = paste0(currentModule, "/README.md")))


# script arguments ----
#
source(paste0(dirname(currentModule), "/01_boot_framework.R"))


# run scripts ----
#
source(paste0(mdl01, "src/01_setup_model_profile.R"))

profile <- load_profile(root = dataDir, name = model_name, version = model_version)
files <- load_filenames(profile = profile)

source(paste0(mdl01, "src/02_prepare_spatial_basis.R")) continue here with cleaning

