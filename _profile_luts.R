# ----
# title        : LUTS model profile
# version      : 1.0.0
# description  : This is the script for setting up the model profile for LUTS, the LUCKNet land-use time-series.
# license      : https://creativecommons.org/licenses/by-sa/4.0/
# authors      : Steffen Ehrmann
# date         : 2024-04-03
# documentation: file.edit(paste0(dir_docs, "/documentation/00_loca.md"))
# ----

path_profile <- str_replace(string = path_profile, pattern = "VER", replacement = paste0(model_name, "_", model_version))

# set authors ----
#
authors <- list(cre = "Steffen Ehrmann",
                aut = list(census = c("Tsvetelina Tomova"),
                           occurrence = c("Peter Pothmann")),
                ctb = list(census = c("Annika Ertel", "Peter Pothmann",
                                      "Felipe Melges", "Evgeniya Elkina",
                                      "Abdualmaged Al-Hemiary", "Yang Xueqing",
                                      "Katya Perez Guzman"),
                           occurrence = c("Caterina Barasso", "Ruben Remelgado"),
                           ontology = c("Nathália Monteiro Teles")))

# set license ----
#
model_licence <- "https://www.gnu.org/licenses/gpl-3.0.txt"
data_licence <- "https://creativecommons.org/licenses/by-sa/4.0/"

license <- list(model = model_licence,
                data = data_licence)

# set model dimensions ----
#
pixel_size <- c(xres = 0.008333333333333333218, yres = 0.008333333333333333218)
tile_size <- c(10, 10)
model_extent <-  c(xmin = -31.26819, xmax = 40.21807, ymin = 27.63736, ymax = 82.5375)
model_years <- c(2000:2020)

par <- list(years = model_years,
            extent = model_extent,
            pixel_size = pixel_size,
            tile_size = tile_size)

# set model paths ----
#
pth_inputData <- list(directory = dir_framework_mdl)

pth_ontology <- list(directory = dir_onto_mdl)

pth_census <- list(directory = dir_census_mdl)

pth_occurrence <- list(directory = dir_occur_mdl)

pth_grids <- list(directory = dir_grid_mdl)

pth_suitability <- list(directory = dir_suit_mdl)

pth_initialLanduse <- list(directory = dir_init_mdl)

pth_allocation <- list(directory = dir_alloc_mdl)

pth <- list(ontology = pth_ontology,
            grid_data = pth_grids,
            census_data = pth_census,
            occurrence_data = pth_occurrence,
            suitability_maps = pth_suitability,
            initial_landuse_map = pth_initialLanduse,
            allocation_maps = pth_allocation)

# determine domains to model ----
#
mdl <- list(crops = TRUE,
            landuse = TRUE,
            livestock = FALSE,
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


# other left-over code ----
# lc_limits <- tibble(landcover = rep(c("Cropland_lc", "Forest_lc", "Meadow_lc", "Other_lc"), each = 4),
#                     lcID = rep(c(10, 20, 30, 40), each = 4),
#                     luckinetID = as.character(rep(c(1120, 1122, 1124, 1126), 4)),
#                     short = rep(c("crop", "forest", "grazing", "other"), 4),
#                     min = c(0.5, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0),
#                     max = c(1, 0.5, 0.5, 0.5, 0.5, 1, 0.5, 0.5, 0.5, 0.5, 1, 0.5, 0, 0, 0, 1))

# covNames <- c(
#   "meElevation_30as/elevationMeanLand",
#   "iGHS_POP/GHSP",
#   "CHELSA_tClimate/yearMax",
#   "CHELSA_tClimate/yearMin",
#   "CHELSA_tClimate/yearMean",
#   "CHELSA_pClimate/drySeasonLength",
#   "CHELSA_pClimate/yearTotal",
#   "CHELSA_pClimate/yearMin",
#   "CHELSA_pClimate/yearMax",
#   "travelTime/travelTime",
#   "soilMap/soilDepthMean",
#   "CCI_landCover_agg/forest",
#   "CCI_landCover_agg/grassland",
#   "CCI_landCover_agg/shrubland",
#   "CCI_landCover_agg/agriculture",
#   "iGSW_30as/permanent",
#   "iGSW_30as/seasonal",
#   "linearDistance_30as/coastalFlats",
#   "linearDistance_30as/reservoirs",
#   "linearDistance_30as/river",
#   "linearDistance_30as/ocean",
#   "linearDistance_30as/lake"
# )

# bibentry(
#   bibtype = "Misc",
#   key = "ehrmann2024",
#   title = "LUCKINet overall computation algorithm (LOCA)",
#   author = c(
#     person(given = "Steffen", family = "Ehrmann",
#            role = c("aut", "cre"),
#            email = "steffen.ehrmann@idiv.de",
#            comment = c(ORCID = "0000-0002-2958-0796")),
#     person(given = "Carsten", family = "Meyer",
#            role = c("aut"),
#            email = "carsten.meyer@idiv.de",
#            comment = c(ORCID="0000-0003-3927-5856"))
#   ),
#   organization = "Macroecology and Society Lab @iDiv",
#   year = 2024,
#   url = "https://www.idiv.de/de/luckinet.html")
