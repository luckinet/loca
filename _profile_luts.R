# ----
# title       : LUTS model profile
# description : This is the script for setting up the model profile for LUTS, the LUCKNet land-use time-series.
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-08-04
# version     : 1.0.0
# status      : done
# comment     : file.edit(paste0(dir_docs, "/documentation/01_setup_profile.md"))
# ----

path_profile <- paste0(dir_proj, "_profile/", model_name, "_", model_version, ".rds")

# set authors ----
#
authors <- list(cre = "Steffen Ehrmann",
                aut = list(census = c("Tsvetelina Tomova"),
                           occurrence = c("Peter Pothmann"),
                           suitability = c("Julián Equihua")),
                ctb = list(ontology = c("Nathália Monteiro Teles"),
                           census = c("Annika Ertel", "Peter Pothmann",
                                      "Felipe Melges", "Evgeniya Elkina",
                                      "Abdualmaged Al-Hemiary", "Yang Xueqing",
                                      "Katya Perez Guzman"),
                           occurrence = c("Caterina Barasso", "Ruben Remelgado"),
                           grids = c("Ruben Remelgado")))

# set license ----
#
license <- list(model = licenses$gnu,
                data = licenses$by4)

# set model dimensions ----
#
par <- list(years = c(2000:2020),
            extent = c(xmin = -75, xmax = -33, ymin = -34, ymax = 5.5),
            pixel_size = c(xres = 0.008333333333333333218, yres = 0.008333333333333333218),
            tile_size = c(10, 10))

# set modules ----
#
modules <- list(onto = "01_build_ontology",
                cens = "02_build_census_database",
                occu = "03_build_occurrence_database",
                grid = "04_prepare_gridded_layers",
                suit = "05_suitability_modelling",
                inlan = "06_build_initial_landuse",
                alloc = "07_allocation_modelling",
                valid = "08_output_validation",
                vis = "09_make_visuals")

# determine domains to model ----
#
domains <- list(crops = TRUE,
                landuse = TRUE,
                livestock = FALSE,
                tech = FALSE,
                socioEco = FALSE)

# create pipeline directories ----
#
.create_directories(root = dir_proj, modules = modules)

# write output ----
#
.write_profile(path = path_profile,
               name = model_name,
               version = model_version,
               authors = authors,
               license = license,
               parameters = par,
               domains = domains,
               modules = modules)

rm(list = c("authors", "domains", "license", "modules", "par", "path_profile", "model_name", "model_version"))

model_info <- readRDS(file = getOption("loca_profile"))
