# script description ----
#
# In this script all the housekeeping is carried out that is required to set up
# the framework for its next run.
currentModule <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))

## author ----
# Steffen Ehrmann

## version ----
# 1.0.0

## documentation ----
# getOption("viewer")(rmarkdown::render(input = paste0(currentModule, "/README.md")))

## open tasks and change-log ----
# file.edit(paste0(projDocs, "/LUCKINet/milestones/01 setup framework.md"))


# 0. setup ----
#
source(paste0(dirname(currentModule), "/01_boot_framework.R"))


# 1. run scripts ----
#
source(paste0(mdl01, "src/01_setup_model_profile.R"))

profile <- load_profile(name = model_name, version = model_version)
files <- load_filenames(profile = profile)

# source(paste0(mdl01, "src/02_make_countries.R"))
# source(paste0(mdl01, "src/03_prepare_spatial_basis.R"))

