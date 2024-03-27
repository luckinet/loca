# ----
# title        : determine correction factors
# authors      : Steffen Ehrmann
# version      : 0.8.0
# date         : 2024-03-27
# description  : This script determines corrected landuse limits based on local
#                census statistics. The corrected landuse limits allow scaling
#                so that suitability weighted supply in a region corresponds to
#                the local census stats.
# documentation: file.edit(paste0(dir_docs, "/documentation/_INSERT.md"))
# ----
message("\n---- determine correction factors ----")

# 1. make paths ----
#
files <- make_filenames(profile = profile, module = "initial landuse", step = "correction factors")

# 2. load data ----
#
lc_limits <- readRDS(file = files$landcover_limits)

# pixel data
mp_area <- rast(x = files$pixelArea)
mp_rest <- rast(x = files$areaRestricted)
mp_area <- mp_area * (1 - mp_rest)

# initial landcover
mp_cover <- rast(x = str_replace(files$landcover, "_Y_", paste0("_", profile$years[1], "_")))

# territories
mp_ahID <- rast(x = files$ahID)
mp_ahIDLC <- rast(x = files$ahIDLC)

ahIDs <- unique(values(mp_ahID)[,1])
ahIDLC <- crossing(ahID = ahIDs, lcID = unique(lc_limits$lcID)) %>%
  mutate(ahIDLC = paste0(ahID, lcID))


# initial landuse level census
census_init <- readRDS(file = files$census) %>%
  left_join(lc_limits %>% select(luckinetID, short) %>% distinct(), by = "luckinetID") %>%
  filter(year == profile$years[1])

target_ids <- census_init %>%
  filter(area != 0) %>%
  distinct(luckinetID) %>%
  pull(luckinetID)

# 3. data processing ----
#
## _INSERT ----
message(" --> _INSERT")
all_sws <- NULL
for(j in seq_along(target_ids)){

  lu_data <- census_init %>%
    filter(luckinetID == target_ids[j])
  luID <- paste0("_", unique(lu_data$luckinetID), "_")
  luShort <- unique(lu_data$short)

  message(" --> processing '", luShort, "' --")

  lc_prop <- lc_limits %>%
    filter(luckinetID == target_ids[j]) %>%
    dplyr::select(landcover, lcID, min, max)

  # allocation groups (ag) are those groups of landcover classes that have the
  # same minimum and maximum values
  allocGroups <- lc_prop %>%
    distinct(min, max) %>%
    mutate(ag = seq_along(min))

  lc_prop <- lc_prop %>%
    left_join(allocGroups, by = c("min", "max"))

  # suitability weighted supply (sws) contains the relative weight of each pixel
  # and was calculated in a previous step by scaling suitability between the
  # landuse limits (min-max-normalisation)
  mp_sws <- rast(x = str_replace(files$supplySuitWeight_X, "_X_", luID))
  mp_swsArea <- mp_sws * mp_area

  # the summarised area of sws per combination of territory and landcover class
  ahIDLC_area <- zonal(x = mp_swsArea, z = mp_ahIDLC, fun = "sum", na.rm = TRUE) %>%
    set_names(nm = c("ahIDLC", "ahIDLC_sws")) %>%
    mutate(ahIDLC = as.character(ahIDLC)) %>%
    left_join(ahIDLC, by = "ahIDLC") %>%
    left_join(lc_prop %>% select(lcID, ag), by = "lcID")

  # the relative contribution of each allocation group to SWS, which is used
  # as the proportion of demand in a zone that should be accounted for by pixels
  # of that allocation group
  sws <- ahIDLC_area %>%
    group_by(ahID) %>%
    mutate(ahIDlc_prop = ahIDLC_sws/sum(ahIDLC_sws)) %>%
    ungroup() %>%
    mutate(luckinetID = target_ids[j]) %>%
    left_join(lu_data %>% select(ahID, lu_area = area), by = "ahID")

  all_sws <- bind_rows(all_sws, sws)
}

## _INSERT ----
message(" --> _INSERT")
# finally, the amount of demand is calculated as proportion of sws per
# allocation group corrected with +/- the deviation devided up into as many
# equal chunks as there are luckinetIDs.
all_sws <- all_sws %>%
  group_by(luckinetID) %>%
  mutate(ag_demand = lu_area * ahIDlc_prop) %>%
  ungroup() %>%
  group_by(ag) %>%
  mutate(cor = (sum(ahIDLC_sws) - sum(ag_demand)) / n(),
         demand = ag_demand + cor,
         dev = ahIDLC_sws / demand) %>%
  ungroup()

