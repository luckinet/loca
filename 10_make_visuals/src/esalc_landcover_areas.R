message("\n---- ESA Landcover areas ----")

# load metadata ----
#
coverTif <- paste0(dataDir, "gridDB/CCI_landCover/CCI_landCover-landCover_20200000_300m.tif")


# load data ----
#
countries <- read_rds(file = paste0(dataDir, "countries.rds"))


# initial landcover
mp_cover <- rast(coverTif)


# data processing ----
#
landcover_esa <- map_dfr(.x = seq_along(countries$unit), .f = function(ix){

  message("  --> ", countries$unit[ix])
  mp_temp <- crop(mp_cover, countries[ix,])
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


# write output ----
#
write_rds(x = landcover_esa, paste0(dataDir, "tables/landcover_esa.rds"))

message("\n ---- done ----")
