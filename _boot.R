# ----
# title       : boot loca
# description : This is the main script that boots LOCA, the LUCKINet overall computation algorithm to build the LUCKINet land-use time-series (LUTS).
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-08-04
# version     : 1.0.0
# status      : done
# comment     : file.edit(paste0(dir_docs, "/documentation/_loca.md"))
# ----

# load packages ----
#
message("\n---- loading packages ----")

## utils ----
.libPaths(c("~/rLib", .libPaths()))
library(beepr)
library(Rcpp)
library(bibtex)
library(readxl)
library(xlsx)
library(rvest)
library(xml2)
library(rlang)
library(fuzzyjoin)
library(progress)
library(arrow)
library(tidytext)
library(archive)

## data management ----
library(tidyverse, warn.conflicts = FALSE)
library(lubridate, warn.conflicts = FALSE)
library(checkmate)
library(arealDB)
library(tabshiftr)
library(ontologics)
library(bitfield)

## database access ----
library(eurostat)

## geospatial ----
library(gdalUtilities)
library(terra, warn.conflicts = FALSE)
library(sf, warn.conflicts = FALSE)
library(parzer)

## modelling ----
# library(randomForest, warn.conflicts = FALSE)

## visuals ----
library(ggthemes)


# load active directory ----
#
dir_proj <- paste0(rstudioapi::getActiveProject(), "/")
# dir_data <- "/home/se87kuhe/share/groups/mas_data/loca/"
dir_data <- dir_proj


# load custom functions ----
#
message("\n---- loading custom functions ----")
source(paste0(dir_proj, "/_functions.R"))
source(paste0(dir_proj, "/_licenses.R"))

options(error = function() beep(9))


# define paths ----
#
message("\n---- loading paths ----")
dir_docs <- .select_path(idivnb609.usr.idiv.de = "/home/se87kuhe/Dokumente/Cerebrum Extra/ehrmann_20220309/projects/LUCKINet/",
                         HOMEBASE = "C:/Users/steff/Documents/Cerebrum Extra/ehrmann_20220309/projects/LUCKINet/")

# build model profile ----
#
model_name <- "gpw" # luts, gpw
source(paste0(dir_proj, "_profile/", model_name, ".R"))
