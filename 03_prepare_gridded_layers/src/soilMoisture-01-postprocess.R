# script description ----
#
# This script resamples the Guevara soil-moisture dataset to a 1km² resolution
message("\n---- rescale soil moisture (from 15km² to 1km²) ----")


# script arguments ----
#
# make sure paths have been set
# assertDirectoryExists(x = dataDir)

# create directories
# if(!testDirectoryExists(paste0(dataDir,"processed/soilMoisture"))){
#   dir.create(paste0(dataDir,"processed/soilMoisture"))
# }


# load data ----
#
message(" --> pull input files")
inFiles <- list.files(path = paste0(dataDir, "original/soilMoisture"))
if(!"sm_kknn_terrain" %in% inFiles){
  untar(exdir = paste0(dataDir, "original/soilMoisture"),
        tarfile = paste0(dataDir, "original/soilMoisture/sm_kknn_terrain.tar.xz"))
}

targetFiles <- list.files(path = paste0(dataDir, "original/soilMoisture/sm_kknn_terrain"),
                          full.names = TRUE, pattern = "grd")


# data processing ----
#
template <- rast(xmin = -180, xmax = 180, ymin = -90, ymax = 90, ncols = 43200, nrows = 21600)

message(" --> disaggregate ...")
for(i in seq_along(targetFiles)){

  theFile <- targetFiles[i]
  year <- str_split(string = theFile, pattern = "/")[[1]]
  year <- str_split(string = tail(year, 1), pattern = "_")[[1]][6]
  message("     ...'", year, "'")

  temp <- wrap(rast(theFile))

  disagg(x = rast(temp), fact = 15, method = "near",
         filename = paste0(dataDir, "processed/soilMoisture/soildMoisture-moisture_", year, "0000_1km.tif"),
         overwrite = TRUE,
         filetype = "GTiff",
         datatype = "FLT4S",
         gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

}

# write output ----
#
message("\n---- done ----")
