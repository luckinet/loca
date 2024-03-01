# author and date of creation ----
#
# This script test all output objects that should be available at the end
# of this module.
message("\n---- 99_test-output ----")


# load packages ----
#


# script arguments ----
#
assertList(x = profile, len = 12)                  # ensure that profile is set
assertList(x = files)


# load metadata ----
#
lc_limits <- readRDS(file = paste0(profile$dir, "tables/landcover_limits.rds"))

previous <- new.env()


# load (and visualise) data ----
#
pb <- txtProgressBar(min = 0, max = 9, style = 3, char=">",
                     width=getOption("width")-14)

# initial landuse level census
census_init <- readRDS(file = files$census) %>%
  left_join(lc_limits %>% select(luckinetID, short) %>% distinct(), by = "luckinetID") %>%
  filter(year == profile$years[1])

target_ids <- census_init %>%
  filter(area != 0) %>%
  distinct(luckinetID) %>%
  pull(luckinetID)

# landcover
mp_cover <- rast(x = str_replace(files$landcover, "_Y_", paste0("_", profile$years[1], "_"))) %>%
  stats::setNames("landcover")

# visualise("landcover" = mp_cover)
setTxtProgressBar(pb, 1)

# administrative territories
mp_ahID <- rast(x = files$ahID1)
mp_ahIDLC <- rast(x = files$ahIDLC)

# visualise("territories" = mp_ahID)
setTxtProgressBar(pb, 2)

# pixel areas
mp_area <- rast(x = files$pixelArea)
mp_rest <- rast(x = files$areaRestricted)

# visualise("restricted fraction" = mp_rest)
setTxtProgressBar(pb, 3)

# suitability
mp_suit <- rast(x = str_replace(files$suit_X_Y, "_X_Y_", paste0("_", target_ids, "_", profile$years[1], "_"))) %>%
  stats::setNames(paste0(target_ids, " suit"))

# visualise(mp_suit)
setTxtProgressBar(pb, 4)

# landuse limits
mp_minLU <- rast(x = str_replace(files$LUMin_X, "_X_", paste0("_", target_ids, "_"))) %>%
  stats::setNames(paste0(target_ids, " LU min"))
mp_maxLU <- rast(x = str_replace(files$LUMax_X, "_X_", paste0("_", target_ids, "_"))) %>%
  stats::setNames(paste0(target_ids, " LU max"))

# corrected landuse limits
mp_minLUCor <- rast(x = str_replace(files$LUMinCor_X, "_X_", paste0("_", target_ids, "_"))) %>%
  stats::setNames(paste0(target_ids, " LU min cor"))
mp_maxLUCor <- rast(x = str_replace(files$LUMaxCor_X, "_X_", paste0("_", target_ids, "_"))) %>%
  stats::setNames(paste0(target_ids, " LU max cor"))

# visualise(mp_minLU)
# visualise(mp_minLUCor)
# visualise(mp_maxLU)
# visualise(mp_maxLUCor)
setTxtProgressBar(pb, 5)

# suitability ranges
mp_minSuit <- rast(x = str_replace(files$suitMin_X, "_X_", paste0("_", target_ids, "_"))) %>%
  stats::setNames(paste0(target_ids, " suit min"))
mp_maxSuit <- rast(x = str_replace(files$suitMax_X, "_X_", paste0("_", target_ids, "_"))) %>%
  stats::setNames(paste0(target_ids, " suit max"))

# visualise(mp_minSuit, theme = myTheme)
# visualise(mp_maxSuit, theme = myTheme)

# minimum and maximum supply
# mp_minSupply <- rast(x = str_replace(files$supplyMin_X, "_X_", paste0("_", target_ids, "_"))) %>%
#   setNames(paste0(target_ids, " supply min"))
# mp_maxSupply <- rast(x = str_replace(files$supplyMax_X, "_X_", paste0("_", target_ids, "_"))) %>%
#   setNames(paste0(target_ids, " supply max"))

# plot(mp_minSupply)
# plot(mp_maxSupply)

# suitability weighted supply
mp_sws <- rast(x = str_replace(files$supplySuitWeight_X, "_X_", paste0("_", target_ids, "_"))) %>%
  stats::setNames(paste0(target_ids, " sws"))

# visualise(mp_sws)
setTxtProgressBar(pb, 6)

# corrected suitability weighted supply
mp_swsCor <- rast(x = str_replace(files$supplySuitWeightCor_X, "_X_", paste0("_", target_ids, "_"))) %>%
  stats::setNames(paste0(target_ids, " sws cor"))

# visualise(mp_swsCor)
setTxtProgressBar(pb, 7)

# sum of all suitability weighted supplies
mp_sumSwsCor <- round(sum(mp_swsCor)) %>%
  stats::setNames("all_sws")

# area of restricted proportion
mp_restArea <- mp_rest * mp_area

# all sws and restricted area summarised
mp_all <- round(mp_sumSwsCor + mp_restArea) %>%
  stats::setNames("all_sws+restr")

# visualise("all supplies" = mp_sumSwsCor)
# visualise("all supplies + restricted" = mp_all)
setTxtProgressBar(pb, 8)

# calculate predicted area
supply <- zonal(x = mp_swsCor, z = rast(x = files$ahID), fun = "sum", na.rm = TRUE) %>%
  stats::setNames(c("ahID", target_ids)) %>%
  pivot_longer(cols = as.character(target_ids), names_to = "luckinetID", values_to = "area_pred") %>%
  mutate(luckinetID = as.numeric(luckinetID))

stats <- left_join(census_init, supply, by = c("ahID", "luckinetID")) %>%
  filter(!is.na(area_pred))
setTxtProgressBar(pb, 9)

record_objects(mp_cover, mp_ahID, mp_ahIDLC, mp_area, mp_rest,
               mp_suit, mp_minLU, mp_maxLU, mp_minLUCor, mp_maxLUCor,
               mp_minSuit, mp_maxSuit, mp_sws, mp_swsCor, mp_sumSwsCor,
               mp_restArea, mp_all, path = dataDir)


# test expectations ----
# ... that summarised sws values together with restricted area adds up to total pixel area
expect_true(all(values(mp_all) == values(mp_area)), label = "'allocated demand (+ restricted area)' == 'pixel area'")

# ... that predicted area is the same as demand area
expect_true(all(round(stats$area) == round(stats$area_pred)), label = "'demand' == 'predicted area'")

# check out differences between model runs
# visualise(get_difference("mp_minLUCor"), theme = diffTheme)
# visualise(get_difference("mp_maxLUCor"), theme = diffTheme)
# visualise(get_difference("mp_swsCor"), theme = diffTheme)
# visualise(get_difference("mp_sumSwsCor"), theme = diffTheme)
# visualise(get_difference("mp_all"), theme = diffTheme)


# calculate some zonal stats ----
zonal(get_difference("mp_swsCor"), mp_ahIDLC, fun = "sum")
zonal(get_difference("mp_sumSwsCor"), mp_ahIDLC, fun = "sum")
zonal(mp_all, mp_ahIDLC, fun = "sum")
zonal(mp_swsCor, mp_ahIDLC, fun = "sum")
zonal(mp_sumSwsCor, mp_ahIDLC, fun = "sum")
zonal(mp_restArea, mp_ahIDLC, fun = "sum")

# write output ----
#
close(pb)
# beep(sound = 10)
message("---- done ----")
