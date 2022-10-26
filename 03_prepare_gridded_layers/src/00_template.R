# script description ----
#


# script arguments ----
#
thisDataset <- ""
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
