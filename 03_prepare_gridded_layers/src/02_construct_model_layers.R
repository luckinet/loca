message("\n---- construct model-specific layers ----")


# derive input objects ----
#
if(!exists("world_template")){
        world_template <- rast(res = model_info$parametes$pixel_size[1], vals = 1)
}

model_vect <- vect(ext(model_info$parametes$extent), crs = crs(world_template))

# derive model mask ----
#
message(" --> model mask")
mask(x = world_template, mask = model_vect,
     filename = path_modelregion,
     overwrite = TRUE,
     filetype = "GTiff",
     datatype = "INT1U",
     gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))


# beep(sound = 10)
message("\n     ... done")
