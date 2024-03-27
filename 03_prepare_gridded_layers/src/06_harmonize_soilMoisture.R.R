# ----
# title        : _INSERT
# authors      : Steffen Ehrmann
# version      : 0.0.0
# date         : 2024-MM-DD
# description  : This script resamples the Guevara soil-moisture dataset to a
#                1km² resolution
# documentation: file.edit(paste0(dir_docs, "/documentation/_INSERT.md"))
# ----
message("\n---- rescale soil moisture (from 15km² to 1km²) ----")

# 1. make paths ----
#
if(!testDirectoryExists(paste0(dir_data,"processed/soilMoisture"))){
  dir.create(paste0(dir_data,"processed/soilMoisture"))
}

# 2. load data ----
#
message(" --> pull input files")
inFiles <- list.files(path = paste0(dir_data, "original/soilMoisture"))
if(!"sm_kknn_terrain" %in% inFiles){
  untar(exdir = paste0(dir_data, "original/soilMoisture"),
        tarfile = paste0(dir_data, "original/soilMoisture/sm_kknn_terrain.tar.xz"))
}

targetFiles <- list.files(path = paste0(dir_data, "original/soilMoisture/sm_kknn_terrain"),
                          full.names = TRUE, pattern = "grd")

template <- rast(xmin = -180, xmax = 180, ymin = -90, ymax = 90, ncols = 43200, nrows = 21600)

# 3. data processing ----
#
## _INSERT ----
message(" --> _INSERT")

message(" --> disaggregate ...")
for(i in seq_along(targetFiles)){

  theFile <- targetFiles[i]
  year <- str_split(string = theFile, pattern = "/")[[1]]
  year <- str_split(string = tail(year, 1), pattern = "_")[[1]][6]
  message("     ...'", year, "'")

  temp <- wrap(rast(theFile))

  disagg(x = rast(temp), fact = 15, method = "near",
         filename = paste0(dir_data, "processed/soilMoisture/soildMoisture-moisture_", year, "0000_1km.tif"),
         overwrite = TRUE,
         filetype = "GTiff",
         datatype = "FLT4S",
         gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

}

## _INSERT ----
message(" --> _INSERT")

# 4. write output ----
#
write_rds(x = _INSERT, file = _INSERT)

# beep(sound = 10)
message("\n     ... done")


# # script description ----
# #
# # This script pre-processes the Guevara soil-moisture dataset:
# # - resample to a 1km² resolution
#
#
# # script arguments ----
# #
# thisDataset <- "soilMoisture"
# inPath <- paste0(gridDBDir, "input", thisDataset, "/")
# outPath <- paste0(gridDBDir, "processed/", thisDataset, "/")
# assertDirectoryExists(x = inPath)
# message("\n---- ", thisDataset, " ----")
#
# description <- ""
# url <- ""    # ideally the doi, but if it doesn't have one, the main source of the database
# license <- ""
#
#
# # reference ----
# #
# bib <- ris_reader(paste0(inPath, "")) # or bibtex_reader()
#
# regDataset(name = thisDataset,
#            description = description,
#            url = url,
#            download_date = "", # YYYY-MM-DD
#            type = "", # dynamic or static
#            licence = license,
#            contact = "", # optional, if it's a paper that should be "see corresponding author"
#            disclosed = "", # whether the data are freely available "yes"/"no"
#            bibliography = bib,
#            path = gridDBDir)
#
#
# # pre-process data ----
# #
# inFiles <- list.files(path = inPath)
# if(!"sm_kknn_terrain" %in% inFiles){
#   untar(exdir = inPath,
#         tarfile = paste0(inPath, "sm_kknn_terrain.tar.xz"))
# }
#
#
# # read dataset ----
# #
# targetFiles <- list.files(path = paste0(inPath, "sm_kknn_terrain"),
#                           full.names = TRUE, pattern = "grd")
#
#
# # data processing ----
# #
# message(" --> disaggregate ...")
# for(i in seq_along(targetFiles)){
#
#   theFile <- targetFiles[i]
#   year <- str_split(string = theFile, pattern = "/")[[1]]
#   year <- str_split(string = tail(year, 1), pattern = "_")[[1]][6]
#   message("     ...'", year, "'")
#
#   temp <- wrap(rast(theFile))
#
#   disagg(x = rast(temp), fact = 15, method = "near",
#          filename = paste0(outPath, "soildMoisture-moisture_", year, "0000_1km.tif"),
#          overwrite = TRUE,
#          filetype = "GTiff",
#          datatype = "FLT4S",
#          gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))
#
# }
#
# message(" --> subset ...")
# for(i in seq_along(profile$year)){
#
#   theLayer <- paste0(outPath, "soildMoisture-moisture_", profile$year[i], "0000_1km.tif")
#   theTiles <- paste0()
#   assertFileExists(x = theFile, access = "r")
#
#   crop(x = theLayer, y = theTiles,
#        filename = paste0(outPath, "soildMoisture-moisture_", year, "0000_1km_", profile$name, "_", profile$version, ".tif"),
#        overwrite = TRUE,
#        filetype = "GTiff",
#        datatype = "FLT4S",
#        gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))
#
# }
#
#
# # write output ----
# #
# message("\n---- done ----")
