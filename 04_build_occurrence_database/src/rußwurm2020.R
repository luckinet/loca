# ----
# geography : France
# period    : 2017 - 2018
# typology  :
#   - cover  : VEGETATED
#   - use    : crops
# features  : -
# data type : areal
# doi/url   : https://doi.org/10.5194/isprs-archives-XLIII-B2-2020-1545-2020
# authors   : Steffen Ehrmann
# date      : 2024-04-24
# status    : done
# comment   : the data source mentioned in the paper was scrutinized for further data and it turns out that these are the same data as in schneider2023. Since I need to harmonise everything with the LUCKINet ontology, I download the raw data and handle them in the script "france_rpg.R"
# ----

thisDataset <- "rußwurm2020"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr_wip, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, "isprs-archives-XLIII-B2-2020-1545-2020.bib"))
