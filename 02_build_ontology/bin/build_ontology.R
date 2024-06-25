# ----
# title       : build ontology (module 2)
# description : This is the main script for building the LUCKINet commodity ontology and territory gazetteer.
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-03-27
# version     : 1.0.0
# status      : done (luts), done (gpw)
# comment     : file.edit(paste0(dir_docs, "/documentation/02_build_ontology.md"))
# ----

source(paste0(dir_onto_mdl, "src/01_make_ontology.R"))
source(paste0(dir_onto_mdl, "src/02_harmonise_ontology_concepts.R"))
source(paste0(dir_onto_mdl, "src/03_make_gazetteer.R"))
source(paste0(dir_onto_mdl, "src/04_harmonise_gazetteer_concepts.R"))

