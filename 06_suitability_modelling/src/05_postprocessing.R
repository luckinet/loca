# script arguments ----
#
message("\n---- post-processing ----")

assertList(x = profile, len = 12)
assertList(x = files)


# load data ----
#
target_ids <- list.files(paste0(profile$dir, "tiles/"))
target_ids <- unique(map_chr(.x = seq_along(target_ids), .f = function(ix){
  str_split(target_ids[ix], "_")[[1]][2]
}))
target_ids <- target_ids[!is.na(as.numeric(target_ids))]

# data processing ----
#
# 1. mosaic the tiles to one map per driver
for(i in seq_along(target_ids)){

  message(" --> processing '", target_ids[i], "' --")

  message("     --> assemble tiles")
  tileTifs <- list.files(path = paste0(profile$dir, "tiles"),
                         pattern = paste0("suit_", target_ids[i]),
                         full.names = TRUE)

  # identify years
  targetYears <- unique(map_chr(.x = seq_along(tileTifs), .f = function(ix){
    temp <- str_split(tileTifs[ix], "/")[[1]]
    str_split(temp[length(temp)], "_")[[1]][3]
  }))

  for(j in targetYears){

    yearlyTifs <- list.files(path = paste0(profile$dir, "tiles"),
                             pattern = paste0("suit_", target_ids[i], "_", j),
                             full.names = TRUE)

    mosaic_rasters(gdalfile = yearlyTifs,
                   dst_dataset = str_replace(files$suit_X_Y, "_X_Y_", paste0("_", target_ids[i], "_", j, "_")),
                   of = "GTiff",
                   ot = "Float32",
                   co = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

    message("     --> rescale layer to landcover resolution")
    gdalUtils::gdal_translate(src_dataset = str_replace(files$suit_X_Y, "_X_Y_", paste0("_", target_ids[i], "_", j, "_")),
                              dst_dataset = str_replace(files$suit10_X_Y, "_X_Y_", paste0("_", target_ids[i], "_", j, "_")),
                              overwrite = TRUE,
                              tr = profile$pixel_size/3,
                              r = "nearest",
                              co = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

  }
}
