# script description ----
#
# This script manages aggregation and other prepocessing, to make the CNKI data
# dump accessible.
cnkiPath <- paste0(dir_census_wip, "tables/stage1/cnki/")


# merge gaohr geoms ----
#
unzip(zipfile = paste0(dir_census_wip, "geometries/stage1/cities_china.zip"),
      exdir = paste0(dir_census_wip, "geometries/stage1/"))
city <- st_read(dsn = paste0(dir_census_wip, "geometries/stage1/City/CN_city.shp"))
st_write(obj = city, dsn = paste0(dir_census_wip, "/geometries/stage2/China_al2__cnki.gpkg"))
unlink(paste0(dir_census_wip, "geometries/stage1/City/"), recursive = TRUE)

unzip(zipfile = paste0(dir_census_wip, "geometries/stage1/counties_china.zip"),
      exdir = paste0(dir_census_wip, "geometries/stage1/County/"))
# unrar by hand
countyFiles <- list.files(path = paste0(dir_census_wip, "geometries/stage1/County"), full.names = TRUE)
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
st_write(obj = count, dsn = paste0(dir_census_wip, "/geometries/stage2/China_al3__cnki.gpkg"))
unlink(paste0(dir_census_wip, "geometries/stage1/County/"), recursive = TRUE)


unzip(zipfile = paste0(dir_census_wip, "geometries/stage1/provinces_china.zip"),
      exdir = paste0(dir_census_wip, "geometries/stage1/Province/"))
# unrar by hand
provFiles <- list.files(path = paste0(dir_census_wip, "geometries/stage1/Province"), full.names = TRUE)
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
st_write(obj = prov, dsn = paste0(dir_census_wip, "/geometries/stage2/China_al1__cnki.gpkg"))
unlink(paste0(dir_census_wip, "geometries/stage1/Province/"), recursive = TRUE)



# enhance metadata ----
# (this is based on a table produced by Leandro Parente et al. at OpenGeohub-Foundation)
#
territories_words <- "counties|xingtuan|yuan|yunnan|territory|city|cities|count|region|household|hubei|jinlin|jilin|ningxia|prefecture|prefectures|province|provinces|province's|province’s|provincial|qinchuan|shaanxi’s"
period_words <- "april|august|autumn|calendar|july|june|march|november|october|september|january|february|may|december|summer"
livestock_words <- "livestock|animal|husbandry|silkworm|slaughter|beef|cattle|beekeeping|bees|goat|hogs|holding|insect|mutton|pig|pigs|poultry|rabbit|rabbits|sheep"
fishery_words <- "fishery|aquatic|aquaculture|fish|fisheries|shrimp"
crops_words <- "watermelon|watermelons|wolfberry|tobacco|tea|sugar|sorghum|spice|sisal|rapeseed|reeds|repeseeds|rice|root|roots|rubber|paddy|palm|peanut|pepper|orange|oilseeds|nut|nuts|melon|mulberry|melons|lychee|mango|hemp|jute|kenaf|kiwi|fruit|fruits|fungi|fungus|gourd|grain|grains|ginseng|wheat|apple|areca|banana|barley|beet|cane|cashew|citrus|cocoa|coconut|coffee|coffeecoffee|corn|cotton"
landuse_words <- "tree|usage|cultivation|culture|farmland|field|fields|arable|agriculture|agicultaure|agricultural|agriculturl|agricutural|horticultural|crop|cultivated|garden|gardens|grass|grassland|orchard|orchards|pastoral|pasture|plantation|plantations|silviculture|forest"
variable_words <- "ton|tons|surface|yield|production|area|harvested|harvesting|harvest|sown|head|hectare|hectares|acres|kilograms|leaves|sale|sales|planted|planting|stock|stocking|stocks"
output_words <- "milk|meat|egg|eggs|food|edible|wool|cocoon|fibre|output|biogas|honey|pork|produced|producing|product|products|silk"
input_words <- "pesticide|fertiliz|irrigat|seed|seeds|seedling|seedlings|seeding"
tech_words <- "tractor|tractors|tillage|modernization|modernizing|electricity|electric|electrical|electrification|electromechanical|power|energy|capita|machine|labor|labour|employees|mechanical|mechanically|mechanization|mechanized"

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

