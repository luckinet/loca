# script description ----
#
# This is the main script for suitability modelling within LOCA.
#
## authors
# Steffen Ehrmann, Julian Equihua

## script version
# 0.0.2
#
## documentation
# file.edit(paste0(dir_docs, "/documentation/06_suitability_modelling.md"))


# 1. run scripts ----
#
source(paste0(dir_mdl06, "src/01_sample_covariates.R"))
source(paste0(dir_mdl06, "src/02_impute_pseudoAbsences.R"))
source(paste0(dir_mdl06, "src/03_randomForest.R"))
source(paste0(dir_mdl06, "src/04_prediction.R"))
source(paste0(dir_mdl06, "src/05_postprocessing.R"))
source(paste0(dir_mdl06, "src/99_test-output.R"))
