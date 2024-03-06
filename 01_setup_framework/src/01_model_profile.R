# script description ----
#
# This is the script for setting up the model profile for LOCA (LUCKINet overall
# computation algorithm).

# set authors ----
#
authors <- list(cre = "Steffen Ehrmann",
                aut = list(census = c("Tsvetelina Tomova"),
                           occurrence = c("Peter Pothmann")),
                ctb = list(census = c("Annika Ertel", "Peter Pothmann",
                                      "Felipe Melges", "Evgeniya Elkina",
                                      "Abdualmaged Al-Hemiary", "Yang Xueqing"),
                           occurrence = c("Caterina Barasso", "Ruben Remelgado")))

# set license ----
#
model_license <- "https://www.gnu.org/licenses/gpl-3.0.txt"
data_license <- "https://creativecommons.org/licenses/by-sa/4.0/"

license <- list(model = model_license,
                data = data_license)

# set model dimensions ----
#
pixel_size <- c(0.008333333333333333218, 0.008333333333333333218)
tile_size <- c(10, 10)
model_extent <-  c(-31.26819, 40.21807, 27.63736, 82.5375)
model_years <- c(2000:2020)

par <- list(years = model_years,
            extent = model_extent,
            pixel_size = pixel_size,
            tile_size = tile_size)

# set model paths ----
#
mdl_inputData <- list(directory = dir_input,
                      spatial = path_gadm360, geoscheme = path_geoscheme,
                      raster_template = path_template,
                      model_mask = path_modelregion)

mdl_ontology <- list(directory = dir_onto,
                     ontology = path_onto, gazetteer = path_gaz)

mdl_grids <- list(directory = dir_grid,
                  layers = c())

mdl_census <- list(directory = dir_census,
                   input = c(), output = c())

mdl_occurrence <- list(directory = dir_occurr,
                       input = c(), output = c())

mdl_suitability <- list(directory = dir_suit,
                        drivers = c(), output = path_suitability)

mdl_initialLanduse <- list(directory = dir_iniLand,
                           input = c(), output = c())

mdl_allocation <- list(directory = dir_alloc,
                       input = c(), output = path_allocation)

mdl <- list(ontology = mdl_ontology,
            grid_data = mdl_grids,
            census_data = mdl_census,
            occurrence_data = mdl_occurrence,
            suitability_maps = mdl_suitability,
            initial_landuse_map = mdl_initialLanduse,
            allocation_maps = mdl_allocation)

# write output ----
#
# This also creates the directory `~/work_dir/name_version` that will contain
# all the temporary data items and the file `~/work_dir/name_version.RData`
# that contains the profile information.
#
if(!testFileExists(x = path_profile)){
  .write_profile(name = model_name,
                 version = model_version,
                 authors = authors,
                 license = license,
                 parameters = par,
                 modules = mdl)
}


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

