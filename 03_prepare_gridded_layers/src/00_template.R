# script arguments ----
#
thisDataset <- ""
description <- ""
url <- ""
license <- ""
message("\n---- ", thisDataset, " ----")


# load metadata ----
#


# reference ----
#
bib <- ris_reader(paste0(thisPath, "")) # or bibtex_reader()

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy(),
           type = ,
           licence = license,
           contact = ,
           disclosed = ,
           bibliography = bib,
           path = grid_dir)


# pre-process data ----
#


# read dataset ----
#


# data processing ----
#


message(" --> subset ...")
for(i in seq_along(profile$year)){

  theLayer <- paste0(outPath, "", profile$year[i], ".tif")
  theTiles <- paste0()
  assertFileExists(x = theFile, access = "r")

  crop(x = theLayer, y = theTiles,
       filename = paste0(outPath, "", year, "", profile$name, "_", profile$version, ".tif"),
       overwrite = TRUE,
       filetype = "GTiff",
       datatype = "FLT4S",
       gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

}


# write output ----
#

# beep(sound = 10)
message("\n     ... done")
