# script description ----
#
# This script manages aggregation and other prepocessing, to make the CNKI data
# dump accessible.
cnkiPath <- paste0(census_dir, "tables/stage1/cnki/")


# merge gaohr geoms ----
#
unzip(zipfile = paste0(census_dir, "geometries/stage1/cities_china.zip"),
      exdir = paste0(census_dir, "geometries/stage1/"))
city <- st_read(dsn = paste0(census_dir, "geometries/stage1/City/CN_city.shp"))
st_write(obj = city, dsn = paste0(census_dir, "/geometries/stage2/China_al2__cnki.gpkg"))
unlink(paste0(census_dir, "geometries/stage1/City/"), recursive = TRUE)

unzip(zipfile = paste0(census_dir, "geometries/stage1/counties_china.zip"),
      exdir = paste0(census_dir, "geometries/stage1/County/"))
# unrar by hand
countyFiles <- list.files(path = paste0(census_dir, "geometries/stage1/County"), full.names = TRUE)
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
st_write(obj = count, dsn = paste0(census_dir, "/geometries/stage2/China_al3__cnki.gpkg"))
unlink(paste0(census_dir, "geometries/stage1/County/"), recursive = TRUE)


unzip(zipfile = paste0(census_dir, "geometries/stage1/provinces_china.zip"),
      exdir = paste0(census_dir, "geometries/stage1/Province/"))
# unrar by hand
provFiles <- list.files(path = paste0(census_dir, "geometries/stage1/Province"), full.names = TRUE)
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
st_write(obj = prov, dsn = paste0(census_dir, "/geometries/stage2/China_al1__cnki.gpkg"))
unlink(paste0(census_dir, "geometries/stage1/Province/"), recursive = TRUE)



# pre-process cnki tabular data ----
#
# the 'per_nation' folder for china contains a file called '20200410
# CSYD_excel_24,630.rar' with all the CNKI data. The following section of this
# script depends on the contents of this file to be extracted and placed in
# 'paste0(cnkiPath, raw)'. By running the following for loop:
# - each file will be scrutinized, partly translated and stored in a new
#   directory according to the english name of the province.
# - metadata are documented
# - ...

dir.create(path = paste0(cnkiPath, "preprocessed/"))
dir.create(path = paste0(cnkiPath, "preprocessed/failed"))
raw <- "20200410 CSYD_excel_24,630/新建文件夹/"

provinces <- list.dirs(path = paste0(cnkiPath, raw), full.names = FALSE, recursive = FALSE)
names <- read_csv(file = paste0(cnkiPath, "names.csv"))

# these are metadata from OGH (Leadro Parente)
meta <- read_xlsx(path = paste0(cnkiPath, "metadata.xlsx")) %>%
  separate(col = filename, into = "filename", sep = "[.]", extra = "drop") %>%
  group_by(filename, table_name_ch) %>%
  mutate(rows = n(),
         eng = str_detect(sheet_name, "E"),
         filt = if_else(any(eng), TRUE, FALSE)) %>%
  # filter(!rows %in% c(1, 2))
  # filter(rows == 1 | (eng & filt))
  select(-sheet_name, -city, -id)


