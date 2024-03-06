# script description ----
#


# script arguments ----
#
thisDataset <- "WorldClim"
inPath <- paste0(gridDBDir, "input", thisDataset, "/")
outPath <- paste0(gridDBDir, "processed/", thisDataset, "/")
assertDirectoryExists(x = inPath)
message("\n---- ", thisDataset, " ----")

description <- ""
url <- ""    # ideally the doi, but if it doesn't have one, the main source of the database
license <- ""


# reference ----
#
bib <- ris_reader(paste0(thisPath, "")) # or bibtex_reader()

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "", # YYYY-MM-DD
           type = "", # dynamic or static
           licence = license,
           contact = "", # optional, if it's a paper that should be "see corresponding author"
           disclosed = "", # whether the data are freely available "yes"/"no"
           bibliography = bib,
           path = gridDBDir)


# pre-process data ----
#
inFiles <- list.files(path = inPath)
if(!"" %in% inFiles){
  untar(exdir = inPath,
        tarfile = paste0(inPath, ""))
}


# read dataset ----
#
allLayers <- list.files(path = inPath)


# data processing ----
#
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


outLayers <- list.files(path = outPath)

message(" --> subset ...")
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


# write output ----
#
