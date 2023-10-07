# script description ----
#
# In this script all the housekeeping is carried out that is required to set up
# the framework for its next run.

## author ----
# Steffen Ehrmann

## version ----
# 1.0.0

## documentation ----
# getOption("viewer")(rmarkdown::render(input = paste0(currentModule, "/README.md")))

## open tasks and change-log ----
# file.edit(paste0(projDocs, "/LUCKINet/milestones/01 setup framework.md"))


# run scripts ----
#
source(paste0(mdl01, "src/01_validate_boot_parameters.R"))
source(paste0(mdl01, "src/02_setup_model_profile.R"))
