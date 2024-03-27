# ----
# title        : construct global basis
# authors      : Steffen Ehrmann
# version      : 0.8.0
# date         : 2024-03-27
# description  : _INSERT
# documentation: -
# ----
message("\n---- construct basic gridded layers ----")

# 1. make paths ----
#

# 2. load data ----
#
rst_worldTemplate <- rast(res = model_info$parameters$pixel_size[1], vals = 0)

# 3. data processing ----
#
## derive template raster ----
message(" --> pixel template")

writeRaster(x = rst_worldTemplate,
            filename = path_template,
            overwrite = TRUE,
            filetype = "GTiff",
            datatype = "INT1U",
            gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))


# message(" --> derive restricted fraction (simulated currently)")
# # when making this map, it needs to be made sure that the restrictions are
# # consistent with ESALC information, such as that mosaic cropland vs natural
# # must not have more than 50% restricted area.
# mp_cover <- rast(str_replace(files$landcover_Y, "_Y_", paste0("_", profile$years[1], "_")))
# mp_rest <- rast(ncols = ncol(mp_cover), nrows = nrow(mp_cover),
#                 xmin = xmin(mp_cover), xmax = xmax(mp_cover), ymin = ymin(mp_cover), ymax = ymax(mp_cover))
#
# init(mp_rest, fun = function(ix){rnorm(ix, 0, 0.01)},
#      filename = files$areaRestricted,
#      overwrite = TRUE,
#      filetype = "GTiff",
#      datatype = "FLT4S",
#      gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))


# message(" --> mask restricted fraction")
# mask(x = rast(files$areaRestricted), mask = rast(x = files$regionMask10), maskvalues = 0,
#      filename = files$areaRestricted,
#      overwrite = TRUE,
#      filetype = "GTiff",
#      datatype = "FLT4S",
#      gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))


# message(" --> calculate restricted fraction areas")
# mp_rest <- rast(files$areaRestricted) * rast(x = files$pixelArea10)
# writeRaster(x = mp_rest,
#             filename = files$areaRestricted,
#             overwrite = TRUE,
#             filetype = "GTiff",
#             datatype = "FLT4S",
#             gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))


# message(" --> build tiles")
# if the extent is too large for a single model run, split it up into smaller
# pieces
#
# derive extent that snaps to the target resolution
# bbox <- getExtent(geom1) %>%
#   snap_to_res(res = profile$pixel_size)
# bboxPointExtent <- getExtent(geomPoints) %>%
#   snap_to_res(res = profile$pixel_size) %>%
#   gs_rectangle()
#
# nTiles <- c(ceiling((max(bbox$x) - min(bbox$x))/profile$tile_size[1]),
#             ceiling((max(bbox$y) - min(bbox$y))/profile$tile_size[2]))
#
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
#
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
#
# gc_sf(bbox_tiles) %>% st_write(dsn = files$geomTiles, delete_layer = TRUE)

# 4. write output ----
#

# beep(sound = 10)
message("\n     ... done")
