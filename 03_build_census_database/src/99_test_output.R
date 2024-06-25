# ----
# title       : build census database - test output datasets
# description : this is the subscript of module 4 that test various aspects of the output datasets and collates them into an analysis matrix
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-06-24
# version     : 0.1.0
# status      : work in progress
# comment     : file.edit(paste0(dir_docs, "/documentation/03_build_census_database.md"))
# ----

stage3tables <- list.files(path = paste0(dir_census_wip, "tables/stage3/"), full.names = TRUE)


message(" --> check reasonability of patterns (still implement)")
for(i in seq_along(stage3tables)){

  temp <- readRDS(file = stage3tables[i])

  theNation <- str_split(last(str_split(stage3tables[i], pattern = "/")[[1]]), "[.]")[[1]][1]

  message("  '", theNation, "'")

  if(any(is.na(temp$gazName))){
    stop("check for NA in 'gazName'")
  }

  if(any(is.na(temp$gazID))){
    stop("check for NA in 'gazID'")

    temp |>
      filter(is.na(gazID)) |>
      distinct(gazMatch, .keep_all = TRUE) |>
      View()
  }


}


# landAgg <- c("Arable land", "Naturally regenerating forest", "Permanent crops",
#              "Permanent grazing", "Planted Forest", "Undisturbed Forest")

# load data ----
#
commodities <- readRDS(file = files$ids_commodities)
landuse <- readRDS(file = files$ids_landuse)


# data processing ----
#

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
