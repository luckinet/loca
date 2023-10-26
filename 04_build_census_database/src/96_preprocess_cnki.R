# script description ----
#
# This script manages aggregation and other prepocessing, to make the CNKI data
# dump accessible.


# merge gaohr geoms ----
#
city <- st_read(dsn = paste0(dataDir, "areal_data/already_processed/per_nation/china/geom/City_Level/City/CN_city.shp"))
cityPath <- paste0(dataDir, "areal_data/already_processed/per_nation/china/geom/City_Level")

st_write(obj = city, dsn = paste0(cityPath, "/cities_china.gpkg"))

countyPath <- paste0(dataDir, "areal_data/already_processed/per_nation/china/geom/County_Level")
countyFiles <- list.files(path = countyPath, full.names = TRUE)
out <- NULL

for(i in seq_along(countyFiles)){

  tempName <- tail(str_split(countyFiles[i], "/")[[1]], 1)

  if(grepl("gpkg", tempName)){
    next
  }

  tempObj <- st_read(dsn = list.files(path = countyFiles[i], pattern = "shp$", full.names = TRUE)) %>%
    select(-c("AREA", "PERIMETER")) %>%
    group_by(ADCODE99, NAME99) %>%
    summarise() %>%
    mutate(province = tempName)
  temp <- st_cast(tempObj, "MULTIPOLYGON")
  out <- bind_rows(out, temp)
}

st_write(obj = out, dsn = paste0(countyPath, "/counties_china.gpkg"))


provincePath <- paste0(dataDir, "areal_data/already_processed/per_nation/china/geom/Province_Level")
provinceFiles <- list.files(path = provincePath, full.names = TRUE)
out <- NULL
for(i in seq_along(provinceFiles)){

  tempName <- tail(str_split(provinceFiles[i], "/")[[1]], 1)

  if(grepl("gpkg", tempName)){
    next
  }

  tempObj <- st_read(dsn = list.files(path = provinceFiles[i], pattern = "shp$", full.names = TRUE)) %>%
    select(-c("AREA", "PERIMETER")) %>%
    group_by(SHENG_ID, SHENG) %>%
    summarise() %>%
    mutate(province = tempName)
  temp <- st_cast(tempObj, "MULTIPOLYGON")
  out <- bind_rows(out, temp)
}

st_write(obj = out, dsn = paste0(provincePath, "/provinces_china.gpkg"))



# pre-process cnki data ----
#
# the 'per_nation' folder for china contains a file called '20200410
# CSYD_excel_24,630.rar' with all the CNKI data. The following section of this
# script depends on the contents of this file to be extracted and placed in
# 'cnkiPath.' By running the following for loop, each file will be scrutinized,
# partly translated and stored in a new directory according to the english name
# of the province. The old file will be deleted, in case transformation was
# successful.

# DBDir <- "/media/se87kuhe/external1/projekte/LUCKINet/01_data/areal_data/censusDB_global/"
cnkiPath <- paste0(DBDir, "adb_tables/incoming/per_nation/china/CNKI/00_raw/")
provinces <- list.dirs(path = cnkiPath, full.names = FALSE, recursive = FALSE)

names <- read_csv(file = paste0(cnkiPath, "names.csv"))

failures <- NULL
for(i in seq_along(provinces)){
  targetDir <- names$en[which(names$cn == provinces[i])]

  message("  --> reorganising '", targetDir, "'")

  # create directory, in case it doesn't exist yet
  if(!testDirectoryExists(x = paste0(cnkiPath, targetDir))){
    dir.create(path = paste0(cnkiPath, targetDir))
    dir.create(path = paste0(cnkiPath, targetDir, "/done"))
  }

  years <- list.files(path = paste0(cnkiPath, provinces[i]))
  for(j in seq_along(years)){

    message("    - ", years[j])

    varPath <- paste0(cnkiPath, provinces[i], "/", years[j])
    variables <- list.files(path = varPath)

    # find out whether the target is a directory itself
    if(length(variables) == 1){
      directory <- paste0(cnkiPath, provinces[i], "/", years[j], "/", variables)
      isDir <- testDirectory(x = directory)

      if(isDir){

        allVars <- list.files(path = directory)
        file.copy(from = list.files(path = directory, full.names = TRUE),
                  to = paste0(cnkiPath, provinces[i], "/", years[j], "/", allVars))
        file.remove(list.files(path = directory, full.names = TRUE))
        file.remove(directory)

      }
      variables <- list.files(path = varPath)

    }


    for(k in seq_along(variables)){

      failedName <- str_split(variables[k], "[.]")[[1]]
      failedName <- paste0(failedName[1], "_", years[j], ".", failedName[2])

      # load file, but if it's not possible, copy the original file instead
      temp <- tryCatch(expr = read.xlsx2(file = paste0(varPath, "/", variables[k]), sheetIndex = 1, header = FALSE, stringsAsFactors = FALSE),
                       error = function(x){
                         file.copy(from = paste0(varPath, "/", variables[k]),
                                   to = paste0(cnkiPath, targetDir, "/", failedName))
                       })

      if(is.character(temp)){
        failures <- c(failures, temp)
        next
      }

      # in case loading was not possible, the original file has been copied and we skip the following code.
      if(is.logical(temp)){
        next
      }

      theName <- NULL
      if(is.null(temp)){
        theName <- str_split(string = variables[k], pattern = "[.]")[[1]][1]
        theName <- paste0(theName, " (empty table)")
        temp <- tibble()
      } else {
        # remove empty rows
        while(sum(temp[1,] %in% "") == dim(temp)[2]){
          temp <- temp[-1,]
        }
        header <- temp[1, ]
        if(length(which(header != "")) != 0){
          theName <- header[[which(header != "")[1]]]
        }
      }
      theName <- trimws(theName)

      assertCharacter(x = theName, len = 1)

      # -> needs to check whether file already exists and assign a counting number ("..._2, ..._3")
      write_csv(x = temp,
                file = paste0(cnkiPath, targetDir, "/", theName, "_", years[j], ".csv"),
                col_names = FALSE,
                append = FALSE)

      copied <- file.copy(from = paste0(varPath, "/", variables[k]),
                          to = paste0(cnkiPath, targetDir, "/done/", variables[k]))
      if(copied){
        file.remove(paste0(varPath, "/", variables[k]))
      } else {
        stop("wasn't able to place the finished file in the respective directory.")
      }

    }

    if(length(list.files(varPath)) == 0){
      file.remove(varPath)
    }

  }

  if(length(list.files(paste0(cnkiPath, provinces[i]))) == 0){
    file.remove(paste0(cnkiPath, provinces[i]))
  }
  beep(2)

}



