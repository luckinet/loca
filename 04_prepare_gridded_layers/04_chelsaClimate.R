# ----
# title       : prepare gridded layers - CHELSA climate
# description : This is the script for hamonizing _INSERT
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann, Ruben Remelgado
# date        : 2024-MM-DD
# version     : 0.0.0
# status      : find data, update, inventarize, validate, normalize, done
# comment     : file.edit(paste0(dir_docs, "/documentation/03_prepare_gridded_layers.md"))
# ----
# doi/url     : _INSERT
# license     : _INSERT
# resolution  : _INSERT
# years       : _INSERT
# variables   : _INSERT
# ----

thisDataset <- "chelsaClimate"
message("\n---- ", thisDataset, " ----")

thisDir <- .get_path(module = "grid", data = thisDataset)


message(" --> handling metadata")
regDataseries(name = thisDataset,
              description = _INSERT,
              homepage = _INSERT,
              version = _INSERT,
              licence_link = _INSERT,
              reference = read.bib(paste0(thisDir, "_INSERT.bib")))

message(" --> handling data")
# crop layer(s) to model region ----
#
theseFiles <- list.files(path = thisDir, pattern = "_1km.tif")

for(i in seq_along(theseFiles)){

  thisFile <- paste0(thisDir, theseFiles[i])
  thisDir_mdl <- str_replace(string = thisFile,
                             pattern = ".tif",
                             replacement = paste0("_", model_name, "_", model_version, ".tif"))

  if(testFileExists(x = thisDir_mdl, access = "rw")) next
  message(" ---- layer ", theseFiles[i], " ----")
  crop(x = rast(thisFile), y = rast(x = path_modelregion),
       snap = "out",
       filename = thisDir_mdl,
       overwrite = TRUE,
       filetype = "GTiff",
       datatype = datatype(rast(thisFile)),
       gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

}

beep(sound = 10)
message("\n     ... done")





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
