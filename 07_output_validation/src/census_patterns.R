# author and date of creation ----
#
# Steffen Ehrmann, 09.08.2021


# script description ----
#

# load packages ----
#
library(luckiTools)
library(geometr)
library(dplyr, warn.conflicts = FALSE)
library(purrr)
library(readr)
library(stringr)


# command line arguments ----
#
# (optional, in case this script shall allow the user to run with different options)


# set paths ----
#
projDir <- select_path(idivnb283 = "/home/se87kuhe/idiv-mount/groups/MAS/01_projects/LUCKINet/",
                       frontend1 = "/data/idiv_meyer/01_projects/LUCKINet/")
dataDir <- paste0(projDir, "01_data/")

# load metadata ----
#
#
message("\n ---- loading (meta)data ----")
profile <- load_profile(root = dataDir, name = "sandbox", version = "0.1.0")

inv_dataseries <- read_csv(file = paste0(paste0(dataDir, "areal_data/", profile$areal_data, "/inv_dataseries.csv")))
inv_tables <- read_csv(file = paste0(paste0(dataDir, "areal_data/", profile$areal_data, "/inv_tables.csv")))


# load data ----
#
commodities <- ontology %>%
  filter(class_from == "commodity") %>%
  select(term = term_from, luckinetID = luckinetID_from) %>%
  mutate(luckinetID = as.character(luckinetID)) %>%
  distinct()
# landuse <- readRDS(file = paste0(profile$dir, "tables/ids_landuse.rds"))
# categories <- readRDS(file = paste0(profile$dir, "tables/ids_categories.rds"))


luckiMap <- gc_geom(countries) %>%
  gt_filter(nation != "Antarctica")# %>%
  # gt_filter(!island)


# data processing ----
#
units <- list.files(paste0(dataDir, "areal_data/", profile$areal_data, "/adb_tables/stage3"), full.names = TRUE)

# extract the current status (this is updated by hand, so the status might not
# always be up-to-date for each nation)
status <- read_csv(file = paste0(dataDir, "areal_data_availability.csv"),
                   col_types = c("ccccllccciddiccccc")) %>%
  select(unit, cropland_area, cropland_prop, status)

commYear <- fao_crops <- available_nations <- NULL
for(i in seq_along(units)){

  theUnit <- str_split(units[i], "/")[[1]]
  theUnit <- str_split(theUnit[length(theUnit)], "[.]")[[1]][1]

  available_nations <- c(available_nations, theUnit)

  input <- readRDS(file = units[i]) %>%
    filter(year %in% profile$years) %>%
    mutate(luckinetID = as.character(luckinetID))

  # 1. summarise per commodity and year
  commYear <- input %>%
    group_by(year, luckinetID) %>%
    summarise(planted = sum(planted, na.rm = TRUE),
              harvested = sum(harvested, na.rm = TRUE),
              production = sum(production, na.rm = TRUE),
              headcount = sum(headcount, na.rm = TRUE)) %>%
    ungroup() %>%
    left_join(commodities, by = "luckinetID") %>%
    mutate(unit = theUnit) %>%
    bind_rows(commYear, .)

  # 2. filter FAO data and derive proportional metrics
  fao_prop <- input %>%
    filter(tabID %in% which(inv_dataseries$name == "faostat")) %>%
    group_by(year, ahID) %>%
    mutate(prop_harvested = round(harvested / sum(harvested, na.rm = TRUE) * 100, 2),
           prop_landuse = round(area / sum(area, na.rm = TRUE) * 100, 2),
           prop_heads = round(headcount / sum(headcount, na.rm = TRUE) * 100, 2)) %>%
    ungroup() %>%
    bind_rows(fao_crops, .)

  # fao_crops_yearly <- fao_prop %>%
  #   group_by(commodity, unit) %>%
  #   summarise(prop_harv_yrlyMean = round(mean(prop_harvested, na.rm = TRUE), 2)) %>%
  #   ungroup() %>%
  #   group_by(unit) %>%
  #   arrange(desc(prop_harv_yrlyMean)) %>%
  #   mutate(cumProp_harv = cumsum(prop_harv_yrlyMean),
  #          q95_harv = if_else(cumProp_harv > 95, FALSE, TRUE)) %>%
  #   slice_head(n = 50) %>%
  #   ungroup() %>%
  #   mutate(unit = as.factor(unit),
  #          commodity_orig = commodity,
  #          commodity = reorder_within(commodity, prop_harv_yrlyMean, unit))
  # fao_crops_yearly %>%
  #   filter(unit %in% targetCountries) %>%
  #   ggplot(aes(x = commodity, y = prop_harv_yrlyMean, fill = q95_harv)) +
  #   geom_col(show.legend = FALSE) +
  #   facet_wrap(~unit, scales = "free_y", ncol = 2) +
  #   coord_flip() +
  #   scale_x_reordered()


}

