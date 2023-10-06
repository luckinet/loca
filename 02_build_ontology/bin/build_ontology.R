# script description ----
#
# This is the main script for building the LUCKINet commodity ontology and
# territory gazetteer.
currentModule <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))

## author ----
# Steffen Ehrmann, Arne Rümmler, Carsten Meyer

## version ----
# 1.0.0

## documentation ----
# getOption("viewer")(rmarkdown::render(input = paste0(currentModule, "/README.md")))

## open tasks and change-log ----
# file.edit(paste0(projDocs, "/LUCKINet/milestones/02 build ontology.md"))


# 0. setup ----
#
source(paste0(dirname(currentModule), "/01_boot_framework.R"))


# 1. run scripts ----
#
source(paste0(mdl02, "src/01_make_landuse-ontology.R"))
source(paste0(mdl02, "src/02_make_gazetteer_v360.R"))
# source(paste0(mdl02, "src/02_make_gazetteer_v410.R"))
source(paste0(mdl02, "src/99_test-output.R"))

