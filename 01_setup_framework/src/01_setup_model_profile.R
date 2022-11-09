# script arguments ----
#
message("\n---- model run profile ----")


# load metadata ----
#
gaz <- load_ontology(path = gazDir)
countries <- get_concept(x = tibble(has_broader = c(".005.001", ".005.002", ".005.003", ".005.004")), ontology = gaz) %>%
  pull(label)

# load data ----
#
message(" --> specify covariates")
covNames <- c(# "meElevation_30as/elevationMeanLand",
  # "meElevation_30as/slopeMean",  # ignore, because it's a "round" continuum
  "iGHS/pop",
  "CHELSA_climate/yearMaxTemperature",
  "CHELSA_climate/yearMinTemperature",
  # "CHELSA_tClimate/yearMean",
  # "CHELSA_pClimate/drySeasonLength",
  "CHELSA_climate/yearTotalPrecipitation",
  # "CHELSA_pClimate/yearMin",
  # "CHELSA_pClimate/yearMax",
  "travelTime/hoursTo50000ha"#,
  # "soilMap/soilDepthMean",
  # "CCI_landCover_agg/forest",
  # "CCI_landCover_agg/grassland",
  # "CCI_landCover_agg/shrubland",
  # "CCI_landCover_agg/agriculture",
  # "iGSW_30as/permanent",
  # "iGSW_30as/seasonal",
  # "linearDistance_30as/coastalFlats",
  # "linearDistance_30as/reservoirs",
  # "linearDistance_30as/river",
  # "linearDistance_30as/ocean",
  # "linearDistance_30as/lake"
)

# ... countries to get in-situ points from
toGetOccurrence <- countries

# ... the sandbox countries
toGetCensus <- countries

# ... the target years of the sandbox use-case


# data processing ----
#
# message(" --> set up landuse-landcover relationship")
# lc_limits <- tibble(landcover = rep(c("Cropland_lc", "Forest_lc", "Meadow_lc", "Other_lc"), each = 4),
#                     lcID = rep(c(10, 20, 30, 40), each = 4),
#                     luckinetID = as.character(rep(c(1120, 1122, 1124, 1126), 4)),
#                     short = rep(c("crop", "forest", "grazing", "other"), 4),
#                     min = c(0.5, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0),
#                     max = c(1, 0.5, 0.5, 0.5, 0.5, 1, 0.5, 0.5, 0.5, 0.5, 1, 0.5, 0, 0, 0, 1))

message(" --> make profile")
params <- list(years = model_years,
               extent = model_extent,
               pixel_size = c(0.008333333333333333218, 0.008333333333333333218),
               tile_size = c(10, 10),
               censusDB_dir = NULL,
               censusDB_extent = toGetCensus,
               occurrenceDB_dir = NULL,
               occurrenceDB_extent = toGetOccurrence,
               landcover = "CCI_landCover/landCover",
               suitability_predictors = covNames)


# write output ----
#
write_profile(root = dataDir, name = model_name, version = model_version, parameters = params)
# saveRDS(object = lc_limits, paste0(dataDir, "run/", name, "_", version, "/tables/landcover_limits_", name, "_", version, ".rds"))


# beep(sound = 10)
message("---- done ----")
