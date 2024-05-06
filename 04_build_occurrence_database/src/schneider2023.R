# ----
# geography : Europe
# period    : 2020 - 2021
# typology  :
#   - cover  : VEGETATED
#   - use    : crops
# features  : -
# sample    : _INSERT
# doi/url   : https://doi.org/10.1038/s41597-023-02517-0, https://doi.org/10.5281/zenodo.10118572
# license   : https://creativecommons.org/licenses/by-sa/4.0/
# disclosed : yes
# authors   : Steffen Ehrmann
# date      : 2024-04-24
# status    : done
# comment   : as this database does not provide raw data and as we need to harmonize the labels with the LUCKINet ontology, we download and process each dataset again from the raw data if the download is still available, such as in the scripts "rpg_france.R" (from source), "lpis_slovenia.R" (from source), "lpis_estonia.R" (2023 from source), "lpis_czechia" (from source), "lpis_denmark.R" (from source), "lpis_croatia.R" (from source), "lpis_austria.R" (from source) and "".
# ----

thisDataset <- "schneider2023"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(dir_occurr_wip, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, "10.1038_s41597-023-02517-0-citation.bib"))


handle latvia 2021
handle estonia 2021
