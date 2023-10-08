# This script test all input objects that should be available at the beginning
# of the 04_build_initial_landuse module.
message("\n---- test inputs ----")


# load metadata ----
#
files <- make_filenames(profile = profile, module = "initial landuse", step = "all")


# data processing ----
#

# the census satistics
#
# TODO: test country area vs sum of all landuse classes (adapt census in case there
# is deviation)
message(" --> testing census stats")
census_init <- readRDS(file = files$census) %>%
  filter(year == profile$years[1])

expect_data_frame(x = census_init, any.missing = FALSE)
expect_names(x = names(census_init), must.include = c("geoID", "year", "nation", "ahID", "ahLevel", "term", "luckinetID", "area"))
target_ids <- census_init %>%
  filter(area != 0) %>%
  distinct(luckinetID) %>%
  pull(luckinetID)


# the landcover limits
message(" --> testing landcover limits")
lc_limits <- readRDS(file = files$landcover_limits)
expect_data_frame(x = lc_limits, any.missing = FALSE)
expect_names(x = names(lc_limits), must.include = c("landcover", "lcID", "luckinetID", "short", "min", "max"))
expect_subset(x = unique(lc_limits$luckinetID), choices = unique(census_init$luckinetID))


# the bounding box and its tiles
message(" --> testing tiles")
tiles <- st_read(dsn = paste0(profile$dir, "/visualise/tiles.gpkg"), quiet = TRUE)
target_tiles <- which(tiles$target)


# landcover raster
message(" --> testing landcover layer")
mp_cover <- rast(x = str_replace(files$landcover, "_Y_", paste0("_", profile$years[1], "_")))
# test that resolution and extent match the profile
expect_true(all(res(mp_cover) == profile$pixel_size))
expect_true(all(getExtent(tiles) == getExtent(x = mp_cover)))
# test that values match the lcID specified in landcover limits
expect_subset(x = unique(values(mp_cover)), choices = unique(lc_limits$lcID))


# territorial units raster
message(" --> testing territorial units layer")
mp_ahID <- rast(x = files$ahID)
# test that resolution and extent match the profile
expect_true(all(res(mp_ahID) == profile$pixel_size))
expect_true(all(getExtent(tiles) == getExtent(x = mp_ahID)))
# test that values match the ahIDs specified in census
expect_subset(x = unique(values(mp_ahID)), choices = unique(census_init$ahID))


# pixel areas raster
message(" --> testing pixel area layer")
mp_area <- rast(x = files$pixelArea)
# test that resolution and extent match the profile
expect_true(all(res(mp_area) == profile$pixel_size))
expect_true(all(getExtent(tiles) == getExtent(x = mp_area)))


# restricted areas raster
message(" --> testing restricted areas layer")
mp_rest <- rast(x = files$areaRestricted)
# test that resolution and extent match the profile
expect_true(all(res(mp_rest) == profile$pixel_size))
expect_true(all(getExtent(tiles) == getExtent(x = mp_rest)))
# test that all values are between 0 and 1
expect_numeric(x = values(x = mp_rest), lower = 0, upper = 1, all.missing = FALSE)


# suitability layers
message(" --> testing suitability layers")
mp_suit <- rast(x = str_replace(files$suit_X_Y_Z, "_X_Y_Z_", paste0("_", target_ids, "_", profile$years[1], "_", target_tiles, "_")))
# test that resolution and extent match the profile
expect_true(all(res(mp_suit) == profile$pixel_size))
expect_true(all(getExtent(tiles) == getExtent(x = mp_suit)))

# test that all values are between 0 and 1
for(i in 1:dim(mp_suit)[3]){
  message("     <> '", target_ids[i], "'")
  ras <- mp_suit[[i]]

  vals <- values(x = ras) %>% as_tibble()
  # make sure there are at least two values other than 0 to scale between
  vals_without_null <- unique(vals) %>% filter(layer != 0) %>% pull(layer)
  expect_numeric(x = vals_without_null, min.len = 2)
  expect_numeric(x = vals %>% pull(layer), lower = 0, upper = 1, all.missing = FALSE)
}

mp_suit <- mp_suit %>%
  stats::setNames(paste0(target_ids, " suit"))

# test that all layers add up to 1
vals <- round(values(x = sum(mp_suit)), 6)
expect_subset(x = vals, choices = 1)


# write output ----
#
# visualise(mp_cover, theme = myTheme)
# visualise(mp_ahID, theme = myTheme)
# visualise(mp_area, theme = myTheme)
# visualise(mp_rest, theme = myTheme)
# visualise(mp_suit, theme = myTheme)


beep(sound = 10)
message("---- done ----")
