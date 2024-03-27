# script description ----
#
# This is script gathers all other scripts that produce some sort of
# visualization.
#
## authors
# Steffen Ehrmann
#
## version
# 1.0.0
#
## documentation
# file.edit(paste0(dir_docs, "/documentation/10_make_visuals.md"))


# run scripts ----
#
source(paste0(modlDir, "src/esalc_landcover_areas.R"))
source(paste0(modlDir, "src/fao_landcover_areas.R"))
source(paste0(modlDir, "src/census_availability.R"))
source(paste0(modlDir, "src/census_patterns.R"))
source(paste0(modlDir, "src/occurrence_availability.R"))
source(paste0(modlDir, "src/occurrence_patterns.R"))

