# ----
# title       : make visuals
# description : In this script all other scripts are gathered that produce some sort of visualization.
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-03-27
# version     : 0.4.0
# status      : working
# comment     : file.edit(paste0(dir_docs, "/documentation/10_make_visuals.md"))
# ----

# set module-specific paths ----
#
dir_visuals <- .get_path("vis")
dir_visuals_data <- .get_path("vis", data = "")


# run scripts ----
#
source(paste0(dir_visuals, "esalc_landcover_areas.R"))
source(paste0(dir_visuals, "fao_landcover_areas.R"))
source(paste0(dir_visuals, "census_availability.R"))
source(paste0(dir_visuals, "census_patterns.R"))
source(paste0(dir_visuals, "occurrence_availability.R"))
source(paste0(dir_visuals, "occurrence_patterns.R"))

