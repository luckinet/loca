# ----
# title        : _INSERT
# authors      : Steffen Ehrmann
# version      : 0.0.0
# date         : 2022-02-23
# description  : This script builds rasters of all sort of national level
#                socio-economic indicator variables from FAOstat by downscaling
#                them to a 1km² grid.
# documentation: -
# ----
message("\n---- rasterise WORLDBANK indicators (at 1km²) ----")

# 1. make paths ----
#
if(!testDirectoryExists(paste0(dataDir,"processed/WORLDBANK_indicators"))){
  dir.create(paste0(dataDir,"processed/WORLDBANK_indicators"))
}

# 2. load data ----
#
message(" --> pull input files")
inFiles <- list.files(path = paste0(dataDir, "gridded_data/"))
if(!"WORLDBANK_indicators" %in% inFiles){
  untar(exdir = paste0(dataDir, "gridded_data/WORLDBANK_indicators"), tarfile = paste0(dataDir, "gridded_data/worldbank_20220223.tar.xz"))
}

targetFiles <- list.files(path = paste0(dataDir, "gridded_data/WORLDBANK_indicators"), full.names = TRUE)

# 3. data processing ----
#
## _INSERT ----
message(" --> _INSERT")
for(i in seq_along(targetFiles)){






  writeRaster(x = ,
              filename = ,
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
