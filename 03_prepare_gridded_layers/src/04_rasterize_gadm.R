message("\n---- rasterize gadm ----")


# load data ----
#
vct_gadm_lvl1 <- st_read(dsn = paste0(dir_input, "gadm36_levels.gpkg"), layer = "level0")
if(!exists("rst_worldTemplate")){
  rst_worldTemplate <- rast(res = model_info$parametes$pixel_size[1], vals = 1)
}

tbl_geoscheme <- readRDS(file = path_geoscheme_gadm)

# make paths ----
#
path_temp <- paste0(dir_work, "vct_admin_lvl1.gpkg")
path_out <- str_replace(string = path_ahID,
                        pattern = "\\{LVL\\}",
                        replacement = "1")

tbl_countries <- get_concept(class = "al1", ontology = path_gaz) %>%
  arrange(label) %>%
  select(-has_broader_match, -has_narrower_match, -has_exact_match, -has_close_match) %>%
  left_join(tbl_geoscheme, by = c("label" = "unit")) %>%
  mutate(ahID = str_replace_all(id, "[.]", ""), .after = "id")

# 1. simplify geometries ----
message(" --> simplify geometries")
vct_temp <- st_cast(vct_gadm_lvl1, "POLYGON") %>%
  st_simplify(preserveTopology = TRUE, dTolerance = 500) %>%
  group_by(NAME_0) %>%
  summarise()

vct_temp <- vct_temp[!st_is_empty(vct_temp), , drop = FALSE]

message(" --> write simplified geometries to disk")
vct_temp %>% st_cast("MULTIPOLYGON") %>%
  full_join(tbl_countries, by = "NAME_0") %>%
  filter(!is.na(id)) %>%
  arrange(id) %>%
  st_write(dsn = path_temp, delete_layer = TRUE)

# 2. rasterize simplified geometries
gdalUtilities::gdal_rasterize(src_datasource = path_temp,
                              dst_filename = path_out,
                              a = "ahID",
                              at = TRUE, te = c(-180, -90, 180, 90), tr = c(0.00833333333333333, 0.00833333333333333),
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
