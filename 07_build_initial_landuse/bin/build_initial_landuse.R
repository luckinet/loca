# script description ----
#
#
currentModule <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))

## author ----
# Steffen Ehrmann

## version ----
# ?

## documentation ----
getOption("viewer")(rmarkdown::render(input = paste0(currentModule, "/README.md")))

## open tasks and change-log ----
file.edit(paste0(projDocs, "/LUCKINet/milestones/05 build initial land-use map.md"))


# 0. setup ----
#
profile <- load_profile(root = dataDir, name = model_name, version = model_version)
files <- load_filenames(profile = profile)


source(paste0(dirname(currentModule), "/01_boot_framework.R"))


# 1. run scripts ----
#
source(paste0(mdl07, "src/....R"))

