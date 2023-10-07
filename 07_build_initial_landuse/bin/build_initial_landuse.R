# script description ----
#
#

## author ----
# Steffen Ehrmann

## version ----
# ?

## documentation ----
# getOption("viewer")(rmarkdown::render(input = paste0(dirname(dirname(rstudioapi::getActiveDocumentContext()$path)), "/README.md")))

## open tasks and change-log ----
# file.edit(paste0(projDocs, "/LUCKINet/milestones/05 build initial land-use map.md"))


# 1. load profile
#
profile <- load_profile(name = model_name, version = model_version)
files <- load_filenames(profile = profile)


# 2. run scripts ----
#
source(paste0(mdl07, "src/....R"))

