# ----
# title        : build initial landuse (module 7)
# authors      : Steffen Ehrmann
# version      : 0.1.0
# date         : 2024-03-27
# description  : This is the main script for building an initial land-use map,
#                i.e., a map of the first year based on which further allocation
#                is carried out.
# documentation: file.edit(paste0(dir_docs, "/documentation/07_build_initial_landuse.md"))
# ----


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

source(paste0(dir_mdl07, "src/00_test-input.R"))
source(paste0(dir_mdl07, "src/01_determine_landuse-limits.R"))
source(paste0(dir_mdl07, "src/02_determine_suitability-ranges.R"))
source(paste0(dir_mdl07, "src/03_pre-allocate.R"))
source(paste0(dir_mdl07, "src/04_determine_correction-factors.R"))
source(paste0(dir_mdl07, "src/05_allocate.R"))
source(paste0(dir_mdl07, "src/06_test-output.R"))

