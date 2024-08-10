# ----
# title        : allocate
# authors      : Steffen Ehrmann
# version      : 0.8.0
# date         : 2024-MM-DD
# description  : _INSERT
# documentation: file.edit(paste0(dir_docs, "/documentation/_INSERT.md"))
# ----
message("\n---- allocate ----")

# 1. make paths ----
#
files <- make_filenames(profile = profile, module = "initial landuse", step = "allocate")

# 2. load data ----
#
lc_limits <- readRDS(file = files$landcover_limits)

# initial landuse level census
census_init <- readRDS(file = files$census) %>%
  left_join(lc_limits %>% select(luckinetID, short) %>% distinct(), by = "luckinetID") %>%
  filter(year == profile$years[1])

target_ids <- census_init %>%
  filter(area != 0) %>%
  distinct(luckinetID) %>%
  pull(luckinetID)

# pixel data
mp_area <- rast(x = files$pixelArea)
mp_rest <- rast(x = files$areaRestricted)
mp_area <- mp_area * (1 - mp_rest)

# 3. data processing ----
#
## _INSERT ----
message(" --> _INSERT")
for(j in seq_along(target_ids)){

  lu_data <- census_init %>%
    filter(luckinetID == target_ids[j])
  luID <- paste0("_", unique(lu_data$luckinetID), "_")
  luShort <- unique(lu_data$short)

  message(" --> processing '", luShort, "' --")


  message("     ... calculating (corrected) suitability weighted supply")

  mp_suit <- rast(x = str_replace(files$suit_X_Y, "_X_Y_", paste0(luID, profile$years[1], "_")))
  mp_minLU <- rast(x = str_replace(files$LUMinCor_X, "_X_", luID))
  mp_maxLU <- rast(x = str_replace(files$LUMaxCor_X, "_X_", luID))
  mp_minSuit <- rast(x = str_replace(files$suitMin_X, "_X_", luID))
  mp_maxSuit <- rast(x = str_replace(files$suitMax_X, "_X_", luID))

  mp_temp <- ((mp_suit - mp_minSuit) * (mp_maxLU - mp_minLU)) / (mp_maxSuit - mp_minSuit) + mp_minLU

  # mp_diag <- c(mp_suit, mp_minSuit, mp_maxSuit, mp_minLU, mp_maxLU, mp_temp) %>%
  #   stats::setNames(c("suitability", "min suit", "max suit", "min LU cor", "max LU cor", "sws cor"))

  mp_temp <- ifel(mp_maxSuit == 0 & mp_minSuit == 0 & mp_minLU == 0, 0, mp_temp)

  mp_temp <- mp_temp * mp_area
  writeRaster(x = mp_temp,
              filename = str_replace(files$supplySuitWeightCor_X, "_X_", luID),
              overwrite = TRUE,
              filetype = "GTiff",
              datatype = "FLT4S")

}

# 4. write output ----
#
write_rds(x = _INSERT, file = _INSERT)

# beep(sound = 10)
message("\n     ... done")
