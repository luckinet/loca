# script description ----
#


# script arguments ----
#
thisDataset <- ""
inPath <- paste0(gridDBDir, "input", thisDataset, "/")
outPath <- paste0(gridDBDir, "processed/", thisDataset, "/")
assertDirectoryExists(x = inPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "")) # or bibtex_reader()

# column         type            description
# name
# description    [character]   description of the data-set
# url            [character]   ideally the doi, but if it doesn't have one, the
#                              main source of the database
# donwload_date  [POSIXct]     the date (DD-MM-YYYY) on which the data-set was
#                              downloaded
# type           [character]   "dynamic" (when the data-set updates regularly)
#                              or "static"
# license        [character]   abbreviation of the license under which the
#                              data-set is published
# contact        [character]   if it's a paper that should be "see corresponding
#                              author", otherwise some listed contact
# disclosed      [logical]
# bibliography   [handl]       bibliography object from the 'handlr' package
# path           [character]   the path to the occurrenceDB

description <- ""
url <- ""
license <- ""

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy(),
           type = ,
           licence = license,
           contact = ,
           disclosed = ,
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
