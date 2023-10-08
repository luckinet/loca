# This script carries out pre-allocation to derive the suitability weighted
# supply and its ESA LC compliant bounds based on landuse limits.
message("\n---- pre-allocate ----")


# load packages ----
#


# load metadata ----
#
files <- make_filenames(profile = profile, module = "initial landuse", step = "pre-allocate")

lc_limits <- readRDS(file = files$landcover_limits)


# load data ----
#
# initial landuse census
census_init <- readRDS(file = files$census) %>%
  left_join(lc_limits %>% select(luckinetID, short) %>% distinct(), by = "luckinetID") %>%
  filter(year == profile$years[1])

target_ids <- census_init %>%
  filter(area != 0) %>%
  distinct(luckinetID) %>%
  pull(luckinetID)


# data processing ----
#
# for each landuse class ...
for(j in seq_along(target_ids)){

  lu_data <- census_init %>%
    filter(luckinetID == target_ids[j])
  luID <- paste0("_", unique(lu_data$luckinetID), "_")
  luShort <- unique(lu_data$short)

  message(" --> processing '", luShort, "' --")

  # message("   ... calculating minimum supply")
  # mp_temp <- rast(x = str_replace(files$LUMin_X, "_X_", luID))
  # mp_temp <- mp_temp * mp_area
  #
  # writeRaster(mp_temp,
  #             filename = str_replace(files$supplyMin_X, "_X_", luID),
  #             overwrite = TRUE,
  #             filetype = "GTiff",
  #             datatype = "FLT4S")
  #
  # message("   ... calculating maximum supply")
  # mp_temp <- rast(x = str_replace(files$LUMax_X, "_X_", luID))
  # mp_temp <- mp_temp * mp_area
  #
  # writeRaster(mp_temp,
  #             filename = str_replace(files$supplyMax_X, "_X_", luID),
  #             overwrite = TRUE,
  #             filetype = "GTiff",
  #             datatype = "FLT4S")

  message("     ... calculating suitability weighted supply")

  mp_suit <- rast(x = str_replace(files$suit_X_Y, "_X_Y_", paste0(luID, profile$years[1], "_")))
  mp_minLU <- rast(x = str_replace(files$LUMin_X, "_X_", luID))
  mp_maxLU <- rast(x = str_replace(files$LUMax_X, "_X_", luID))
  mp_minSuit <- rast(x = str_replace(files$suitMin_X, "_X_", luID))
  mp_maxSuit <- rast(x = str_replace(files$suitMax_X, "_X_", luID))

  # scale suitability between ESA landcover minimum and maximum
  #         (x - min)
  # f(x) = ----------- * (b-a) + a; with a = new min and b = new max
  #         max - min
  mp_temp <- ((mp_suit - mp_minSuit) * (mp_maxLU - mp_minLU)) / (mp_maxSuit - mp_minSuit) + mp_minLU
  writeRaster(x = mp_temp,
              filename = str_replace(files$supplySuitWeight_X, "_X_", luID),
              overwrite = TRUE,
              filetype = "GTiff",
              datatype = "FLT4S")

}


# write output ----
#
beep(sound = 10)
message("---- done ----")