# join the status with the attributes of luckiMap
luckiMap <- status %>%
  left_join(x = getGroups(luckiMap), y = ., by = "unit") %>%
  setGroups(x = luckiMap, table = .)

# create the new attribute 'available' in the attribute table of luckiMap
luckiMap <- getGroups(luckiMap) %>%
  mutate(available = as.integer(nation %in% available_nations)) %>%
  setGroups(x = luckiMap, table = .)

# stuff to visualise

# levels of visualisation ----
#
# national (fao):
#
# sublevel (any local):

# domains ----
#
# landuse:
#
# crops:
#
# livestock:
#
# forset:

# metrics ----
#
# completenes:
#
# average area (yearly) and deviation:
#
# commodity richness:
#
# proportion of commodities: This can be useful when sorting commodities by
# proportion and selecting those that make up a certain fraction (e.g. 90%)


# possible plots
#
# 1. bar chart with top 95% of commodities
# 2. line/dot chart per commodity of (relative) abundance (fixed y-axis?!) per year
# 3. area vs adminlevel
# temporal development of number of q95 and q50 commodities




# write output
#
# (optional, but recommended for a reproducible workflow)


# from an old script ----
# library(tidyverse)
# library(tidytext)
# library(viridis)
# library(sf)
# library(masDMT) # https://git.idiv.de/mas/management/dmt
# library(knitr)


# steffen <- "/home/se87kuhe/idiv-mount/groups/MAS/01_data/LUCKINet/"
# carsten <- "I:/MAS/01_data/LUCKINet/" # I suppose?!
# user <- steffen # replace with your name here
# dbPath <- paste0(user, "output/areal data/areal database_alpha200709")


# load concept relations
# concept_relations <- read_csv(file = paste0(user, "archive/concept_relations_alpha200910.csv"),
#                               col_types = "cciccci")

# extract fao and clean commodity names by selecting all synonyms of 'fao
# commodity' with the target class (clean) 'commodity'
# fao_commodities <- concept_relations %>%
#   filter(class_from == "fao commodity" & class_to == "commodity" & relationship == "is synonym to") %>%
#   dplyr::select(fao_commodity = term_from, commodity = term_to, )

# inventory tables of the areal database, e.g., to determine which data are from
# the FAO
# tables <- read_csv(file = paste0(dbPath, "/inv_tables.csv"),
#                    col_types = "iiiccccDDcccc")
# tables$tabID[grep(pattern = "faostat", tables$source_file)] # -> tabID 3 and 4 are for FAOStat
# adb_commodities <- read_csv(file = paste0(dbPath, "/id_commodities.csv"),
#                             col_types = "iciccc")


# to sort graphs into major, frequent and minor crops
# majorCrops <- c("wheat", "sugarcane", "soybean", "maize")
# frequentCrops <- c("barley", "bean", "cassava", "coffee", "orange", "rice", "seed cotton", "sorghum", "sunflower seed")
# otherCrops <- c("banana", "cashew nut", "castor bean", "cocoa beans", "coconut", "grape", "mate", "oat", "peanut", "potato", "sisal")