allRanges <- NULL
for(j in seq_along(target_ids)){

  lu_data <- census_init %>%
    filter(luckinetID == target_ids[j])
  luID <- paste0("_", unique(lu_data$luckinetID), "_")
  luShort <- unique(lu_data$short)

  message(" --> processing '", luShort, "' --")

  lc_prop <- lc_limits %>%
    filter(luckinetID == target_ids[j]) %>%
    dplyr::select(landcover, lcID, min, max)

  # allocation groups (ag) are those groups of landcover classes that have the
  # same minimum and maximum values
  allocGroups <- lc_prop %>%
    distinct(min, max) %>%
    mutate(ag = seq_along(min))

  lc_prop <- lc_prop %>%
    left_join(allocGroups, by = c("min", "max"))

  # for each zone determine ...
  for(i in seq_along(ahIDs)){

    thisAhID <- ahIDs[i]

    # ... the spatial subset, within that ...
    mp_sws <- rast(x = str_replace(files$supplySuitWeight_X, "_X_", luID))
    mp_sws[!mp_ahID %in% thisAhID] <- NA

    if(i == 1){
      mp_temp <- mp_sws
      mp_temp[] <- 0
      writeRaster(x = mp_temp,
                  filename = str_replace(files$LUMinCor_X, "_X_", luID),
                  overwrite = TRUE,
                  filetype = "GTiff",
                  datatype = "FLT4S")
      writeRaster(x = mp_temp,
                  filename = str_replace(files$LUMaxCor_X, "_X_", luID),
                  overwrite = TRUE,
                  filetype = "GTiff",
                  datatype = "FLT4S")
      rm(mp_temp)
    }

    # ... for each allocation group determine ...
    for(k in 1:dim(allocGroups)[1]){

      # ... the contributing classes
      allocLC <- lc_prop %>%
        filter(ag == k) %>%
        mutate(newMin = NA_integer_,
               newMax = NA_integer_,
               lu = luShort,
               ahID = thisAhID)

      ag_sws <- all_sws %>%
        filter(luckinetID == target_ids[j]) %>%
        filter(ahID == thisAhID) %>%
        filter(ag == k)

      if(dim(ag_sws)[1] != 0){
        if(ag_sws$dev == 1){
          # in case the deviation is 1 (i.e., there is no deviation), newMin and newMax remain the same
          newMin <- allocGroups$min[k]
          newMax <- allocGroups$max[k]
        } else {

          # subset of the allocation group
          mp_temp <- mp_sws
          mp_temp[!mp_cover %in% allocLC$lcID] <- NA

          # scale suitability values of the allocation group between 0 and 1
          temp <- values(mp_temp)
          suit <- na.omit(temp)
          suitVals <- (suit - min(suit))/(max(suit) - min(suit))

          # derive also the area of those pixels that have a valid suitability
          # value
          area <- values(mp_area)[!is.na(temp)]
          thisDemand <- ag_sws$demand

          # there may be two cases, either demand is lower or higher than supply.
          # when demand is lower than supply, dev > 1. In that case I decrease the
          # upper limit and keep the lower limit, so that all sws-values become
          # smaller after re-scaling and thus supply is smaller. For dev < 1, I
          # need to increase the lower limit and keep the upper limit to have all
          # sws-values increase and thus supply to increase.
          if (ag_sws$dev > 1) {
            newMin <- allocGroups$min[k]
            newMax <- (thisDemand + sum(newMin * area * suitVals) - sum(newMin * area)) / sum(suitVals * area)
          } else {
            newMax <- allocGroups$max[k]
            newMin <- (thisDemand - sum(newMax * area * suitVals)) / (sum(area) - sum(suitVals * area))
          }
        }

        # check that the new limits are valid
        # assertNumeric(x = newMin, lower = 0, upper = 1, any.missing = FALSE, finite = TRUE)
        # assertNumeric(x = newMax, lower = 0, upper = 1, any.missing = FALSE, finite = TRUE)
        # assertTRUE(x = newMin <= newMax)
        # apparently newMax gives 1.054052 with j = 1, i = 2, k = 1
        # -> perhaps also output an overall table for all combinations of j,k,i to see what is allocated where
      } else {
        newMin <- allocLC$min
        newMax <- allocLC$max
      }

      allocLC$newMin <- newMin
      allocLC$newMax <- newMax
      if(k == 1){
        newRanges <- allocLC
      } else {
        newRanges <- bind_rows(newRanges, allocLC) # there might be more than one row to add
      }

    }

    mp_tempCov <- mp_cover %>%
      mask(mp_sws, updatevalue = 0)

    mp_minLU <- mp_tempCov %>%
      classify(newRanges %>% dplyr::select(lcID, newMin))
    mp_minLU <- mp_minLU + rast(str_replace(files$LUMinCor_X, "_X_", luID))
    writeRaster(x = mp_minLU,
                filename = str_replace(files$LUMinCor_X, "_X_", luID),
                overwrite = TRUE,
                filetype = "GTiff",
                datatype = "FLT4S")

    mp_maxLU <- mp_tempCov %>%
      classify(newRanges %>% dplyr::select(lcID, newMax))
    mp_maxLU <- mp_maxLU + rast(str_replace(files$LUMaxCor_X, "_X_", luID))
    writeRaster(x = mp_maxLU,
                filename = str_replace(files$LUMaxCor_X, "_X_", luID),
                overwrite = TRUE,
                filetype = "GTiff",
                datatype = "FLT4S")

  }

  allRanges <- bind_rows(allRanges, newRanges)

  # beep(sound = 2)

}

# 4. write output ----
#
write_rds(x = _INSERT, file = _INSERT)

# beep(sound = 10)
message("\n     ... done")
