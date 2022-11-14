# author and date of creation ----
#
# Jack Boyce, 6.12.2021

# script description ----
#
# This script looks through all USDA files for the US data and preprocess them.

# load packages ----
library(readr)
library(purrr)
library(stringr)
library(tidyr)
library(dplyr, warn.conflicts = FALSE)

# set paths

