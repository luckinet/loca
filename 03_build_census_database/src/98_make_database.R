# author and date of creation ----
#
# Steffen Ehrmann, 19.02.2021


# script description ----
#
# This script extracts data from the areal database and harmonises those data so
# that they can be used by all modules.
message("\n---- 03 - preprocess areal data ----")


# script arguments ----
#
assertList(x = profile, len = 12)                  # ensure that profile is set
assertList(x = files)


# load metadata ----
#
# landAgg <- c("Arable land", "Naturally regenerating forest", "Permanent crops",
#              "Permanent grazing", "Planted Forest", "Undisturbed Forest")

# load data ----
#
commodities <- readRDS(file = files$ids_commodities)
landuse <- readRDS(file = files$ids_landuse)


# data processing ----
#
message(" --> pulling areal data")
# pull areal data for the sandbox nations
census_in <- pull_arealData(path = paste0(dataDir, "areal_data/", profile$arealDB_dir),
                            nation = profile$arealDB_extent,
                            pID = "luckinetID",
                            variable = c("planted", "harvested", "area"))

message(" --> summarise areas per unique unit")
# build table of census data of commodities, where there is a value in any of
# the variables, assuming that duplicates are the result of translating
# different terms in the input data to the same harmonised commodity (because
# that's how I did it when building the areal database). Thus, as we deal with
# areas, the data can be summarised.
census_temp <- census_in %>%
  mutate(luckinetID = as.character(luckinetID)) %>%
  filter_at(.vars = c("planted", "harvested", "area"),
            .vars_predicate = any_vars(!is.na(.))) %>%
  group_by(tabID, geoID, year, nation, ahID, ahLevel, luckinetID) %>%
  summarise(planted = sum(planted, na.rm = T),
            harvested = sum(harvested, na.rm = T),
            area = sum(area, na.rm = T)) %>%
  ungroup()

message(" --> interpolate missing units (still implement)")

message(" --> check reasonability of patterns (still implement)")

message(" --> determine flags")
census_out <- census_temp %>%
  mutate(area = if_else(area == 0, if_else(planted == 0, harvested, planted), area),
         flag = if_else(area == 0, if_else(planted == 0, "var:harv", "var:plan"), "var:area")) %>%
  select(-planted, -harvested)


# write output ----
#
saveRDS(object = census_out, file = files$census)

# beep(sound = 10)
message("---- done ----")