# targetCountries <- c("argentina", "bolivia", "brazil", "paraguay")
# make human-readable country names
# countryNames <- countries %>%
#   st_drop_geometry() %>%
#   select(unit, ahID) %>%
#   mutate(ahID = str_pad(ahID, 3, pad = "0"))

# input_livestock <- input_crops <- input_forest <- NULL
# loop through all target countries to load the data and append them to the
# input dataset
# for(i in seq_along(targetCountries)){

# first, I load the data from the areal database for a country
# input <- pull_arealData(path = dbPath,
#                         nation = targetCountries[i],
#                         pID = "commodityID",
#                         type = c("harvested", "planted", "production", "headcount"))

# # get subset of commodities,filter commodities that are the same species but
# # where the use excludes the other commodity and rename commodities that are
# # actually the same species with different uses
# temp_livestock <- input %>%
#   filter(tabID %in% c(3, 15:23, 26, 82)) %>%
#   filter(year >= 2003 & year <= 2013) %>%
#   left_join(fao_commodities) %>%
#   filter(commodity != "poultry birds")

# temp_crops <- input %>%
#   filter(tabID %in% c(4, 14, 25, 27:81, 83)) %>%
#   filter(year >= 2003 & year <= 2013) %>%
#   left_join(fao_commodities) %>%
#   filter(commodity != "cashewapple") %>% # seems to be the same as 'cashew nut'
#   mutate(commodity = if_else(commodity == "tangerines mandarins clementines satsumas", "tangerines et al", commodity),
#          commodity = if_else(commodity == "vegetables fresh nes", "veg fresh nes", commodity),
#          commodity = if_else(commodity == "pumpkins squash gourds", "pumpkins et al.", commodity),
#          commodity = if_else(commodity == "bean dry", "bean", commodity),
#          commodity = if_else(commodity == "bean green", "bean", commodity),
#          commodity = if_else(commodity == "chillies and peppers dry", "chillies and peppers", commodity),
#          commodity = if_else(commodity == "chillies and peppers  green", "chillies and peppers", commodity),
#          commodity = if_else(commodity == "maize green", "maize", commodity),
#          commodity = if_else(commodity == "onion dry", "onion", commodity),
#          commodity = if_else(commodity == "onion green", "onion", commodity),
#          commodity = if_else(commodity == "pea green", "pea", commodity),
#          commodity = if_else(commodity == "linseed fibre", "linseed", commodity))

# temp_forest <- input %>%
#   filter(tabID %in% c(6:13, 24, 84)) %>%
#   filter(year >= 2000 & year <= 2015) %>%
#   left_join(fao_commodities)

# input_livestock <- bind_rows(input_livestock, temp_livestock)
# input_crops <- bind_rows(input_crops, temp_crops)
# input_forest <- bind_rows(input_forest, temp_forest)
# }
# rm(input, temp_crops)


# subset fao data
# fao_livestock <- input_livestock %>%
#   filter(tabID %in% 3)
# fao_crops <- input_crops %>%
#   filter(tabID %in% 4)
# fao_forest <- input_forest %>%
#   filter(tabID %in% c(6:13))

# subset to sublevel data
# sublevel_crops <- input_crops %>%
#   mutate(layer = if_else(nchar(ahID) == 3, 1, if_else(nchar(ahID) == 6, 2, if_else(nchar(ahID) > 6, 3, 4)))) %>%
#   filter(layer != 1)


# crop_div <- sublevel_crops %>%
#   select(year, commodity, ahID) %>%
#   filter(year == 2003) %>%
#   group_by(ahID) %>%
#   summarise(total_div = n())


