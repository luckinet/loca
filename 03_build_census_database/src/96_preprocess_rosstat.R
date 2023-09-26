# script arguments ----
#


# set paths ----
#
incomingDir <- paste0(DBDir, "incoming/per_nation/Russia/rosstat/")


# load metadata ----
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
  newName <- paste0("rosstat_", tempName)

  write_delim(x = tempData, file = paste0(DBDir, "adb_tables/stage1/", newName), delim = ",", na = "", col_names = FALSE)

})

