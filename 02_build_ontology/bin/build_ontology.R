# script description ----
#
# This is the main script for building the LUCKINet commodity ontology and
# territory gazetteer.


# authors ----
#
# Steffen Ehrmann, Arne Rümmler, Carsten Meyer


# version ----
# 1.0.0 (September 2022)


# script arguments ----
#
currentModule <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))
source(paste0(dirname(currentModule), "/01_boot_framework.R"))


# run scripts ----
#
source(paste0(mdl02, "src/01_make_landuse-ontology.R"))
source(paste0(mdl02, "src/02_make_gazetteer_v360.R"))
# source(paste0(mdl02, "src/02_make_gazetteer_v410.R"))
source(paste0(mdl02, "src/99_test-output.R"))

