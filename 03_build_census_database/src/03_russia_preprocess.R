# script arguments ----
#


# set paths ----
#
incomingDir <- paste0(DBDir, "incoming/per_nation/Russia/raw/rosstat/")


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
  dont store them in stage1 after processing, but in stage2 with the proper name and utf-8 encoding
  # write_csv(x = temp, file = paste0(DBDir, "adb_tables/stage2/", "eur_", maxLvl, "_", theName, "_", rngYears[1], "_", rngYears[2], "_eurostat.csv"), na = "NA")

})

