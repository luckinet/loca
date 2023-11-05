# script arguments ----
#


# set paths ----
#
incomingDir <- paste0(census_dir, "adb_tables/stage1/rosstat")


# load metadata ----
#


# load data ----
#
allInput <- list.files(incomingDir, recursive = TRUE, full.names = TRUE)


# data processing ----
#
map(seq_along(allInput), function(ix){

  tempData <- read_csv(file = allInput[ix], col_names = FALSE)

  tempName <- tail(str_split(allInput[ix], "/")[[1]], 1)
  tempName <- str_split(tempName, "[.]")[[1]][1]
  newName <- str_split(tempName, "_")[[1]]
  newName <- paste0("Russia_al3_", newName[4], newName[2], "_2008_2020_rosstat")

  write_delim(x = tempData, file = paste0(census_dir, "adb_tables/stage2/", newName, ".csv"), delim = ",", na = "", col_names = FALSE)

})

