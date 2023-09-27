# script arguments ----
#


# set paths ----
#
incomingDir <- paste0(censusDBDir, "adb_tables/stage1/rosstat")


# load metadata ----
#
# federal district names: https://en.wikipedia.org/wiki/Federal_districts_of_Russia
#

# load data ----
#
allInput <- list.files(incomingDir, recursive = TRUE, full.names = TRUE)


# data processing ----
#
map(seq_along(allInput), function(ix){

  tempData <- read_csv2(file = allInput[ix], locale = locale(encoding = "PT154"),
                        skip_empty_rows = FALSE, col_names = FALSE)
  cols <- length(str_split(tempData[3,], ";")[[1]])
  tempData$X1 <- str_replace_all(tempData$X1, ",", ".")
  tempData <- tempData %>%
    separate(col = 1, sep = ";", into = paste0("X", 1:cols), remove = FALSE)

  tempName <- tail(str_split(allInput[ix], "/")[[1]], 1)
  tempName <- str_split(tempName, "[.]")[[1]][1]
  newName <- str_split(tempName, "_")[[1]]
  newName <- paste0("Russia_al3_", newName[4], newName[3], "_2008_2020_rosstat")

  write_delim(x = tempData, file = paste0(censusDBDir, "adb_tables/stage2/", newName), delim = ",", na = "", col_names = FALSE)

})

