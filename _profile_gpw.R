# ----
# title        : GPW model profile
# version      : 1.0.0
# description  : This is the script for setting up the model profile for the GPW project (currently only areal database).
# license      : https://creativecommons.org/licenses/by-sa/4.0/
# authors      : Steffen Ehrmann
# date         : 2024-04-03
# documentation: file.edit(paste0(dir_docs, "/documentation/00_loca.md"))
# ----

path_profile <- paste0(dir_proj, "_profile/", model_name, "_", model_version, ".rds")

# set authors ----
#
authors <- list(cre = "Steffen Ehrmann",
                aut = NULL,
                ctb = list(ontology = c("Nathália Monteiro Teles"),
                           census = c("Katya Perez Guzman", "Ivelina Georgieva")))

# set license ----
#
license <- list(model = licenses$gnu,
                data = licenses$by4)

# set model dimensions ----
#
par <- list(years = c(2000:2020),
            extent = c(xmin = -180, xmax = 180, ymin = -90, ymax = 90),
            pixel_size = c(xres = 0.008333333333333333218, yres = 0.008333333333333333218),
            tile_size = c(10, 10))

# set model paths ----
#
modules <- list(onto = "01_build_ontology",
                cens = "02_build_census_database")

# determine domains to model ----
#
domains <- list(crops = FALSE,
                landuse = FALSE,
                livestock = TRUE,
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
