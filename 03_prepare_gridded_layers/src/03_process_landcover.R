message("\n---- process landcover ----")


# load data ----
#



# make paths ----
#



# derive percent water cover ----
#


# derive percent urban cover ----
#


# derive percent pristine cover ----
#



writeRaster(x = ,
            filename = path_restricted,
            overwrite = TRUE,
            filetype = "GTiff",
            datatype = "INT1U",
            gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))


# beep(sound = 10)
message("     ... done")
