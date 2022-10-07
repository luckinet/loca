# author and date of creation ----
#
# Tsvetelina Tomova, 09.09.2021

# script description ----
#
# This script looks through all Taiwanese files and preprocess them.

# load packages ----
library(luckiTools)
library(arealDB)
library(tabshiftr)
library(magrittr)
library(dplyr)
library(readr)
library(tidyr)
library(readxl)


# set path
DBDir <- "I:/MAS/01_projects/LUCKINet/01_data/censusDB/incoming/per_nation/Ukraine/raw/ukrstat/"

outDir <- ("I:/MAS/01_projects/LUCKINet/01_data/censusDB/incoming/per_nation/Ukraine/csv/")

dataukr <- read_xls(paste0(DBDir, "rosl_1991-2020_ue.xls"))

dataurkPlant <- dataukr[c(2:34),]
value <- dataurkPlant[1, 7]
dataurkPlant <- dataurkPlant[c(2:33),]
dataurkPlant[1,7] <- value
names(dataurkPlant)[1] <- "year"
# dataurkPlant$year <- gsub("^(\\d{5}).*$", "", as.character(c(2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021)))

write.csv(dataurkPlant, paste0(outDir, "ukr_cropsPlant.csv"))

dataukrProd <- dataukr[c(40:72),]
write.csv(dataukrProd, paste0(outDir, "ukr_cropsProd.csv"))

dataukrYield <- dataukr[c(78:110),]
write.csv(dataukrYield, paste0(outDir, "ukr_cropsYield.csv"))

