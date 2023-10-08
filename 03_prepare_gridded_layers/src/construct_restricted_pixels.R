message("\n---- construct restricted pixels ----")






writeRaster(x = ,
            filename = mask_restricted_path,
            overwrite = TRUE,
            filetype = "GTiff",
            datatype = "INT1U",
            gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))


# beep(sound = 10)
message("     ... done")
