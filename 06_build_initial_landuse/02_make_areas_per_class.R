# This script produces for each class of the initial landcover map a map of the
# areas covered by that class.
message("\n ---- starting script ----")


# set paths ----
#
projDir <- selectPath(idivnb283 = "/media/se87kuhe/external1/projekte/LUCKINet/",
                      frontend1 = "/data/idiv_meyer/01_projects/LUCKINet/")
dataDir <- paste0(projDir, "01_data/")


# load metadata ----
#
profile <- load_profile(root = dataDir, name = "sandbox", version = "0.1.0")
runDir <- paste0(dataDir, "run/", profile$name, "_", profile$version, "/")


# load data ----
#
mp_mask10 <- raster(paste0(runDir, "maps/regionMask_sandbox_0.1.0_10arcSec.tif"))
mp_area10 <- raster(x = paste0(runDir, "maps/pixelArea_sandbox_0.1.0_10arcSec.tif"))

message("\n ---- seggregate initial landcover ----")
tifFiles <- list.files(path = paste0(runDir, "landcover"), pattern = paste0(as.character(profile$years[1]), "0101_10arcSec.tif"), full.names = TRUE)
assertCharacter(x = tifFiles, len = 1)

mp_lc <- raster(tifFiles)
vals <- sort(unique(values(mp_lc)))
map(.x = vals, .f = function(ix){

  message("\n", paste0(" --> class ", ix, " ----"))
  temp <- mp_area10
  temp[mp_lc != ix] <- NA

  writeRaster(x = temp,
              filename = paste0(runDir, "tiles/pixelArea_", ix, "_sandbox_0.1.0_10arcSec.tif"),
              overwrite = TRUE,
              format = "GTiff",
              datatype = "FLT4S",
              options = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))
  removeTmpFiles(h = 0)

})

message("\n ---- done ----")
