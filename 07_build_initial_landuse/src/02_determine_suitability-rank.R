# ----
# title        : determine suitability rank
# authors      : Steffen Ehrmann
# version      : 0.8.0
# date         : 2024-03-27
# description  : This script determines the suitability rank of all invovled
#                classes. The suitability rank of a class is determined by
#                ranking the values of all classes at a per-pixel basis.
# documentation: -
# ----
#
message("\n ---- determine suitability rank ----")

# 1. make paths ----
#
tifs <- make_rasternames(profile = profile, module = "initial landuse", step = "suitability rank")

# 2. load data ----
#
lc_limits <- readRDS(file = paste0(profile$dir, "tables/landcover_limits.rds"))

# initial landuse census
census_init <- readRDS(file = paste0(profile$dir, "tables/census.rds")) %>%
  left_join(lc_limits %>% select(luckinetID, short) %>% distinct(), by = "luckinetID") %>%
  filter(year == profile$years[1])

target_ids <- census_init %>%
  filter(area != 0) %>%
  distinct(luckinetID) %>%
  pull(luckinetID)

# the bounding box and its tiles
bbox_tiles <- st_read(dsn = paste0(profile$dir, "/visualise/tiles.gpkg"))
target_tiles <- bbox_tiles$target

# 3. data processing ----
#
## determine rank of suitability between layers ----
message("---- suitability rank ----")
for(i in seq_along(target_tiles)){

  if(!target_tiles[i]){
    next
  }
  message(paste0(" --> tile ", i, " ----"))

  mp_suit <- rast(x = str_replace(tifs$suit_X_Y_Z, "_X_Y_Z_", paste0("_", target_ids, "_", profile$years[1], "_", i, "_")))

  vals <- values(mp_suit)
  ranks <- as_tibble(t(apply(-vals, 1, rank, ties.method = 'min', na.last = "keep")), .name_repair = "minimal")

  map(.x = 1:dim(mp_suit)[3], .f = function(ix){
    mp_suit[[ix]][] <- ranks[[ix]]

    writeRaster(x = mp_suit[[ix]],
                filename = str_replace(tifs$suitRank_X_Z, "_X_Z_", paste0("_", target_ids[ix], "_", i, "_")),
                overwrite = TRUE,
                filetype = "GTiff",
                datatype = "FLT4S")
  })
}

## mosaic the suitability rank tiles to one map per landuse class ----
message("---- mosaic tiles ----")
for(i in seq_along(target_ids)){

  if(length(target_tiles) > 1){
    tileTifs <- list.files(path = paste0(profile$dir, "tiles"),
                           pattern = paste0("suitRank_", target_ids[i], "_", profile$years[1], "_", profile$name, "_", profile$version),
                           full.names = TRUE)

    outTif <- paste0(profile$dir, "intermediate/suitRank_", target_ids[i], "_", profile$years[1], "_",
                     profile$name, "_", profile$version, ".tif")
    mosaic_rasters(gdalfile = tileTifs,
                   dst_dataset = outTif,
                   of = "GTiff", ot = "Float32", co = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))
  } else {
    file.copy(from = str_replace(tifs$suitRank_X_Z, "_X_Z_", paste0("_", target_ids[i], "_1_")),
              to = str_replace(tifs$suitRank_X, "_X_", paste0("_", target_ids[i], "_")))
  }

}

## rescale maps to target resolution (in case the pixel size deviates from the target) ----
mp_suitRank <- rast(x = str_replace(tifs$suitRank_X, "_X_", paste0("_", target_ids, "_")))

if(any(res(mp_suitRank) != profile$pixel_size)){

  message("---- rescale to target resolution ----")
  map(.x = seq_along(target_ids), .f = function(ix){
    gdalUtils::gdal_translate(src_dataset = str_replace(tifs$suitRank_X, "_X_", paste0("_", target_ids[ix], "_")),
                              dst_dataset = str_replace(tifs$suitRank_X, "_X_", paste0("_", target_ids[ix], "_new_")),
                              overwrite = TRUE,
                              tr = res(mp_suitRank)/profile$pixel_size,
                              r = "nearest")
    file.copy(from = str_replace(tifs$suitRank_X, "_X_", paste0("_", target_ids[ix], "_new_")),
              to = str_replace(tifs$suitRank_X, "_X_", paste0("_", target_ids[ix], "_")),
              overwrite = TRUE)
    file.remove(str_replace(tifs$suitRank_X, "_X_", paste0("_", target_ids[ix], "_new_")))
  })

}

# 4. write output ----
#
write_rds(x = _INSERT, file = _INSERT)

# beep(sound = 10)
message("\n     ... done")
