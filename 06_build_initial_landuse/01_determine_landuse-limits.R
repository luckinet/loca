# ----
# title        : determine landuse-limits
# authors      : Steffen Ehrmann
# version      : 0.9.0
# date         : 2024-03-27
# description  : This script determines the landuse limits based on the input
#                landcover dataset.
# documentation: -
# ----
message("\n---- determine landuse limits ----")

# 1. make paths ----
#
files <- make_filenames(profile = profile, module = "initial landuse", step = "landuse limits")

# 2. load data ----
#
lc_limits <- readRDS(file = files$landcover_limits)

census_init <- readRDS(file = files$census) %>%
  left_join(lc_limits %>% select(luckinetID, short) %>% distinct(), by = "luckinetID") %>%
  filter(year == profile$years[1])

target_ids <- census_init %>%
  filter(area != 0) %>%
  distinct(luckinetID) %>%
  pull(luckinetID)

mp_cover <- rast(x = str_replace(files$landcover_Y, "_Y_", paste0("_", profile$years[1], "_")))

# 3. data processing ----
#
## _INSERT ----
# for each landuse class ...
for(j in seq_along(target_ids)){

  lu_data <- census_init %>%
    filter(luckinetID == target_ids[j])
  luID <- paste0("_", unique(lu_data$luckinetID), "_")
  luShort <- unique(lu_data$short)

  message(" --> processing landuse '", luShort, "' --")

  reclass <- lc_limits %>%
    filter(luckinetID == target_ids[j])

  # ... replace landcover with the respective landuse minimum and maximum
  classify(mp_cover, reclass %>% dplyr::select(lcID, min),
           filename = str_replace(files$LUMin_X, "_X_", luID),
           overwrite = TRUE,
           filetype = "GTiff",
           datatype = "FLT4S")
  classify(mp_cover, reclass %>% dplyr::select(lcID, max),
           filename = str_replace(files$LUMax_X, "_X_", luID),
           overwrite = TRUE,
           filetype = "GTiff",
           datatype = "FLT4S")

  # update landuse limits with restricted areas would theoretically be done like
  # that, however, since I don't know exactly how to penalise the ESA LC (reduce
  # the maximum or minimum? both with 50%? Or with another distribution, and if
  # so, depending on what?), I don't do it in that case. Just leaving this code
  # in, in case in some future version this might be required
  #
  # mp_temp <- rast(str_replace(files$LUMax_X, "_X_", luID))
  # mp_temp <- ifel(1 - mp_temp < mp_rest, mp_temp - mp_rest, mp_temp)
  # writeRaster(x = mp_temp,
  #             filename = str_replace(files$LUMax_X, "_X_", luID),
  #             overwrite = TRUE,
  #             filetype = "GTiff",
  #             datatype = "FLT4S")


}

# 4. write output ----
#
write_rds(x = _INSERT, file = _INSERT)

# beep(sound = 10)
message("\n     ... done")
