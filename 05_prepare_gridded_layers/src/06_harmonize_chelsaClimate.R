# ----
# title        : harmonize CHELSA climatologies
# authors      : Steffen Ehrmann
# version      : 0.3.0
# date         : 2024-03-27
# description  : This script summarises rasters of all layers of the same
#                variable into a single raster to represent the overall amount
#                of the respective variable.
# documentation: file.edit(paste0(dir_docs, "/documentation/_INSERT.md"))
# ----
message("\n---- aggregate monthly CHELSA temperature to yearly values ----")
# terraOptions(tempdir = "work/ehrmann/Rtmp/", memmax = 50)

# 1. make paths ----
#
if(!testDirectoryExists(paste0(dir_data,"processed/CHELSA_climate"))){
  dir.create(paste0(dir_data,"processed/CHELSA_climate"))
}
inPath <- paste0(dir_data, "original/CHELSA/envicloud/chelsa/chelsa_V2/GLOBAL/monthly/")

# 2. load data ----
#
_INSERT <- read_rds(file = _INSERT)
tbl_INSERT <- read_csv(file = _INSERT)
vct_INSERT <- st_read(dsn = _INSERT)
rst_INSERT <- rast(_INSERT)

# 3. data processing ----
#
## _INSERT ----
message(" --> _INSERT")
for(i in 1998:2004){

  message(" --> '", i, "' ...")

  for(j in c("tas", "tasmin", "tasmax")){

    message("     '", j, "'")

    temp <- rast(list.files(path = paste0(inPath, j), pattern = as.character(i), full.names = TRUE))
    origin(temp) <- c(0, 0)
    temp <- wrap(temp)


    if(j == "tas"){

      out <- mean(x = rast(temp), na.rm = TRUE)
      varName <- "yearMeanTemperature"

    } else if(j == "tasmin"){

      out <- min(x = rast(temp), na.rm = TRUE)
      varName <- "yearMinimumTemperature"

    } else if(j == "tasmax"){

      out <- max(x = rast(temp), na.rm = TRUE)
      varName <- "yearMaxTemperature"

    }


    writeRaster(x = out,
                filename = paste0(dir_data, "processed/CHELSA_climate/CHELSA_climate-", varName, "_", i, "0000_1km.tif"),
                overwrite = TRUE,
                filetype = "GTiff",
                datatype = "FLT4S",
                gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

    rm(out); rm(temp)
    gc()

  }
}

# 4. write output ----
#
write_rds(x = _INSERT, file = _INSERT)

# beep(sound = 10)
message("\n     ... done")
