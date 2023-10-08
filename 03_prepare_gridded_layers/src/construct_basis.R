message("\n---- construct basic gridded layers ----")


# derive template raster ----
#
message(" --> pixel template")
world_template <- rast(res = profile$pixel_size[1], vals = 0)

writeRaster(x = world_template,
            filename = templ_pixels,
            overwrite = TRUE,
            filetype = "GTiff",
            datatype = "INT1U",
            gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

message(" --> model mask")
model_mask <- crop(x = world_template, y = ext(profile$extent))
values(model_mask) <- 1

writeRaster(x = model_mask,
            filename = mask_modelregion_path,
            overwrite = TRUE,
            filetype = "GTiff",
            datatype = "INT1U",
            gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))


# derive pixel areas ----
#
message(" --> pixel areas")



writeRaster(x = ,
            filename = ,
            overwrite = TRUE,
            filetype = "GTiff",
            datatype = "FLT4S",
            gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))


# setup gdal-vrt ----
#
message("\n---- setup virtual dataset ----")
https://joshobrien.github.io/gdalUtilities/
https://gdal.org/programs/gdalbuildvrt.html



# beep(sound = 10)
message("\n     ... done")
