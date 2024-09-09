# ----
# title       : determine the model run
# description : In this script you determine which model shall be carried out by the current model run
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-08-04
# version     : 1.0.0
# status      : done
# comment     : file.edit(paste0(dir_docs, "/documentation/00_loca.md"))
# ----

# model version ----
#
model_name <- "gpw"
model_version <- "0.7.0"

source(paste0(dir_proj, "_profile/", model_name, ".R"))

rm(list = c("authors", "domains", "license", "modules", "par", "path_profile"))
