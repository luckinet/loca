# author and date of creation ----
#
# Steffen Ehrmann, 13.09.2021


# script description ----
#
# This document serves as a protocol, documenting the process of building the
# database of point data for LUCKINet.


# load packages ----
#
library(tabshiftr)
library(geometr)
library(tidyverse)
library(checkmate)
library(bibtex)


# script arguments ----
#
thisDataset <- ""


# reference ----
#
bib <- read.bib(file = "references.bib")[thisDataset]
assertClass(x = bib, classes = "bibentry")


# read dataset ----
#
# paste0(DBDir, "input/", thisDataset, "/")

# harmonise data ----
#
# clean input

# make points and attributes table

# make a point geom and set the attribute table
geom <- points %>%
  gs_point() %>%
  setFeatures(table = attributes)


# write output ----
#
saveRDS(object = geom,
        file = paste0(DBDir, "output/", thisDataset, ".rds"))
