# ----
# title        : calculate ESA-CCI landcover areas
# authors      : Steffen Ehrmann
# version      : 0.8.0
# date         : 2024-03-27
# description  : _INSERT
# documentation: -
# ----
message("\n---- ESA Landcover areas ----")

# 1. make paths ----
#
path_landcover <- str_replace(path_landcover, "\\{YR\\}",
                              as.character(model_info$parameters$years[1]))
path_vct_gadm1 <- paste0(dir_input, "gadm_admin_lvl1.gpkg")

# 2. load data ----
#
tbl_geoscheme <- read_rds(file = path_geoscheme_gadm)
vct_gadm_lvl1 <- st_read(dsn = paste0(dir_input, "gadm36_levels.gpkg"), layer = "level0")

# 3. data processing ----
#
tbl_countries <- get_concept(class = "al1", ontology = path_gaz) %>%
  arrange(label) %>%
  select(-has_broader_match, -has_narrower_match, -has_exact_match, -has_close_match) %>%
  left_join(tbl_geoscheme, by = c("label" = "unit")) %>%
  mutate(ahID = str_replace_all(id, "[.]", ""), .after = "id")

landcover_esa <- map_dfr(.x = seq_along(tbl_countries$label), .f = function(ix){

  message("  --> ", tbl_countries$label[ix])

  mp_temp <- crop(rast(path_landcover), countries[ix,])
  mp_temp <- mask(x = mp_temp, vect(countries[ix,]))
  set.names(x = mp_temp, value = "zone")

  areas <- cellSize(x = mp_temp)
  temp <- zonal(x = areas, z = mp_temp, fun = "sum") %>%
    as_tibble() %>%
    mutate(ha = area/10000)

  land_area <- sum(temp$ha)
  crop_area <- temp %>%
    filter(zone %in% c(10, 11, 12, 20, 30)) %>%
    pull(ha) %>%
    sum(na.rm = TRUE)
  forest_area <- temp %>%
    filter(zone %in% c(50, 60, 61, 62, 70, 71, 72, 80, 81, 82, 90)) %>%
    pull(ha) %>%
    sum(na.rm = TRUE)
  mixedVeg_area <- temp %>%
    filter(zone %in% c(40, 100, 110, 120, 121, 122, 130, 140, 150, 151, 152, 153, 160, 170, 180)) %>%
    pull(ha) %>%
    sum(na.rm = TRUE)
  bare_area <- temp %>%
    filter(zone %in% c(190, 200, 201, 202)) %>%
    pull(ha) %>%
    sum(na.rm = TRUE)
  water_area <- temp %>%
    filter(zone %in% c(210)) %>%
    pull(ha) %>%
    sum(na.rm = TRUE)

  tibble(unit = countries$unit[ix],
         land_area,
         cropland = crop_area,
         `forest land` = forest_area,
         `other vegetation` = mixedVeg_area,
         `bare/urban` = bare_area,
         `water bodies` = water_area)

})

landcover_esa <- landcover_esa %>%
  pivot_longer(cols = c(cropland, `forest land`, `other vegetation`, `bare/urban`, `water bodies`),
               names_to = "type", values_to = "area") %>%
  mutate(prop = round(area/land_area * 100), 2) %>%
  mutate(year = 2020)


# 4. write output ----
#
write_rds(x = landcover_esa, paste0(dataDir, "tables/landcover_esa.rds"))

message("\n ---- done ----")
