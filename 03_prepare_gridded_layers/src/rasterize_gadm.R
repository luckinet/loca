# This script builds rasters of all sort of national level socio-economic
# indicator variables from FAOstat by downscaling them to a 1km² grid.
message("\n---- rasterize gadm levels 1, 2, 3 ----")


# load data ----
#
geom <- st_read(dsn = paste0(input_dir, "gadm36_levels.gpkg"), layer = "level0")
template <- rast(templ_pixels_path)
countries <- get_concept(class == "al1", ontology = gaz_path)

# 1. simplify geometries ----
message(" --> simplify geometries")
temp <- st_cast(geom, "POLYGON") %>%
  st_simplify(preserveTopology = TRUE, dTolerance = 500) %>%
  group_by(NAME_0) %>%
  summarise()

temp <- temp[!st_is_empty(temp), , drop = FALSE]

message(" --> write simplified geometries to disk")
temp %>% st_cast("MULTIPOLYGON") %>%
  full_join(countries, by = c("NAME_0" = "label")) %>%
  filter(!is.na(id)) %>%
  filter(!st_is_empty(geom)) %>%
  arrange(id) %>%
  st_write(dsn = poly_ahID1_path, delete_layer = TRUE)

# 2. rasterise simplified geometries
gdalUtils::gdal_rasterize(src_datasource = poly_ahID1_path,
                          dst_filename = map_ahID1_path,
                          a = "ahID",
                          at = TRUE, te = ext(template), tr = res(template),
                          co = c("COMPRESS=DEFLATE", "ZLEVEL=9"))

#
# geom1 <- pull_geometries(path = paste0(dataDir, profile$censusDB_dir),
#                          nation = profile$censusDB_extent,
#                          layer = "level_1") %>%
#   filter(geoID == 1) %>%
#   gc_geom(group = TRUE)
#
# geom2 <- pull_geometries(path = paste0(dataDir, "areal_data/", profile$arealDB_dir),
#                          nation = profile$arealDB_extent,
#                          layer = "level_2")
#
# geom3 <- pull_geometries(path = paste0(dataDir, "areal_data/", profile$arealDB_dir),
#                          nation = profile$arealDB_extent,
#                          layer = "level_3")
#
# gdalUtilities::gdal_rasterize(src_datasource = files$geom1,
#                           dst_filename = files$ahID1,
#                           a = "ahID",
#                           at = TRUE, te = targetExtent, tr = profile$pixel_size/3,
#                           co = c("COMPRESS=DEFLATE", "ZLEVEL=9"))
#
# gdalUtilities::gdal_rasterize(src_datasource = files$geom2,
#                           dst_filename = files$ahID2,
#                           a = "ahID",
#                           at = TRUE, te = targetExtent, tr = profile$pixel_size/3,
#                           co = c("COMPRESS=DEFLATE", "ZLEVEL=9"))
#
# gdalUtilities::gdal_rasterize(src_datasource = files$geom3,
#                           dst_filename = files$ahID3,
#                           a = "ahID",
#                           at = TRUE, te = targetExtent, tr = profile$pixel_size/3,
#                           co = c("COMPRESS=DEFLATE", "ZLEVEL=9"))

# write output ----
#

# beep(sound = 10)
message("\n     ... done")
