# script description ----
#
# This is the main script for suitability modelling within LUCA


# authors ----
#
# Steffen Ehrmann, Ruben Remelgado, Julian Equihua


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
source(paste0(mdl04, "src/01_sample_covariates.R"))
source(paste0(mdl04, "src/02_impute_pseudoAbsences.R"))
source(paste0(mdl04, "src/03_randomForest.R"))
source(paste0(mdl04, "src/04_prediction.R"))
source(paste0(mdl04, "src/05_postprocessing.R"))
source(paste0(mdl04, "src/99_test-output.R"))




# ToDo:
#   - weights related to relative proportion of each class
#   - distance-bias: distance as variables and samples are spatially clsutered, chcnaceare that distiance is a used as threshold that prevents the presence outside of these clusters; its the saver bet to weigh individial points by distance  (enables global usage of data, if they are properly downweighed)
#   - sampling-bias: instead of relative proportion of each class (see above), use the sampling-bias develope earlier (check script in archive)
#   - see https://stats.stackexchange.com/questions/46963/how-to-control-the-cost-of-misclassification-in-random-forests
#   - area in the random forest model is actually not the area under the pixel, but the area of the sampling unit, and it doesn't indicate how much is available, but from which "scale" the sample is taken and where it occurs
#   - does it make sense to give the vote counts instead of the probabilities in the prediction step, so that not only the relative probability of classes within each pixel is calculated, but that I can determine the relative importance of pixels within a class, giving me another way of looking at how much of the census amount to put in a pixel
#   - write code that shows me te ROC curve (https://stats.stackexchange.com/questions/2151/how-to-plot-roc-curves-in-multiclass-classification, https://www.displayr.com/what-is-a-roc-curve-how-to-interpret-it/)
#   - check out: https://www.sciencedirect.com/science/article/abs/pii/S0031320312003974
