# ----
# title       : build ontology
# description : This is the main script for building the LUCKINet commodity ontology and territory gazetteer.
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-03-27
# version     : 1.0.0
# status      : done (luts), done (gpw)
# comment     : file.edit(paste0(dir_docs, "/documentation/02_build_ontology.md"))
# ----

# set module-specific paths ----
#
dir_onto <- .get_path("onto")
dir_onto_data <- .get_path("onto",  "_data")

path_onto <- paste0(dir_onto_data, "lucki_onto.rds")
path_gaz <- paste0(dir_onto_data, "lucki_gazetteer.rds")
path_geoschemeToGADM <-  paste0(dir_onto_data, "geoscheme_to_gadm.rds")

# run scripts ----
#
source(paste0(dir_onto, "01_make_ontology.R"))
source(paste0(dir_onto, "02_harmonise_ontology_concepts.R"))
source(paste0(dir_onto, "03_make_gazetteer.R"))
source(paste0(dir_onto, "04_harmonise_gazetteer_concepts.R"))

