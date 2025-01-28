# ----
# title       : GPW model profile
# description : This is the script for setting up a census database for the Global Pasture Watch project.
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-09-20
# version     : 1.0.0
# status      : done
# comment     : file.edit(paste0(dir_docs, "/documentation/_loca.md"))
# ----

# adapt the version, whenever changes are made on this file
model_version <- "0.8.1"

# set authors ----
#
authors <- list(cre = list("Steffen Ehrmann"),
                aut = list(cens = c("Katya Perez Guzman")),
                ctb = list(onto = c("Nathália Monteiro Teles"),
                           cens = c("Ivelina Georgieva")))

# set license ----
#
license <- list(model = licenses$gnu,
                data = licenses$by4)

# set model dimensions ----
#
par <- list(years = c(2000:2020),
            extent = c(xmin = -180, xmax = 180, ymin = -90, ymax = 90),
            pixel_size = c(xres = 0.008333333333333333218, yres = 0.008333333333333333218),
            tile_size = c(10, 10),
            ADM_max = 3)

# set model paths ----
#
modules <- list(onto = "mdl_build_ontology",
                cens = "mdl_build_census_database")

# determine domains to model ----
#
domains <- list(crops = FALSE,
                landuse = TRUE,
                livestock = TRUE,
                tech = FALSE,
                socioEco = FALSE)

# set sub-modules ----
#
submodules <- list(onto = c("make_ontology", "make_gazetteer"),
                   cens = c("fao", "agriwanet", "eurostat", "argentina",
                            "australia", "bolivia", "brazil", "canada",
                            "colombia", "china", "denmark", "germany", "india",
                            "indonesia", "mexico", "newZealand", "norway",
                            "paraguay", "peru", "russia", "ukraine",
                            "unitedStatesOfAmerica"))

# create pipeline directories ----
#
.create_directories(root = dir_proj, modules = modules)

# write output ----
#
.write_profile(path = paste0(dir_proj, "_profile/", model_name, "_", model_version, ".rds"),
               name = model_name,
               version = model_version,
               authors = authors,
               license = license,
               parameters = par,
               domains = domains,
               modules = modules,
               submodules = submodules)

model_info <- readRDS(file = getOption("loca_profile"))

# write ODD description file ----
#
.write_odd()

# clean up ----
#
rm(list = c("authors", "domains", "license", "modules", "submodules", "par"))
