# ----
# title       : LUTS model profile
# description : This is the script for setting up the model profile for LUTS, the LUCKNet land-use time-series.
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-08-04
# version     : 1.0.0
# status      : done
# comment     : file.edit(paste0(dir_docs, "/documentation/_loca.md"))
# ----

# adapt the version, whenever changes are made on this file
model_version <- "0.1.0"

# set authors ----
#
authors <- list(cre = list("Steffen Ehrmann"),
                aut = list(cens = c("Tsvetelina Tomova"),
                           occu = c("Peter Pothmann"),
                           suit = c("Julián Equihua")),
                ctb = list(onto = c("Nathália Monteiro Teles"),
                           cens = c("Annika Ertel", "Peter Pothmann",
                                    "Felipe Melges", "Evgeniya Elkina",
                                    "Abdualmaged Al-Hemiary", "Yang Xueqing",
                                    "Katya Perez Guzman"),
                           occu = c("Caterina Barasso", "Ruben Remelgado"),
                           grid = c("Ruben Remelgado")))

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
modules <- list(onto = "mdl_build_ontology",
                cens = "mdl_build_census_database",
                occu = "mdl_build_occurrence_database",
                grid = "mdl_prepare_gridded_layers",
                suit = "mdl_suitability_modelling",
                inlan = "mdl_build_initial_landuse",
                alloc = "mdl_allocation_modelling",
                valid = "mdl_output_validation",
                vis = "mdl_make_visuals")

# determine domains to model ----
#
domains <- list(crops = TRUE,
                landuse = TRUE,
                livestock = FALSE,
                tech = FALSE,
                socioEco = FALSE)

# set sub-modules ----
#
submodules <- list(onto = c("make_ontology", "make_gazetteer"),
                   cens = c("fao", "brazil", "denmark", "germany", "ukraine",
                            "indonesia"),
                   occu = c("bastin2017", "bayas2017", "bayas2021", "cropharvest",
                            "fritz2017", "garcia2022", "gfsad30", "gofc-gold",
                            "jolivot2021", "lesiv2020", "lucas", "schepaschenko",
                            "see2016", "see2022", "stanimirova2023"),
                   grid = list(landcover = c("cciLandcover"),
                               elevation = c("meritDEM"),
                               irradiance = c(NULL),
                               topology = c("linearDistance"),
                               climate = c("chelsaBio", "chelsaClimate"),
                               soil = c("soilGrids", "soilMoisture"),
                               vegetation = c(NULL),
                               population = c("popDens", "faoStat"),
                               landuse = c("wdpa"),
                               economic = c("nightLights", "travelTime", "worldBank")))

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
