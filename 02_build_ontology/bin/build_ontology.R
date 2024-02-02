# script description ----
#
# This is the main script for building the LUCKINet commodity ontology and
# territory gazetteer.

## author ----
# Steffen Ehrmann, Arne Rümmler, Carsten Meyer

## version ----
# 1.0.0

## documentation ----
# getOption("viewer")(rmarkdown::render(input = paste0(dirname(dirname(rstudioapi::getActiveDocumentContext()$path)), "/README.md")))

## open tasks and change-log ----
# file.edit(paste0(projDocs, "/LUCKINet/milestones/02 build ontology.md"))


# run scripts ----
#
source(paste0(mdl02, "src/01_make_ontology.R"))
source(paste0(mdl02, "src/02_harmonise_ontology_concepts.R"))
source(paste0(mdl02, "src/03_make_gazetteer.R"))
source(paste0(mdl02, "src/04_harmonise_gazetteer_concepts.R"))

