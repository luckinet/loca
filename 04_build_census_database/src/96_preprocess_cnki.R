# script description ----
#
# This script manages aggregation and other prepocessing, to make the CNKI data
# dump accessible.


# merge gaohr geoms ----
#
unzip(paste0(census_dir, "adb_geometries/stage1/cities_china.zip"), exdir = paste0(census_dir, "adb_geometries/stage1/"))
city <- st_read(dsn = paste0(census_dir, "adb_geometries/stage1/City/CN_city.shp"))
st_write(obj = city, dsn = paste0(census_dir, "/adb_geometries/stage2/China_al2__cnki.gpkg"))
unlink(paste0(census_dir, "adb_geometries/stage1/City/"), recursive = TRUE)

unzip(paste0(census_dir, "adb_geometries/stage1/counties_china.zip"), exdir = paste0(census_dir, "adb_geometries/stage1/County/"))
# unrar by hand
countyFiles <- list.files(path = paste0(census_dir, "adb_geometries/stage1/County"), full.names = TRUE)
count <- NULL

for(i in seq_along(countyFiles)){

  tempName <- str_split(tail(str_split(countyFiles[i], "/")[[1]], 1), "-")[[1]][1]

  tempObj <- st_read(dsn = list.files(path = countyFiles[i], pattern = "shp$", recursive = TRUE, full.names = TRUE)) %>%
    select(-c("AREA", "PERIMETER")) %>%
    group_by(ADCODE99, NAME99) %>%
    summarise() %>%
    mutate(province = tempName)
  temp <- st_cast(tempObj, "MULTIPOLYGON")
  count <- bind_rows(count, temp)
}
st_write(obj = count, dsn = paste0(census_dir, "/adb_geometries/stage2/China_al3__cnki.gpkg"))
unlink(paste0(census_dir, "adb_geometries/stage1/County/"), recursive = TRUE)


unzip(paste0(census_dir, "adb_geometries/stage1/provinces_china.zip"), exdir = paste0(census_dir, "adb_geometries/stage1/Province/"))
# unrar by hand
provFiles <- list.files(path = paste0(census_dir, "adb_geometries/stage1/Province"), full.names = TRUE)
prov <- NULL
for(i in seq_along(provFiles)){

  tempName <- str_split(tail(str_split(provFiles[i], "/")[[1]], 1), "-")[[1]][1]

  tempObj <- st_read(dsn = list.files(path = provFiles[i], pattern = "shp$", recursive = TRUE, full.names = TRUE)) %>%
    select(-c("AREA", "PERIMETER")) %>%
    group_by(SHENG_ID, SHENG) %>%
    summarise() %>%
    mutate(province = tempName)
  temp <- st_cast(tempObj, "MULTIPOLYGON")
  prov <- bind_rows(prov, temp)
}
st_write(obj = prov, dsn = paste0(census_dir, "/adb_geometries/stage2/China_al1__cnki.gpkg"))
unlink(paste0(census_dir, "adb_geometries/stage1/Province/"), recursive = TRUE)



# pre-process cnki data ----
#
# the 'per_nation' folder for china contains a file called '20200410
# CSYD_excel_24,630.rar' with all the CNKI data. The following section of this
# script depends on the contents of this file to be extracted and placed in
# 'cnkiPath.' By running the following for loop, each file will be scrutinized,
# partly translated and stored in a new directory according to the english name
# of the province. The old file will be deleted, in case transformation was
# successful.

cnkiPath <- paste0(census_dir, "adb_tables/stage1/cnki/")
provinces <- list.dirs(path = cnkiPath, full.names = FALSE, recursive = FALSE)

names <- read_csv(file = paste0(cnkiPath, "names.csv"))

failures <- NULL
out <- tibble(province = character(), year = character(), table = character())
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

      out <- bind_rows(out, tibble(province = targetDir, year = years[j], table = theName, file_name = variables[k]))

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

write_csv(x = out, file = paste0(cnkiPath, "overview_tables_china.csv"))
beep(10)