# sublevel_crops_q95 <- sublevel_crops %>%
#   select(year, commodity, ahID, harvested) %>%
#   mutate(commodity = if_else(commodity %in% majorCrops | commodity %in% frequentCrops, commodity, "other")) %>%
#   filter(year == 2003) %>%
#   group_by(year, ahID, commodity) %>%
#   summarise(other_nr = n(),
#             harvested = sum(harvested, na.rm = TRUE)) %>%
#   ungroup() %>%
#   group_by(year, ahID) %>%
#   mutate(prop_harvested = harvested / sum(harvested, na.rm = TRUE) * 100) %>%
#   ungroup() %>%
#   group_by(ahID) %>%
#   arrange(desc(prop_harvested)) %>%
#   mutate(cumProp_harv = cumsum(prop_harvested),
#          q95_harv = if_else(cumProp_harv < 95, TRUE,
#                             if_else(prop_harvested > 95, TRUE, FALSE))) %>%
#   filter(q95_harv)

# crop_div <- sublevel_crops_q95 %>%
#   group_by(ahID) %>%
#   summarise(q95_div = n()) %>%
#   left_join(crop_div, by = "ahID") %>%
#   mutate(dev = 100 - (q95_div/total_div)*100)


# archetypes <- sublevel_crops_q95 %>%
#   select(commodity, ahID) %>%
#   filter(commodity != "other") %>%
#   group_by(ahID) %>%
#   arrange(commodity, .by_group = TRUE) %>%
#   summarise(type = str_c(commodity, collapse = "; ")) %>%
#   group_by(type) %>%
#   summarise(terr_nr = n()) %>%
#   ungroup() %>%
#   mutate(terr_prop = terr_nr / sum(terr_nr, na.rm = TRUE) * 100) %>%
#   arrange(desc(terr_prop)) %>%
#   mutate(terr_cum = cumsum(terr_prop))


# summarise commodities that occur several times per year and administrative unit
# fao_livestock <- fao_livestock %>%
#   group_by(year, ahID, commodity) %>%
#   summarise(unique_items = n(),
#             fao_commodity = paste0(unique(fao_commodity), collapse = "; "),
#             harvested = sum(harvested, na.rm = TRUE),
#             planted = sum(planted, na.rm = TRUE),
#             production = sum(production, na.rm = TRUE),
#             headcount = sum(headcount, na.rm = TRUE))

# fao_crops <- fao_crops %>%
#   group_by(year, ahID, commodity) %>%
#   summarise(unique_items = n(),
#             fao_commodity = paste0(unique(fao_commodity), collapse = "; "),
#             harvested = sum(harvested, na.rm = TRUE),
#             planted = sum(planted, na.rm = TRUE),
#             production = sum(production, na.rm = TRUE),
#             headcount = sum(headcount, na.rm = TRUE))

# fao_forest <- fao_forest %>%
#   group_by(year, ahID, commodity) %>%
#   summarise(unique_items = n(),
#             fao_commodity = paste0(unique(fao_commodity), collapse = "; "),
#             harvested = sum(harvested, na.rm = TRUE),
#             planted = sum(planted, na.rm = TRUE),
#             production = sum(production, na.rm = TRUE),
#             headcount = sum(headcount, na.rm = TRUE))


# calculate proportions per year and administrative unit, arrange by harvested
# area, calculate cummulative sum and determine which largest crops together
# make up 95% of the sample
# fao_crops <- fao_crops %>%
#   left_join(countryNames) %>%
#   group_by(year, ahID) %>%
#   mutate(prop_harvested = harvested / sum(harvested, na.rm = TRUE) * 100,
#          prop_production = production / sum(production, na.rm = TRUE) * 100) %>%
#   ungroup()

# commodities that are not elsewhere specified (nes)
# crops_nes <- fao_crops %>%
#   filter(grepl("nes$", commodity))
# crops_clear <- fao_crops %>%
#   filter(!grepl("nes$", commodity))