for(i in seq_along(provinces)){
  targetDir <- names$en[which(names$cn == provinces[i])]

  message("  --> reorganising '", targetDir, "'")

  # create directory, in case it doesn't exist yet
  if(!testDirectoryExists(x = paste0(cnkiPath, "preprocessed/", targetDir))){
    dir.create(path = paste0(cnkiPath, "preprocessed/", targetDir))
  }
  out <- tibble()

  years <- list.files(path = paste0(cnkiPath, raw, provinces[i]))
  for(j in seq_along(years)){

    message("    - ", years[j])

    varPath <- paste0(cnkiPath, raw, provinces[i], "/", years[j])
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

    # iterate through tables to ... ----
    for(k in seq_along(variables)){

      thisFile <- paste0(varPath, "/", variables[k])
      newName <- str_split(variables[k], "[.]")[[1]]
      newName <- paste0(targetDir, "_", years[j], "_", newName[1], ".", newName[2])

      # first test, whether the file is finished already
      if(testFileExists(x = paste0(cnkiPath, "preprocessed/", targetDir, "/", str_split(newName, "[.]")[[1]][1], ".rds"))){
        next
      }

      # ... load sheets, if possible
      it <- 1
      temp <- NULL
      while(is(try(read.xlsx2(file = thisFile, sheetIndex = it, header = FALSE, stringsAsFactors = FALSE)))[1] != "try-error"){
        sheet <- read.xlsx2(file = thisFile, sheetIndex = it, header = FALSE, stringsAsFactors = FALSE)
        temp <- c(temp, list(sheet))
        it <- it+1
      }

      ignore <- NULL
      for(l in seq_along(temp)){
        thisTable <- temp[[l]]

        # handle some exceptions
        if(is.null(thisTable)){
          ignore <- c(ignore, l)
          next
        }

        if(thisTable[1, 1] == "http://www.cnki.net/"){
          ignore <- c(ignore, l)
          next
        }
      }

      if(length(ignore) != 0){
        if(all(ignore == seq_along(temp))){
          file.copy(from = thisFile, to = paste0(cnkiPath, "preprocessed/failed/", newName))
          next
        } else {
          temp <- temp[-ignore]
        }
      }

      tempOut <- tibble()
      for(l in seq_along(temp)){
        thisTable <- temp[[l]]

        ## 1. isolate meta-data
        inCells <- thisTable %>%
          mutate(across(everything(), ~if_else(.x != "", TRUE, FALSE)))
        which0 <- which(rowSums(inCells) %in% 0 & rowSums(inCells) != dim(inCells)[2])
        which1 <- which(rowSums(inCells) %in% 1 & rowSums(inCells) != dim(inCells)[2])
        if(length(which1) != 0){
          theHeader <- unlist(thisTable[which1,])
          theHeader <- paste0(trimws(theHeader[which(theHeader != "")]), collapse = " | ")
          theName <- thisTable[1, 1]
        } else {
          theHeader <- ""
          theName <- ""
        }
        if(length(which0) != 0){
          thisTable <- thisTable %>% slice(-which0)
        }

        # identify distinct parts (separated by empty columns and rows)
        # x <- which(rowSums(inCells) %in% 0)
        # y <- which(colSums(inCells) %in% 0)

        # write metadata
        tempOut <- tibble(filename = str_split(variables[k], "[.]")[[1]][1],
                          province = targetDir,
                          year = years[j],
                          sheet = l,
                          sheet_meta = theHeader,
                          table_name_ch = theName,
                          cols = dim(thisTable)[2],
                          rows = dim(thisTable)[1]) %>%
          left_join(meta, by = c("filename", "table_name_ch")) %>%
          distinct() %>%
          filter(!is.na(table_name_en))

        assertDataFrame(x = tempOut, max.rows = 1)
        out <- bind_rows(out, tempOut)

        ## 2. identify contents



        saveRDS(object = thisTable, file = paste0(cnkiPath, "preprocessed/", targetDir, "/", str_split(newName, "[.]")[[1]][1], "_sheet", l, ".rds"))

      }

      out <- out %>%
        group_by(filename) %>%
        mutate(sheets = n()) %>%
        ungroup() %>%
        select(filename, province, year, sheet, sheets, everything())

      saveRDS(object = out, file = paste0(cnkiPath, "preprocessed/", targetDir, "_overview.rds"))

    }

  }

  # beep(2)

}

# beep(10)

