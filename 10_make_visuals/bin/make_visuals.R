# ----
# title        : make visuals (module 10)
# version      : 0.4.0
# description  : In this script all other scripts are gathered that produce some sort of visualization.
# license      : https://creativecommons.org/licenses/by-sa/4.0/
# authors      : Steffen Ehrmann
# date         : 2024-03-27
documentation: file.edit(paste0(dir_docs, "/documentation/10_make_visuals.md"))
# ----

source(paste0(dir_mdl10, "src/esalc_landcover_areas.R"))
source(paste0(dir_mdl10, "src/fao_landcover_areas.R"))
source(paste0(dir_mdl10, "src/census_availability.R"))
source(paste0(dir_mdl10, "src/census_patterns.R"))
source(paste0(dir_mdl10, "src/occurrence_availability.R"))
source(paste0(dir_mdl10, "src/occurrence_patterns.R"))