# commodities according to their frequency
# crops_clear_maj <- crops_clear %>%
#   filter(commodity %in% majorCrops)
# crops_clear_med <- crops_clear %>%
#   filter(commodity %in% frequentCrops)
# crops_clear_other <- crops_clear %>%
#   filter(commodity %in% otherCrops)
# crops_clear_min <- crops_clear %>%
#   filter(!commodity %in% c(majorCrops, frequentCrops, otherCrops))

# yearly averages
# fao_crops_yearly <- fao_crops %>%
#   group_by(commodity, unit) %>%
#   summarise(prop_harv_yrlyMean = mean(prop_harvested, na.rm = TRUE),
#             prop_prod_yrlyMean = mean(prop_production, na.rm = TRUE)) %>%
#   ungroup() %>%
#   group_by(unit) %>%
#   arrange(desc(prop_harv_yrlyMean)) %>%
#   mutate(cumProp_harv = cumsum(prop_harv_yrlyMean),
#          q95_harv = if_else(cumProp_harv > 95, FALSE, TRUE)) %>%
#   slice_head(n = 25) %>%
#   ungroup() %>%
#   mutate(unit = as.factor(unit),
#          commodity_orig = commodity,
#          commodity = reorder_within(commodity, prop_harv_yrlyMean, unit))


# commodities that contribute to the top 95% are coloured in blue, the rest in red
# ggplot(fao_crops_yearly, aes(x = commodity, y = prop_harv_yrlyMean, fill = q95_harv)) +
#   geom_col(show.legend = FALSE) +
#   facet_wrap(~unit, scales = "free_y", ncol = 2) +
#   coord_flip() +
#   scale_x_reordered()

# print the table
# fao_crops_yearly %>%
#   mutate(prop_harv_yrlyMean = round(prop_harv_yrlyMean, 2),
#          cumProp_harv = round(cumProp_harv, 2)) %>%
#   select(unit, commodity = commodity_orig, prop_harv_yrlyMean, cumProp_harv) %>%
#   kable()


# plot with fixed y-scale to visualise relative abundance
# ggplot(crops_clear_maj, aes(x = year, y = harvested, colour = unit)) +
#   geom_line() +
#   geom_point() +
#   facet_wrap(~ commodity) +
#   theme(legend.position = "bottom") +
#   scale_colour_viridis_d()


# ggplot(crops_clear_med, aes(x = year, y = harvested, colour = unit)) +
#   geom_line() +
#   geom_point() +
#   facet_wrap(~ commodity) +
#   theme(legend.position = "bottom") +
#   scale_colour_viridis_d()


# ggplot(crops_clear_other, aes(x = year, y = harvested, colour = unit)) +
#   geom_line() +
#   geom_point() +
#   facet_wrap(~ commodity) +
#   theme(legend.position = "bottom") +
#   scale_colour_viridis_d()


# ggplot(crops_clear_min, aes(x = year, y = harvested, colour = unit)) +
#   geom_line() +
#   geom_point() +
#   facet_wrap(~ commodity, ncol = 3) +
#   theme(legend.position = "bottom") +
#   scale_colour_viridis_d() +
#   scale_y_log10()


# ggplot(crops_nes, aes(x = year, y = harvested, colour = unit)) +
#   geom_line() +
#   geom_point() +
#   facet_wrap(~ commodity, ncol = 3, scales = "free_y") +
#   theme(legend.position = "bottom") +
#   scale_colour_viridis_d()


# fao_forest <- fao_forest %>%
#   left_join(countryNames) %>%
#   group_by(year, ahID) %>%
#   mutate(prop_planted = planted / sum(planted, na.rm = TRUE) * 100) %>%
#   ungroup()
#
# ggplot(fao_forest, aes(x = year, y = planted, colour = unit)) +
#   geom_line() +
#   geom_point() +
#   facet_wrap(~ commodity) +
#   theme(legend.position = "bottom") +
#   scale_colour_viridis_d() +
#   scale_y_log10()


