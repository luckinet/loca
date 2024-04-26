# ----
# title        : GPW model profiel
# version      : 1.0.0
# description  : This is the script for setting up the model profile for the GPW project (currently only areal database).
# license      : https://creativecommons.org/licenses/by-sa/4.0/
# authors      : Steffen Ehrmann
# date         : 2024-04-03
# documentation: file.edit(paste0(dir_docs, "/documentation/00_loca.md"))
# ----

# set authors ----
#
authors <- list(cre = "Steffen Ehrmann",
                aut = NULL,
                ctb = list(census = c("Katya Perez Guzman", "Ivelina Georgieva"),
                           ontology = c("Nathália Monteiro Teles")))

# set license ----
#
model_license <- "https://www.gnu.org/licenses/gpl-3.0.txt"
data_license <- "https://creativecommons.org/licenses/by-sa/4.0/"

license <- list(model = model_license,
                data = data_license)

# set model dimensions ----
#
pixel_size <- c(xres = 0.008333333333333333218, yres = 0.008333333333333333218)
tile_size <- c(10, 10)
model_extent <-  c(xmin = -180, xmax = 180, ymin = -90, ymax = 90)
model_years <- c(2000:2020)

par <- list(years = model_years,
            extent = model_extent,
            pixel_size = pixel_size,
            tile_size = tile_size)

# set model paths ----
#
pth_inputData <- NULL

pth_ontology <- list(directory = dir_onto,
                     ontology = path_onto, gazetteer = path_gaz)

pth_grids <- NULL

pth_census <- list(directory = dir_census,
                   input = c(), output = c())

pth_occurrence <- NULL

pth_suitability <- NULL

pth_initialLanduse <- NULL

pth_allocation <- NULL

pth <- list(input = pth_inputData,
            ontology = pth_ontology,
            grid_data = pth_grids,
            census_data = pth_census,
            occurrence_data = pth_occurrence,
            suitability_maps = pth_suitability,
            initial_landuse_map = pth_initialLanduse,
            allocation_maps = pth_allocation)

# determine domains to model ----
#
mdl <- list(crops = FALSE,
            landuse = TRUE,
            livestock = TRUE,
            tech = FALSE,
            socioEco = FALSE)

# write output ----
#
# This also creates the directory `~/work_dir/name_version` that will contain
# all the temporary data items and the file `~/work_dir/name_version.RData`
# that contains the profile information.
#
.write_profile(name = model_name,
               version = model_version,
               authors = authors,
               license = license,
               parameters = par,
               modules = mdl,
               paths = pth)

load(path_profile)
