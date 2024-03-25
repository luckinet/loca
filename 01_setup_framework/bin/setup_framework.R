# script description ----
#
# In this script all the housekeeping is carried out that is required to set up
# the framework for its next run.

## authors ----
# Steffen Ehrmann

## script version ----
# 1.0.0

## documentation ----
#  file.edit(paste0(dir_docs, "/documentation/01 framework.md"))

## open tasks and change-log ----
# file.edit(paste0(dir_docs, "/milestones/01 setup framework.md"))

# run scripts ----
#
# source(paste0(dir_mdl01, "src/01_model_profile_luckinet.R"))
source(paste0(dir_mdl01, "src/01_model_profile_gpw.R"))
source(paste0(dir_mdl01, "src/02_prepare_input_data.R"))
source(paste0(dir_mdl01, "src/03_make_countries.R")) needs harmonizing/fixing

source(paste0(dir_mdl01, "src/99_test-output.R")) needs revision
