# ----
# title        : _INSERT
# authors      : Steffen Ehrmann
# version      : 0.3.0
# date         : 2024-03-27
# description  : _INSERT
# documentation: -
# ----
# script description ----

# 1. make paths ----
#
inPath <- paste0(gridDBDir, "input/WorldClim/")
outPath <- paste0(gridDBDir, "processed/WorldClim/")

# 2. load data ----
#
_INSERT <- read_rds(file = _INSERT)
tbl_INSERT <- read_csv(file = _INSERT)
vct_INSERT <- st_read(dsn = _INSERT)
rst_INSERT <- rast(_INSERT)

# 3. data processing ----
#
inFiles <- list.files(path = inPath)
if(!"" %in% inFiles){
  untar(exdir = inPath,
        tarfile = paste0(inPath, ""))
}
allLayers <- list.files(path = inPath)

## _INSERT ----
message(" --> _INSERT")
for(i in seq_along(allLayers)){

  newName <- str_split(allLayers[i], "[.]")[[1]][2]
  newName <- paste0(str_split(newName, "_")[[1]][c(3, 4)], collapse = "")

  writeRaster(rast(x = allLayers[1]),
              filename = paste0(outPath, "WorldClim-", newName, "_1km.tif"),
              overwrite = TRUE,
              filetype = "GTiff",
              datatype = "FLT4S",
              gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))
}

## _INSERT ----
message(" --> subset ...")
outLayers <- list.files(path = outPath)
for(i in seq_along(outLayers)){

  theLayer <- outLayers[i]
  theTiles <- paste0()
  assertFileExists(x = theFile, access = "r")

  crop(x = theLayer, y = theTiles,
       filename = paste0(outPath, "WorldClim-", newName, "_1km_", profile$name, "_", profile$version, ""),
       overwrite = TRUE,
       filetype = "GTiff",
       datatype = "FLT4S",
       gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

}

# 4. write output ----
#
write_rds(x = _INSERT, file = _INSERT)

# beep(sound = 10)
message("\n     ... done")
