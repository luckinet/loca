# script description ----
#
# This is the main script for building an initial land-use map, i.e., a map of
# the first year based on which further allocation is carried out.

## author ----
# Steffen Ehrmann

## version ----
# ?
profile <- load_profile(name = model_name, version = model_version)

## documentation ----
# file.edit(paste0(projDocs, "/documentation/05 initial land-use map.md"))

## open tasks and change-log ----
# file.edit(paste0(projDocs, "/LUCKINet/milestones/05 build initial land-use map.md"))


### for building and debugging (remove when this module is finished) ###
# myTheme <- gtTheme
# diffTheme <- setTheme(parameters = list(colours = c("#CC0000F0", "#FFFFFFFF", "#00204DFF")))
# generate_input(module = "initial landuse", dir = dataDir,
#                landcover = 2, landuse = 2, territories = 1,
#                dVal = c(4000, 6000),
#                adT = "horizontal",
#                withRestr = FALSE,
#                withUrban = FALSE)
### ---------------------------------------------------------------- ###

# 1. run scripts ----
#
source(paste0(mdl07, "src/00_test-input.R"))
source(paste0(mdl07, "src/01_determine_landuse-limits.R"))
source(paste0(mdl07, "src/02_determine_suitability-ranges.R"))
source(paste0(mdl07, "src/03_pre-allocate.R"))
source(paste0(mdl07, "src/04_determine_correction-factors.R"))
source(paste0(mdl07, "src/05_allocate.R"))
source(paste0(mdl07, "src/06_test-output.R"))

