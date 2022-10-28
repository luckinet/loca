# script description ----
#
# This is the main script for building the LUCKINet commodity ontology and
# territory gazetteer.


# authors ----
#
# Steffen Ehrmann, Arne Rümmler, Carsten Meyer


# version ----
# 1.0.0 (September 2022)


# Documentation ----
#
currentModule <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))
getOption("viewer")(rmarkdown::render(input = paste0(currentModule, "/README.md")))


# script arguments ----
#
source(paste0(dirname(currentModule), "/01_boot_framework.R"))


# run scripts ----
#
source(paste0(mdl02, "src/01_make_landuse-ontology.R"))
source(paste0(mdl02, "src/02_make_gazetteer.R")) this has a problem with the description when mapping the gadm concepts into the gazetteer at line 109
source(paste0(mdl02, "src/99_test-output.R"))

