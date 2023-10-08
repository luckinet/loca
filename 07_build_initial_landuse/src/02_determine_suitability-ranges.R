# This script determines the suitability ranges, i.e., the minimum and maximum
# suitability values per suitability rank.
message("\n---- determine suitability ranges ----")


# load metadata ----
#
files <- make_filenames(profile = profile, module = "initial landuse", step = "suitability ranges")

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

# territories
mp_ahID <- rast(x = files$ahID)
ahID <- unique(values(mp_ahID)[,1])

# initial landcover
mp_cover <- rast(x = str_replace(files$landcover_Y, "_Y_", paste0("_", profile$years[1], "_")))


# data processing ----
#
# for each landuse class ...
for(j in seq_along(target_ids)){

  lu_data <- census_init %>%
    filter(luckinetID == target_ids[j])
  luID <- paste0("_", unique(lu_data$luckinetID), "_")
  luShort <- unique(lu_data$short)

  message(" --> processing '", luShort, "' --")

  lc_prop <- lc_limits %>%
    filter(luckinetID == target_ids[j]) %>%
    dplyr::select(landcover, lcID, min, max)

  # allocation groups are those groups of landcover classes that have the same minimum
  # and maximum values
  allocGroups <- lc_prop %>%
    distinct(min, max)

  # for each administrative territory ...
  for(i in seq_along(ahID)){

    thisAhID <- ahID[i]
    message("     ... deriving mask of ahID '", thisAhID, "'")

    # mask of the values of the i-th administrative territory
    mp_suit <- rast(x = str_replace(files$suit_X_Y, "_X_Y_", paste0("_", target_ids[j], "_", profile$years[1], "_")))
    mp_suit[!mp_ahID %in% thisAhID] <- NA

    # start with an empty raster (only NA values)
    if(i == 1){
      mp_temp <- mp_suit
      mp_temp[] <- NA
      writeRaster(x = mp_temp,
                  filename = str_replace(files$suitMin_X, "_X_", luID),
                  overwrite = TRUE,
                  filetype = "GTiff",
                  datatype = "FLT4S")
      writeRaster(x = mp_temp,
                  filename = str_replace(files$suitMax_X, "_X_", luID),
                  overwrite = TRUE,
                  filetype = "GTiff",
                  datatype = "FLT4S")
      rm(mp_temp)
    }

    # if there is only NA values in the mp_mask, there is no need to process it
    if(!any(!is.na(values(mp_suit)))){
      message("   '", luShort, "' has no values at rank ", i, " skipping ...")
      next
    }

    # for each allocation group determine suitability ranges
    for(k in 1:dim(allocGroups)[1]){

      # get the contributing classes
      allocLC <- lc_prop %>%
        filter(min == allocGroups$min[k]) %>%
        filter(max == allocGroups$max[k])

      # create temp object that contains suitability values (of i-th rank) in
      # pixels of the current landcover classes
      mp_temp <- mp_suit
      mp_temp[!mp_cover %in% allocLC$lcID] <- NA

      if(!any(!is.na(values(mp_temp)))){
        message("     ! allocation group ", k, " for '", luShort, "' contains no values, skipping !")
        next
      }

      suitRange <- range(values(mp_temp), na.rm = T)

      # first process minimum values ...
      mp_range <- rast(x = str_replace(files$suitMin_X, "_X_", luID))
      mp_range[!is.na(mp_temp)] <- min(suitRange)
      writeRaster(x = mp_range,
                  filename = str_replace(files$suitMin_X, "_X_", luID),
                  overwrite = TRUE,
                  filetype = "GTiff",
                  datatype = "FLT4S")

      # ... then maximum values
      mp_range <- rast(x = str_replace(files$suitMax_X, "_X_", luID))
      mp_range[!is.na(mp_temp)] <- max(suitRange)
      writeRaster(x = mp_range,
                  filename = str_replace(files$suitMax_X, "_X_", luID),
                  overwrite = TRUE,
                  filetype = "GTiff",
                  datatype = "FLT4S")
    }
  }
  # beep(sound = 2)

}


# write output ----
#
beep(sound = 10)
message("---- done ----")