# continue selecting variables ----
# (this is based on a table produced by Leandro Parente et al. at OpenGeohub-Foundation)
#
# instructions:
# - remove = per capita, machine, modern*, aquatic, labor, labour, slaughter*
# - territories = cit*, count*, region*, household*
# - domain = livestock*, animal*, forest*, agriculture, crop*, fisher*
# - variable = yield, production, area
# - output = milk, meat, eggs, wool, fibre
# - input = pesticide, fertiliz*, irrigat*
# - keywords = water, land*, cultivated, farm*, value, output
# - other = if "continued", take previous information)

stop_words_new <- stop_words %>%
  filter(!str_detect(word, "area+"))

meta <- read_xlsx(path = paste0(cnkiPath, "metadata.xlsx")) %>%
  mutate(id = id + 1) %>%
  mutate(table = str_extract(string = table_name_ch2en, pattern = "[:digit:]{1,2}[:punct:]{1}[:digit:]{1,2}")) %>%
  mutate(table = str_replace_all(string = table, pattern = "[:punct:]", replacement = "-")) %>%
  mutate(year = str_extract(string = table_name_ch2en, pattern = "[:digit:]{4}[:punct:]{1}[:digit:]{4}|[:digit:]{4}")) %>%
  mutate(year = str_replace_all(string = year, pattern = "[:punct:]", replacement = "-")) %>%
  separate(col = year, into = c("start", "end"), sep = "-") %>%
  mutate(end = if_else(!is.na(start) & is.na(end), as.numeric(start), as.numeric(end)),
         start = as.numeric(start),
         duration = end - start + 1)

proc <- meta %>%
  select(id, text = table_name_ch2en) %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words_new) %>%
  anti_join(tibble(word = as.character(1:10000))) %>%
  mutate(territories = str_detect(word, pattern = "city|cities|count|region|household"),
         territories_not = str_detect(word, pattern = "electricity|^count$|account|headcount|capacity|countryside")) %>%
  mutate(domain = str_detect(word, pattern = "livestock|animal|forest|agricultur|crop|fisher|cultivated")) %>%
  mutate(variable = str_detect(word, pattern = "yield|production|area|head"),
         variable_not = str_detect(word, pattern = "hectare|welfare|share|health|wheat|southeast|hectares|compared")) %>%
  mutate(output = str_detect(word, pattern = "milk|meat|egg|eggs|wool|fibre|output")) %>%
  mutate(input = str_detect(word, pattern = "pesticide|fertiliz|irrigat")) %>%
  mutate(ignore = str_detect(word, pattern = "electricity|capita|machine|modern|aquatic|labor|labour|slaughter|employees|owned")) %>%
  mutate(rest = if_else(territories & !territories_not | domain | variable & !variable_not | output | input | ignore, NA_character_, word)) %>%
  mutate(territories = if_else(territories & !territories_not, word, NA_character_),
         domain = if_else(domain, word, NA_character_),
         variable = if_else(variable & !variable_not, word, NA_character_),
         output = if_else(output, word, NA_character_),
         input = if_else(input, word, NA_character_),
         ignore = if_else(ignore, word, NA_character_)) %>%
  group_by(id) %>%
  summarise(territories = paste0(sort(unique(na.omit(territories))), collapse = " | "),
            domain = paste0(sort(unique(na.omit(gsub('[[:digit:]]+', '', domain)))), collapse = " | "),
            variable = paste0(sort(unique(na.omit(gsub('[[:digit:]]+', '', variable)))), collapse = " | "),
            output = paste0(sort(unique(na.omit(gsub('[[:digit:]]+', '', output)))), collapse = " | "),
            input = paste0(sort(unique(na.omit(input))), collapse = " | "),
            ignore = paste0(sort(unique(na.omit(gsub('[[:digit:]]+', '', ignore)))), collapse = " | "),
            rest = paste0(sort(unique(na.omit(rest))), collapse = " | ")) %>%
  mutate(across(where(is.character), ~na_if(., ""))) %>%
  left_join(meta, ., by = "id")

write_csv(proc, file = paste0(cnkiPath, "metadata_keywords.csv"), na = "")