# majorLivestock <- c("cattle")
# frequentLivestock <- c("goat", "pig", "sheep")
#
# fao_livestock <- fao_livestock %>%
#   left_join(countryNames) %>%
#   group_by(year, ahID) %>%
#   mutate(prop_headcount = headcount / sum(headcount, na.rm = TRUE) * 100) %>%
#   ungroup()
#
# livestock_nes <- fao_livestock %>%
#   filter(grepl("nes$", commodity))
# livestock_clear <- fao_livestock %>%
#   filter(!grepl("nes$", commodity))
#
# livestock_clear_maj <- livestock_clear %>%
#   filter(commodity %in% majorLivestock)
# livestock_clear_med <- livestock_clear %>%
#   filter(commodity %in% frequentLivestock)
# livestock_clear_min <- livestock_clear %>%
#   filter(!commodity %in% c(majorLivestock, frequentLivestock))
#
# fao_livestock_yearly <- fao_livestock %>%
#   group_by(commodity, unit) %>%
#   summarise(prop_head_yrlyMean = mean(prop_headcount, na.rm = TRUE)) %>%
#     ungroup() %>%
#   group_by(unit) %>%
#   arrange(desc(prop_head_yrlyMean)) %>%
#   mutate(cumProp_head = cumsum(prop_head_yrlyMean),
#          q95_head = if_else(cumProp_head > 95, FALSE, TRUE)) %>%
#   slice_head(n = 10) %>%
#   ungroup() %>%
#   mutate(unit = as.factor(unit),
#          commodity_orig = commodity,
#          commodity = reorder_within(commodity, prop_head_yrlyMean, unit))


# # commodities that contribute to the top 95% are coloured in blue, the rest in red
# ggplot(fao_livestock_yearly, aes(x = commodity, y = prop_head_yrlyMean, fill = q95_head)) +
#   geom_col(show.legend = FALSE) +
#   facet_wrap(~unit, scales = "free_y", ncol = 2) +
#   coord_flip() +
#   scale_x_reordered()
#
# # print the table
# fao_livestock_yearly %>%
#   mutate(prop_head_yrlyMean = round(prop_head_yrlyMean, 2),
#          cumProp_head = round(cumProp_head, 2)) %>%
#   select(unit, commodity = commodity_orig, prop_head_yrlyMean, cumProp_head) %>%
#   kable()


# ggplot(livestock_clear_maj, aes(x = year, y = headcount, colour = unit)) +
#   geom_line() +
#   geom_point() +
#   facet_wrap(~ commodity) +
#   theme(legend.position = "bottom") +
#   scale_colour_viridis_d()


# ggplot(livestock_clear_med, aes(x = year, y = headcount, colour = unit)) +
#   geom_line() +
#   geom_point() +
#   facet_wrap(~ commodity) +
#   theme(legend.position = "bottom") +
#   scale_colour_viridis_d()


# ggplot(livestock_clear_min, aes(x = year, y = headcount, colour = unit)) +
#   geom_line() +
#   geom_point() +
#   facet_wrap(~ commodity) +
#   theme(legend.position = "bottom") +
#   scale_colour_viridis_d()


# # subset sub-national data and determine respective territorial codes
# sub_livestock <- input_livestock %>%
#   filter(tabID %in% c(15:23, 26, 82)) %>%
#   mutate(level = if_else(nchar(ahID) > 7, 3, 2),
#          al1_id = str_sub(ahID, 1, 3),
#          al2_id = str_sub(ahID, 4, 6),
#          al3_id = str_sub(ahID, 7, 10)) %>%
#   left_join(countryNames, by = c("al1_id" = "ahID"))

