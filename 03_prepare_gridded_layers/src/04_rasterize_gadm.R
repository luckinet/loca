# ----
# title        : rasterize GADM
# authors      : Steffen Ehrmann
# version      : 1.0.0
# date         : 2024-03-27
# description  : _INSERT
# documentation: -
# ----
message("\n---- rasterize gadm ----")

# 1. make paths ----
#
path_vct_gadm1 <- paste0(dir_input, "gadm_admin_lvl1.gpkg")
path_rst_gadm1 <- str_replace(path_ahID, "\\{LVL\\}", "1")

# 2. load data ----
#
vct_gadm_lvl1 <- st_read(dsn = paste0(dir_input, "gadm36_levels.gpkg"), layer = "level0")
vct_gadm_lvl2 <- st_read(dsn = paste0(dir_input, "gadm36_levels.gpkg"), layer = "level1")
vct_gadm_lvl3 <- st_read(dsn = paste0(dir_input, "gadm36_levels.gpkg"), layer = "level2")
vct_gadm_lvl4 <- st_read(dsn = paste0(dir_input, "gadm36_levels.gpkg"), layer = "level3")

tbl_geoscheme <- readRDS(file = path_geoscheme_gadm)

# 3. data processing ----
#
tbl_countries <- get_concept(class = "al1", ontology = path_gaz) %>%
  arrange(label) %>%
  select(-has_broader_match, -has_narrower_match, -has_exact_match, -has_close_match) %>%
  left_join(tbl_geoscheme, by = c("label" = "unit")) %>%
  mutate(ahID = str_replace_all(id, "[.]", ""), .after = "id")

## simplify geometries ----
message(" --> simplify geometries")
# vct_temp <- st_cast(vct_gadm_lvl1, "POLYGON") %>%
#   st_simplify(preserveTopology = TRUE, dTolerance = 500) %>%
#   group_by(NAME_0) %>%
#   summarise()
vct_temp <- vct_gadm_lvl1

vct_temp <- vct_temp[!st_is_empty(vct_temp), , drop = FALSE]

message(" --> write simplified geometries to disk")
vct_temp %>% st_cast("MULTIPOLYGON") %>%
  full_join(tbl_countries, by = "NAME_0") %>%
  filter(!is.na(id)) %>%
  arrange(id) %>%
  st_write(dsn = path_vct_gadm1, delete_layer = TRUE)

## rasterize simplified geometries
message(" --> _INSERT")
gdalUtilities::gdal_rasterize(src_datasource = path_vct_gadm1,
                              dst_filename = path_rst_gadm1,
                              a = "ahID", at = TRUE,
                              te = c(-180, -90, 180, 90), tr = c(0.00833333333333333, 0.00833333333333333),
                              co = c("COMPRESS=DEFLATE", "ZLEVEL=9"))

# this is required because gdal_rasterize slightly offsets the extent when using
# option "tap = TRUE" (which would be faster)
crop(x = rast(path_rst_gadm1), y = rast(path_modelregion),
     filename = str_replace(path_ahID_model, "\\{LVL\\}", "1"),
     overwrite = TRUE,
     filetype = "GTiff",
     datatype = "FLT4S",
     gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

# 4. write output ----
#

# beep(sound = 10)
message("\n     ... done")


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
