https://datafinder.stats.govt.nz/
https://www.stats.govt.nz/large-datasets/csv-files-for-download/
https://www.stats.govt.nz/about-us/stats-nz-archive-website/
https://cdm20045.contentdm.oclc.org/digital?page=1
https://www.stats.govt.nz/publications?filters=Agricultural%20production%20statistics%2CInformation%20releases&start=0

# author and date of creation ----
#
# Jack Boyce, 23.12.2021

# script description ----
#
# This script preprocesses the New Zealand Department of the Environment data.

# load packages ----
library(readr)
library(purrr)
library(stringr)
library(tidyr)
library(dplyr, warn.conflicts = FALSE)

# set paths
dataPath_NZ_Ag_Hort_Land_Use_02_19 <- 'I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/new_zealand/mfe-agricultural-and-horticultural-land-use-clean-2002-2019-CSV/agricultural-and-horticultural-land-use-clean-2002-2019.csvt'
  NZ_Ag_Hort_Land_Use_02_19 <- read.csv(dataPath_NZ_Ag_Hort_Land_Use_02_19)

dataPath_NZ_Irrigated_Land_Use_02_19 <- 'I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/new_zealand/mfe-irrigated-land-clean-2002-2019-CSV/irrigated-land-clean-2002-2019.csvt'
  NZ_Irrigated_Land_Use_02_19 <- read.csv(dataPath_NZ_Irrigated_Land_Use_02_19)

dataPath_NZ_Livestock_1971_2017 <- 'I:/MAS/01_projects/LUCKINet/01_data/areal_data/censusDB_global/adb_tables/incoming/per_nation/new_zealand/mfe-livestock-numbers-clean-1971-2019-CSV/livestock-numbers-clean-1971-2019.csvt'
  NZ_Livestock_1971_2017 <- read.csv(dataPath_NZ_Livestock_1971_2017)

# load metadata