# sub_crops <- input_crops %>%
#   filter(tabID %in% c(14, 25, 27:81, 83)) %>%
#   mutate(level = if_else(nchar(ahID) > 7, 3, 2),
#          al1_id = str_sub(ahID, 1, 3),
#          al2_id = str_sub(ahID, 4, 6),
#          al3_id = str_sub(ahID, 7, 10)) %>%
#   left_join(countryNames, by = c("al1_id" = "ahID"))

# sub_forest <- input_forest %>%
#   filter(tabID %in% c(24, 84)) %>%
#   mutate(level = if_else(nchar(ahID) > 7, 3, 2),
#          al1_id = str_sub(ahID, 1, 3),
#          al2_id = str_sub(ahID, 4, 6),
#          al3_id = str_sub(ahID, 7, 10)) %>%
#   left_join(countryNames, by = c("al1_id" = "ahID"))

# # summarise commodities that occur several times per year and administrative unit
# sub_livestock <- sub_livestock %>%
#   group_by(year, al1_id, al2_id, al3_id, commodity, level) %>%
#   summarise(unique_items = n(),
#             fao_commodity = paste0(unique(fao_commodity), collapse = "; "),
#             harvested = sum(harvested, na.rm = TRUE),
#             planted = sum(planted, na.rm = TRUE),
#             production = sum(production, na.rm = TRUE),
#             headcount = sum(headcount, na.rm = TRUE))

# sub_crops <- sub_crops %>%
#   group_by(year, al1_id, al2_id, al3_id, commodity, level) %>%
#   summarise(unique_items = n(),
#             fao_commodity = paste0(unique(fao_commodity), collapse = "; "),
#             harvested = sum(harvested, na.rm = TRUE),
#             planted = sum(planted, na.rm = TRUE),
#             production = sum(production, na.rm = TRUE),
#             headcount = sum(headcount, na.rm = TRUE)) %>%
#   ungroup()

# sub_forest <- sub_forest %>%
#   group_by(year, al1_id, al2_id, al3_id, commodity, level) %>%
#   summarise(unique_items = n(),
#             fao_commodity = paste0(unique(fao_commodity), collapse = "; "),
#             harvested = sum(harvested, na.rm = TRUE),
#             planted = sum(planted, na.rm = TRUE),
#             production = sum(production, na.rm = TRUE),
#             headcount = sum(headcount, na.rm = TRUE))


# bolivia has only "planted area", so I assign this to harvested, to make the
# below steps easier
# sub_crops <- sub_crops %>%
#   mutate(harvested = if_else(al1_id == "027", planted, harvested)) %>%
#   left_join(countryNames, by = c("al1_id" = "ahID")) %>%
#   mutate(ahID = paste0(al1_id, al2_id, al3_id))

# calculate proportions per year and administrative unit
# sub_crops <- sub_crops %>%
#   group_by(year, al1_id, al2_id, al3_id) %>%
#   mutate(prop_harvested = harvested / sum(harvested, na.rm = TRUE) * 100,
#          prop_production = production / sum(production, na.rm = TRUE) * 100) %>%
#   ungroup()

# # commodities that are not elsewhere specified (nes)
# crops_nes <- sub_crops %>%
#   filter(grepl("nes$", commodity))
# crops_clear <- sub_crops %>%
#   filter(!grepl("nes$", commodity))

# # commodities according to their frequency
# crops_clear_maj <- crops_clear %>%
#   filter(commodity %in% majorCrops)
# crops_clear_med <- crops_clear %>%
#   filter(commodity %in% frequentCrops)
# crops_clear_other <- crops_clear %>%
#   filter(commodity %in% otherCrops)
# crops_clear_min <- crops_clear %>%
#   filter(!commodity %in% c(majorCrops, frequentCrops, otherCrops))

