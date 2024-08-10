# ----
# title       : prepare gridded layers - global basis
# description : This is the script for preparing template files that are used throughout the modelling pipeline
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-03-27
# version     : 1.0.0
# status      : done
# comment     : file.edit(paste0(dir_docs, "/documentation/03_prepare_gridded_layers.md"))
# ----
# doi/url     : _INSERT
# license     : _INSERT
# resolution  : _INSERT
# years       : _INSERT
# variables   : _INSERT
# ----

message("\n---- construct basic gridded layers ----")

# data processing ----
#
## derive template raster ----
message(" --> pixel template")
rst_worldTemplate <- rast(res = model_info$parameters$pixel_size[1], vals = 0)

writeRaster(x = rst_worldTemplate,
            filename = path_template,
            overwrite = TRUE,
            filetype = "GTiff",
            datatype = "INT1U",
            gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))


# write output ----
#

# beep(sound = 10)
message("\n     ... done")


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

