message("\n---- process landcover ----")


# load data ----
#

split landcover layer into the groups of interest (water, urban, pristine) and then use zonal statistics with the target resolution (1 km) to get the sum/proportion of each layer per 1 km cell

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
