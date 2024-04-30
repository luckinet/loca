# ----
# title        : _INSERT
# authors      : Steffen Ehrmann
# version      : 0.3.0
# date         : 2024-03-27
# description  : This script summarises rasters of all layers of the same
#                variable into a single raster to represent the overall amount
#                of the respective variable.
# documentation: file.edit(paste0(dir_docs, "/documentation/_INSERT.md"))
# ----
message("\n---- rename CHELSA climatologies ----")

# 1. make paths ----
#
if(!testDirectoryExists(paste0(dir_data,"processed/CHELSA_bio"))){
  dir.create(paste0(dir_data,"processed/CHELSA_bio"))
}

# 2. load data ----
#
message(" --> pull input files")
inFiles <- list.files(path = paste0(dir_data, "original/CHELSA/envicloud/chelsa/chelsa_V2/GLOBAL/climatologies/1981-2010/bio"), full.names = TRUE)

newName <- map(seq_along(inFiles), function(ix){
  temp <- str_split(inFiles[ix], "/")[[1]]
  temp <- str_split(tail(temp, 1), string = , "_")[[1]]
  temp <- temp[-c(1, length(temp)-1, length(temp))]
  first <- temp[1]
  other <- temp[-1]
  paste0(first, paste0(toupper(substring(other, 1, 1)), substring(other, 2), collapse = ""), collapse = "")
}) %>% unlist()

# 3. data processing ----
#
## _INSERT ----

message(" --> saving with new name")
for(i in 24:71){

  message(" --> '", newName[i], "' ...")
  temp <- wrap(rast(inFiles[i]))

  writeRaster(x = rast(temp),
              filename = paste0(dir_data, "processed/CHELSA_bio/CHELSA_bio-", newName[i], "_20100000_1km.tif"),
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
