# author and date of creation ----
#
# Steffen Ehrmann, 13.09.2021
# Peter Pothmann, 15.11.2021


# script description ----
#
# This document serves as a protocol, documenting the process of building the
# database of point data for LUCKINet. Don't run this script manually, as it is
# sourced from 'build_global_pointDB.R'.


# load packages ----
#


# script arguments ----
#
thisDataset <- ""
thisPath <- paste0(DBDir, "input/", thisDataset, "/")


# reference ----
#
bib <- read.bib(file = "references.bib")[thisDataset]
assertClass(x = bib, classes = "bibentry")

series <- regDataseries()


# preprocess data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#
# paste0(DBDir, "input/", thisDataset, "/")


# harmonise data ----
#
# pre-filter unneeded rows


# assign quality code


# reconstruct values ...
#
# 1. observation year

# 2. countries (ahID)

# 3. concept names (luckinetID)

# 4. spatial entity (fid)


# reorganise table/assign clean names


# before preparing data for storage, test that all variables are available
assertNames(x = names(table),
            must.include = c("fid", "x", "y", "date", "irrigated", "ahID",
                             "datasetID", "luckinetID", "externalID",
                             "externalValue", "QC", "source_type"))

# make points and attributes table
points <- temp %>%
  select(fid, x, y)

attributes <- temp %>%
  select(-x, -y)

# make a point geom and set the attribute table
geom <- points %>%
  gs_point() %>%
  setFeatures(table = attributes)


# write output ----
#
saveRDS(object = geom,
        file = paste0(DBDir, "output/", thisDataset, ".rds"))
