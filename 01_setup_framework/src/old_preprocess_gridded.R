# author and date of creation ----
#
# Steffen Ehrmann, 23.02.2021


# script description ----
#
# This script extracts meta-data on the basic landcover dataset and crops all
# model years to the target extent.
message("\n---- 02 - preprocess gridded ----")


# script arguments ----
#
assertList(x = profile, len = 12)                  # ensure that profile is set
assertList(x = files)


# load metadata ----
#

covMeta <- get_meta_gridDB(path = profile$dir, covariates = profile$landcover) %>%
  filter(year %in% profile$years)


# load data ----
#
geomTiles <- st_read(dsn = files$geomTiles)

# data processing ----
#
tilesBox <- getExtent(geomTiles)

message(" --> pull initial landcover grid")
lcTifs <- pull_layers(paths = covMeta$path[1],
                      extent = tilesBox, outDir = paste0(profile$dir, "intermediate/"))

message(" --> mask initial landcover grid")
newTif <- remove_file_extension(lcTifs)

mask(x = rast(lcTifs), mask = rast(files$regionMask10), maskvalues = 0,
     filename = str_replace(files$landcover_Y, "_Y_", paste0("_", profile$years[1], "_")),
     overwrite = TRUE,
     filetype = "GTiff",
     datatype = "FLT4S",
     gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

message(" --> territorial units * landcover classes")
fact <- rast(files$ahID1)
fact <- setMinMax(fact)
fact <- as.numeric(paste0(1, paste0(rep(0, nchar(max(minmax(fact)))), collapse = "")))

mp_temp <- rast(files$ahID1) + fact * rast(str_replace(files$landcover_Y, "_Y_", paste0("_", profile$years[1], "_")))
writeRaster(x = mp_temp,
            filename = files$ahID1LC,
            overwrite = TRUE,
            filetype = "GTiff",
            datatype = "FLT4S",
            gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))


message(" --> calculate pixel areas (at 10 arc-seconds)")
# calculate pixel areas for 10arcSec raster
cellSize(x = rast(lcTifs),
         filename = files$pixelArea10,
         overwrite = TRUE,
         filetype = "GTiff",
         datatype = "FLT4S",
         gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

message(" --> mask pixel areas")
mask(x = rast(files$pixelArea10), mask = rast(files$regionMask10), maskvalues = 0,
     filename = files$pixelArea10,
     overwrite = TRUE,
     filetype = "GTiff",
     datatype = "FLT4S",
     gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

message(" --> calculate pixel areas (at 30 arc-seconds)")
# aggregate it to 30arcSec ...
gdalUtils::gdalwarp(srcfile = lcTifs,
                    dstfile = files$pixelArea30,
                    overwrite = TRUE, tr = profile$pixel_size)

# ... and (re)calculate also the pixel area for that
cellSize(x = rast(files$pixelArea30),
         filename = files$pixelArea30,
         overwrite = TRUE,
         filetype = "GTiff",
         datatype = "FLT4S",
         gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

message(" --> mask pixel areas")
mask(x = rast(files$pixelArea30), mask = rast(files$regionMask30), maskvalues = 0,
     filename = files$pixelArea30,
     overwrite = TRUE,
     filetype = "GTiff",
     datatype = "FLT4S",
     gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))


message(" --> derive restricted fraction (simulated currently)")
# when making this map, it needs to be made sure that the restrictions are
# consistent with ESALC information, such as that mosaic cropland vs natural
# must not have more than 50% restricted area.
mp_cover <- rast(str_replace(files$landcover_Y, "_Y_", paste0("_", profile$years[1], "_")))
mp_rest <- rast(ncols = ncol(mp_cover), nrows = nrow(mp_cover),
                xmin = xmin(mp_cover), xmax = xmax(mp_cover), ymin = ymin(mp_cover), ymax = ymax(mp_cover))

init(mp_rest, fun = function(ix){rnorm(ix, 0, 0.01)},
     filename = files$areaRestricted,
     overwrite = TRUE,
     filetype = "GTiff",
     datatype = "FLT4S",
     gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

message(" --> mask restricted fraction")
mask(x = rast(files$areaRestricted), mask = rast(x = files$regionMask10), maskvalues = 0,
     filename = files$areaRestricted,
     overwrite = TRUE,
     filetype = "GTiff",
     datatype = "FLT4S",
     gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

message(" --> calculate restricted fraction areas")
mp_rest <- rast(files$areaRestricted) * rast(x = files$pixelArea10)
writeRaster(x = mp_rest,
            filename = files$areaRestricted,
            overwrite = TRUE,
            filetype = "GTiff",
            datatype = "FLT4S",
            gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))


# beep(sound = 10)
message("---- done ----")