# yearly averages
# sub_crops_freq <- sub_crops %>%
#   group_by(ahID) %>%
#   arrange(desc(prop_harvested)) %>%
#   mutate(cumProp_harv = cumsum(prop_harvested),
#          q95_harv = if_else(cumProp_harv < 95 | prop_harvested > 95, TRUE, FALSE),
#          q90_harv = if_else(cumProp_harv < 90 | prop_harvested > 90, TRUE, FALSE),
#          q85_harv = if_else(cumProp_harv < 85 | prop_harvested > 85, TRUE, FALSE)) %>%
#   ungroup() %>%
#   group_by(unit, commodity) %>%
#   summarise(occurences = n(),
#             q95_occ = sum(q95_harv, na.rm = TRUE),
#             prop_q95 = round(q95_occ / occurences * 100, 2),
#             q90_occ = sum(q90_harv, na.rm = TRUE),
#             prop_q90 = round(q90_occ / occurences * 100, 2),
#             q85_occ = sum(q85_harv, na.rm = TRUE),
#             prop_q85 = round(q85_occ / occurences * 100, 2)) %>%
#   ungroup() %>%
#   mutate(unit = as.factor(unit),
#          commodity_orig = commodity,
#          commodity = reorder_within(commodity, prop_q95, unit))


# sub_crops_freq %>%
#   select(unit, commodity, prop_q95, prop_q90, prop_q85) %>%
#   pivot_longer(cols = starts_with("prop_"), names_to = "prop_occ", values_to = "proportion") %>%
#   ggplot(aes(x = commodity, y = proportion, fill = prop_occ)) +
#   geom_col(position = "dodge") +
#   facet_wrap(vars(unit), ncol = 2, scales = "free") +
#   coord_flip() +
#   scale_x_reordered()

# print the table
# sub_crops_freq %>%
#   select(unit, commodity = commodity_orig, occurences, q95_occ, prop_q95, q90_occ, prop_q90, q85_occ, prop_q85) %>%
#   arrange(unit, desc(prop_q95)) %>%
#   kable()


# sub_crops_yearly %>%
#   ggplot(aes(x = commodity, y = min_prop_harv)) +
#   geom_col(show.legend = FALSE) +
#   facet_wrap(~unit, scales = "free_y", ncol = 2) +
#   coord_flip() +
#   scale_x_reordered()


# brazil and argentina have rather detailed data at level 3
# paraguay and bolivia have data only at level 2
# the following plot contains data from both, level 2 and 3.
# sub_crops %>%
#   filter(commodity %in% majorCrops) %>%
#   mutate(year = as.factor(year),
#          level = as.factor(level)) %>%
#   ggplot(aes(x = year, y = prop_harvested, fill = unit)) +
#   geom_violin() +
#   facet_wrap(~ commodity) +
#   theme(legend.position = "bottom") +
#   scale_fill_viridis_d()


# sub_crops %>%
#   filter(commodity %in% frequentCrops) %>%
#   mutate(year = as.factor(year),
#          level = as.factor(level)) %>%
#   ggplot(aes(x = year, y = prop_harvested, fill = unit)) +
#   geom_violin() +
#   facet_wrap(~ commodity, ncol = 2) +
#   theme(legend.position = "bottom") +
#   scale_fill_viridis_d()


# sub_crops %>%
#   filter(commodity %in% otherCrops) %>%
#   mutate(year = as.factor(year),
#          level = as.factor(level)) %>%
#   ggplot(aes(x = year, y = prop_harvested, fill = unit)) +
#   geom_violin() +
#   facet_wrap(~ commodity, ncol = 2) +
#   theme(legend.position = "bottom") +
#   scale_fill_viridis_d()


# sub_crops %>%
#   filter(!commodity %in% c(majorCrops, frequentCrops, otherCrops)) %>%
#   mutate(year = as.factor(year),
#          level = as.factor(level)) %>%
#   ggplot(aes(x = year, y = prop_harvested, fill = unit)) +
#   geom_violin() +
#   facet_wrap(~ commodity, ncol = 2) +
#   theme(legend.position = "bottom") +
#   scale_fill_viridis_d()
