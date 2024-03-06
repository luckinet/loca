message("\n---- construct model-specific layers ----")


# derive input objects ----
#
if(!exists("rst_worldTemplate")){
  rst_worldTemplate <- rast(res = model_info$parameters$pixel_size[1], vals = 1)
}

vct_modelregion <- vect(ext(model_info$parameters$extent), crs = crs(rst_worldTemplate))

# derive model mask ----
#
message(" --> model mask")
mask(x = rst_worldTemplate, mask = vct_modelregion,
     filename = path_modelregion,
     overwrite = TRUE,
     filetype = "GTiff",
     datatype = "INT1U",
     gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))


# beep(sound = 10)
message("\n     ... done")
