# script description ----
#
# This is the main script for suitability modelling within LOCA.

## author ----
# Steffen Ehrmann, Julian Equihua

## script version ----
# 1.0.0

## documentation ----
# file.edit(paste0(dir_docs, "/documentation/04 suitability model.md"))

## open tasks and change-log ----
# file.edit(paste0(dir_docs, "/milestones/04 model suitability.md"))


# 1. run scripts ----
#
source(paste0(dir_mdl06, "src/01_sample_covariates.R"))
source(paste0(dir_mdl06, "src/02_impute_pseudoAbsences.R"))
source(paste0(dir_mdl06, "src/03_randomForest.R"))
source(paste0(dir_mdl06, "src/04_prediction.R"))
source(paste0(dir_mdl06, "src/05_postprocessing.R"))
source(paste0(dir_mdl06, "src/99_test-output.R"))
