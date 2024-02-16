# script description ----
#
# In this script all the housekeeping is carried out that is required to set up
# the framework for its next run.

## authors ----
# Steffen Ehrmann

## script version ----
# 1.0.0

## documentation ----
#  file.edit(paste0(projDocs, "/documentation/01 framework.md"))

## open tasks and change-log ----
# file.edit(paste0(projDocs, "/milestones/01 setup framework.md"))


# run scripts ----
#
source(paste0(mdl01, "src/01_validate_boot_parameters.R"))
source(paste0(mdl01, "src/02_make_countries.R")) needs harmonizing/fixing


