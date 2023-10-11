message("\n---- setup model profile ----")


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
               tile_size = c(10, 10))


# write output ----
#
write_profile(name = model_name, version = model_version, parameters = params)
# saveRDS(object = lc_limits, paste0(dataDir, "run/", name, "_", version, "/tables/landcover_limits_", name, "_", version, ".rds"))


# beep(sound = 10)
message("     ... done")
