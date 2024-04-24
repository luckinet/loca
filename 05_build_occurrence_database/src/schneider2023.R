# ----
# geography : Europe
# period    : 2020 - 2021
# typology  :
#   - cover  : VEGETATED
#   - use    : crops
# features  : -
# sample    : _INSERT
# doi/url   : https://doi.org/10.1038/s41597-023-02517-0, https://github.com/maja601/EuroCrops
# license   : https://creativecommons.org/licenses/by-sa/4.0/
# disclosed : yes
# authors   : Steffen Ehrmann
# date      : 2024-04-24
# status    : find data, update, inventarize, validate, normalize, done
# comment   : since we are building an even bigger "Harmonized Open Crop Dataset" and not only across Europe, we need to harmonize the labels with the LUCKINet ontology and therefore download and process each dataset again from the raw data.
# ----

thisDataset <- "schneider2023"
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, "10.1038_s41597-023-02517-0-citation.bib"))
