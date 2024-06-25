# ----
# title       : suitability modelling (module 6)
# description : This is the main script for suitability modelling within LOCA
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Julián Equihua, Steffen Ehrmann
# date        : 2024-03-27
# version     : 0.2.0
# status      : work in progress
# comment     : file.edit(paste0(dir_docs, "/documentation/06_suitability_modelling.md"))
# ----

source(paste0(dir_mdl06, "src/01_sample_covariates.R"))
source(paste0(dir_mdl06, "src/02_impute_pseudoAbsences.R"))
source(paste0(dir_mdl06, "src/03_randomForest.R"))
source(paste0(dir_mdl06, "src/04_prediction.R"))
source(paste0(dir_mdl06, "src/05_postprocessing.R"))
source(paste0(dir_mdl06, "src/99_test-output.R"))