tokens <- meta %>%
  select(id, text = table_name_ch2en) %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words_new) %>%
  anti_join(tibble(word = as.character(1:10000))) %>%
  mutate(territories = if_else(str_detect(word, pattern = str_replace_all(territories_words, pattern = "\\|", replacement = "$|^")), word, NA_character_),
         period = if_else(str_detect(word, pattern = str_replace_all(period_words, pattern = "\\|", replacement = "$|^")), word, NA_character_),
         livestock = if_else(str_detect(word, pattern = str_replace_all(livestock_words, pattern = "\\|", replacement = "$|^")), word, NA_character_),
         fishery = if_else(str_detect(word, pattern = str_replace_all(fishery_words, pattern = "\\|", replacement = "$|^")), word, NA_character_),
         crops = if_else(str_detect(word, pattern = str_replace_all(crops_words, pattern = "\\|", replacement = "$|^")), word, NA_character_),
         landuse = if_else(str_detect(word, pattern = str_replace_all(landuse_words, pattern = "\\|", replacement = "$|^")), word, NA_character_),
         variable = if_else(str_detect(word, pattern = str_replace_all(variable_words, pattern = "\\|", replacement = "$|^")), word, NA_character_),
         output = if_else(str_detect(word, pattern = str_replace_all(output_words, pattern = "\\|", replacement = "$|^")), word, NA_character_),
         input = if_else(str_detect(word, pattern = str_replace_all(input_words, pattern = "\\|", replacement = "$|^")), word, NA_character_),
         tech = if_else(str_detect(word, pattern = str_replace_all(tech_words, pattern = "\\|", replacement = "$|^")), word, NA_character_),
         rest = if_else(is.na(territories) & is.na(period) & is.na(livestock) & is.na(fishery) & is.na(crops) & is.na(landuse) & is.na(variable) & is.na(output) & is.na(input) & is.na(tech) & !word %in% c(".", ",", ""), word, NA_character_)) |>
  group_by(id) %>%
  summarise(territories = paste0(sort(unique(na.omit(gsub('[[:digit:]]+', '', territories)))), collapse = " | "),
            period = paste0(sort(unique(na.omit(gsub('[[:digit:]]+', '', period)))), collapse = " | "),
            livestock = paste0(sort(unique(na.omit(gsub('[[:digit:]]+', '', livestock)))), collapse = " | "),
            fishery = paste0(sort(unique(na.omit(gsub('[[:digit:]]+', '', fishery)))), collapse = " | "),
            crops = paste0(sort(unique(na.omit(gsub('[[:digit:]]+', '', crops)))), collapse = " | "),
            landuse = paste0(sort(unique(na.omit(gsub('[[:digit:]]+', '', landuse)))), collapse = " | "),
            variable = paste0(sort(unique(na.omit(gsub('[[:digit:]]+', '', variable)))), collapse = " | "),
            output = paste0(sort(unique(na.omit(gsub('[[:digit:]]+', '', output)))), collapse = " | "),
            input = paste0(sort(unique(na.omit(gsub('[[:digit:]]+', '', input)))), collapse = " | "),
            tech = paste0(sort(unique(na.omit(gsub('[[:digit:]]+', '', tech)))), collapse = " | "),
            rest = paste0(sort(unique(na.omit(gsub('[[:digit:]]+', '', rest)))), collapse = " | ")) %>%
  mutate(across(where(is.character), ~na_if(., "")))

search <- tokens |>
  select(rest) |>
  separate_longer_delim(rest, " | ") |>
  filter(!rest %in% c("", ".", ",")) |>
  distinct(rest) |>
  arrange(rest)

metaOut <- meta |>
  left_join(tokens) |>
  select(-table_name_en, -table_name_ch, -sheet_name, -filename, -table)

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
  group_by(filename) %>%
  mutate(sheets = n(),
         eng = str_detect(sheet_name, "E"),
         eng = if_else(any(eng), TRUE, FALSE)) %>%
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


write_csv(proc, file = paste0(cnkiPath, "metadata_keywords.csv"), na = "")
