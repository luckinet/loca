# script arguments ----
#
message("\n---- prepare spatial basis ----")

assertList(x = profile, len = 13)
assertList(x = files)


# load metadata ----
#
sourceCpp(file = paste0(mdl00, "src/pointInGeom.cpp"))


# load data ----
#
# geom1 <- pull_geometries(path = paste0(dataDir, profile$censusDB_dir),
#                          nation = profile$censusDB_extent,
#                          layer = "level_1") %>%
#   filter(geoID == 1) %>%
#   gc_geom(group = TRUE)

# geom2 <- pull_geometries(path = paste0(dataDir, "areal_data/", profile$arealDB_dir),
#                          nation = profile$arealDB_extent,
#                          layer = "level_2")
#
# geom3 <- pull_geometries(path = paste0(dataDir, "areal_data/", profile$arealDB_dir),
#                          nation = profile$arealDB_extent,
#                          layer = "level_3")

# data processing ----
#
targetGeom <- st_read(dsn = files$gadm, layer = "level0",
                      quiet = TRUE, stringsAsFactors = FALSE) %>%
  st_crop(y = profile$extent) this seems to be super slow

message(" --> crop suitability predictors")


message(" --> subset occurrenceDB")




# message(" --> build gridDB meta-data")
# if(!testFileExists(x = paste0(profile$dir, "meta_gridDB.rds"))){
#   message(" --> deriving gridDB meta-data")
#   make_meta_gridDB(srcDir = gridDir, outDir = profile$dir,
#                    split = c("-", "_", "_"),
#                    fields = c("dataset", "subdataset", "date", "resolution"),
#                    profile = profile)
# }

# if the extent is too large for a single model run, split it up into smaller
# pieces
message(" --> build tiles")

# derive extent that snaps to the target resolution
# bbox <- getExtent(geom1) %>%
#   snap_to_res(res = profile$pixel_size)
# bboxPointExtent <- getExtent(geomPoints) %>%
#   snap_to_res(res = profile$pixel_size) %>%
#   gs_rectangle()

# nTiles <- c(ceiling((max(bbox$x) - min(bbox$x))/profile$tile_size[1]),
#             ceiling((max(bbox$y) - min(bbox$y))/profile$tile_size[2]))

# if(any(nTiles > 1)){
#
#   bbox_tiles <- bbox %>%
#     gs_rectangle() %>%
#     gs_tiles(width = profile$tile_size[1])
#
# } else {
#
#   bbox_tiles <- bbox %>%
#     gs_rectangle()
#
# }

# test whether the tiles actually contain anything of geom1
# bboxPoints <- getPoints(x = bbox_tiles)
# bboxGroups <- getGroups(x = bbox_tiles)
# bboxGroups$target <- map_lgl(.x = bboxGroups$gid, .f = function(ix){
#
#   tempTile <- bboxPoints %>%
#     filter(fid %in% ix)
#
#   geomX <- geom1@point[c("x", "y")] %>%
#     filter(x > min(tempTile$x) & x < max(tempTile$x))
#   geomY <- geom1@point[c("x", "y")] %>%
#     filter(y > min(tempTile$y) & y < max(tempTile$y))
#   tileInGeom <- (min(tempTile$x) < max(geomY$x) | max(tempTile$x) < min(geomY$x)) &
#     (min(tempTile$y) < max(geomX$y) | max(tempTile$y) > min(geomX$y))
#
#   geomInTile <- pointInGeomC(vert = as_matrix(geom1@point[c("x", "y")]),
#                              geom = as_matrix(tempTile[c("x", "y")]),
#                              invert = FALSE)
#   # tileInGeom <- pointInGeomC(vert = as_matrix(tempTile[c("x", "y")]),
#   #                            geom = as_matrix(geom1@point[c("x", "y")]),
#   #                            invert = FALSE)
#   any(geomInTile > 0) | tileInGeom
#
# })
# bbox_tiles <- setGroups(x = bbox_tiles, table = bboxGroups) %>%
#   setWindow(getExtent(bbox_tiles)) %>%
#   setCRS(getCRS(geom1))

# message(" --> rasterise geometries into ...")
# fullBbox <- getExtent(bbox_tiles)
# targetExtent <- paste0(c(min(fullBbox$x), min(fullBbox$y), max(fullBbox$x), max(fullBbox$y)), collapse = " ")
# message("     ... a region mask")
# gdalUtils::gdal_rasterize(src_datasource = files$geom1,
#                           dst_filename = files$regionMask30,
#                           at = TRUE, burn = 1, te = targetExtent, tr = profile$pixel_size,
#                           co = c("COMPRESS=DEFLATE", "ZLEVEL=9"))
#
# gdalUtils::gdal_rasterize(src_datasource = files$geom1,
#                           dst_filename = files$regionMask10,
#                           at = TRUE, burn = 1, te = targetExtent, tr = profile$pixel_size/3,
#                           co = c("COMPRESS=DEFLATE", "ZLEVEL=9"))
#
# message("     ... territorial units")
# gdalUtils::gdal_rasterize(src_datasource = files$geom1,
#                           dst_filename = files$ahID1,
#                           a = "ahID",
#                           at = TRUE, te = targetExtent, tr = profile$pixel_size/3,
#                           co = c("COMPRESS=DEFLATE", "ZLEVEL=9"))
#
# gdalUtils::gdal_rasterize(src_datasource = files$geom2,
#                           dst_filename = files$ahID2,
#                           a = "ahID",
#                           at = TRUE, te = targetExtent, tr = profile$pixel_size/3,
#                           co = c("COMPRESS=DEFLATE", "ZLEVEL=9"))
#
# gdalUtils::gdal_rasterize(src_datasource = files$geom3,
#                           dst_filename = files$ahID3,
#                           a = "ahID",
#                           at = TRUE, te = targetExtent, tr = profile$pixel_size/3,
#                           co = c("COMPRESS=DEFLATE", "ZLEVEL=9"))


# write output ----
#
# write_rds(x = countries, paste0(dataDir, "/tables/countries.rds"))
# gc_sf(bbox_tiles) %>% st_write(dsn = files$geomTiles, delete_layer = TRUE)
# gc_sf(geom1) %>% st_write(dsn = files$geom1, delete_layer = TRUE)
# st_write(obj = geom2, dsn = files$geom2, delete_layer = TRUE)
# st_write(obj = geom3, dsn = files$geom3, delete_layer = TRUE)

