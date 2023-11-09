abs_path <- paste0(census_dir, "adb_tables/stage1/abs/")

# merge spreadsheets into a single table
#
# historic data ----
theFile <- paste0(abs_path, "/7124 data cube.xls")
sheets <- excel_sheets(path = theFile)
crops_historic <- map(.x = 2:6, .f = function(ix){
  temp <- read_excel(path = theFile, sheet = ix, skip = 4)

  cutRow <- str_which(string = temp[,1, drop = TRUE], pattern = "Source") - 2

  colnames(temp)[1:2] <- c("territory", "unit")

  temp <- temp %>%
    slice(1:cutRow) %>%
    fill(territory, .direction = "down") %>%
    add_column(item = sheets[ix], .before = "territory")

}) %>%
  bind_rows()

write_csv(x = crops_historic, file = paste0(census_dir, "adb_tables/stage2/Australia_historicCrops_1861_2011_abs.csv"))

livestock_historic <- map(.x = 7:12, .f = function(ix){
  temp <- read_excel(path = theFile, sheet = ix, skip = 4)

  cutRow <- str_which(string = temp[,1, drop = TRUE], pattern = "Source") - 2

  colnames(temp)[1:2] <- c("territory", "unit")
  colnames(temp)[3:dim(temp)[2]] <- gsub(x = colnames(temp)[3:dim(temp)[2]], pattern = "\\D", replacement = "")

  temp <- temp %>%
    slice(1:cutRow) %>%
    fill(territory, .direction = "down") %>%
    mutate(unit = if_else(is.na(unit), if_else(sheets[ix] != "Wool", "number", "1000 kg"), unit)) %>%
    add_column(item = sheets[ix], .before = "territory")

}) %>%
  bind_rows()

write_csv(x = livestock_historic, file = paste0(census_dir, "adb_tables/stage2/Australia_historicLivestock_1860_2011_abs.csv"))


# 2011/2012 ----
7121_sa4.xls

# merge several files into a single table
#
# 2000/2001
theFiles <- list.files(path = abs_path, pattern = "71250do\\d{3}_200001.zip")

all2001 <- map(.x = seq_along(theFiles), .f = function(ix){

  unzip(zipfile = paste0(abs_path, theFiles[ix]), exdir = paste0(abs_path, "temp"))

  theFile <- list.files(path = paste0(abs_path, "temp"))
  sheets <- excel_sheets(path = paste0(abs_path, "temp/", theFile))

  theRegion <- str_split(read_excel(path = paste0(abs_path, "temp/", theFile), sheet = 1)[7, 3, drop = TRUE], pattern = " [:punct:] ")[[1]][1]

  regional <- map(.x = 2:length(sheets), .f = function(iy){
    temp <- read_excel(path = paste0(abs_path, "temp/", theFile), sheet = iy, skip = 4, col_names = FALSE)
    dims <- dim(temp)

    cutRow <- str_which(string = temp[,1, drop = TRUE], pattern = "Commonwealth") - 3

    temp <- temp %>%
      slice(1:cutRow) %>%
      rownames_to_column('rn') %>%
      pivot_longer(cols = !rn)

    rep1 <- temp[1:dims[2], ] %>%
      fill(value, .direction = "down")
    rep2 <- temp[(dims[2]+1):dim(temp)[1], ]
    temp <- bind_rows(rep1, rep2) %>%
      pivot_wider(names_from = name, values_from = value) %>%
      select(-rn)

    fullNames <- temp %>%
      slice(1:2) %>%
      summarise(across(everything(), \(x) paste0(x, collapse = " - ")))
    fullNames[1] <- "variable"

    temp <- temp %>%
      slice(-(1:2))
    colnames(temp) <- fullNames
    return(temp)
  }) %>%
    bind_rows() %>%
    pivot_longer(cols = !variable) %>%
    separate(col = name, into = c("al3", "dimension"), sep = " - ") %>%
    filter(dimension == "Estimate") %>%
    select(-dimension) %>%
    add_column(al2 = theRegion, .before = "al3")

  unlink(x = paste0(abs_path, "temp"), recursive = TRUE)
  return(regional)
}) %>%
  bind_rows()

crops2001 <- all2001 %>%
  filter(str_detect(variable, regex("sheep|cattle|buffalo|pig|poultry|chicken|duck|turkey|livestock|deer|horse|eggs$|layer|sows|wool|lamb", ignore_case = TRUE), negate = TRUE))
livestock2001 <- all2001 %>%
  filter(str_detect(variable, regex("sheep|cattle|buffalo|pig|poultry|chicken|duck|turkey|livestock|deer|horse|eggs$|layer|sows|wool|lamb", ignore_case = TRUE)))

write_csv(x = crops2001, file = paste0(census_dir, "adb_tables/stage2/Australia_cropsDetailed_2000_2001_abs.csv"))
write_csv(x = livestock2001, file = paste0(census_dir, "adb_tables/stage2/Australia_livestockDetailed_2000_2001_abs.csv"))

# 2005/2006
theFiles <- list.files(path = abs_path, pattern = "71250[a-zA-Z]{2}\\d{3}_200506.xls")

all2006 <- map(.x = seq_along(theFiles), .f = function(ix){

  sheets <- excel_sheets(path = paste0(abs_path, theFiles[ix]))

  theRegion <- str_split(read_excel(path = paste0(abs_path, theFiles[ix]), sheet = 1)[6, 3, drop = TRUE], pattern = " [:punct:] ")[[1]][1]

  regional <- map(.x = 2:length(sheets), .f = function(iy){
    temp <- read_excel(path = paste0(abs_path, theFiles[ix]), sheet = iy, skip = 4, col_names = FALSE)
    dims <- dim(temp)

    cutRow <- str_which(string = temp[,1, drop = TRUE], pattern = "Commonwealth") - 3

    temp <- temp %>%
      slice(1:cutRow) %>%
      rownames_to_column('rn') %>%
      pivot_longer(cols = !rn)

    rep1 <- temp[1:dims[2], ] %>%
      fill(value, .direction = "down")
    rep2 <- temp[(dims[2]+1):dim(temp)[1], ]
    temp <- bind_rows(rep1, rep2) %>%
      pivot_wider(names_from = name, values_from = value) %>%
      select(-rn)

    fullNames <- temp %>%
      slice(1:2) %>%
      summarise(across(everything(), \(x) paste0(x, collapse = " - ")))
    fullNames[1] <- "variable"

    temp <- temp %>%
      slice(-(1:2))
    colnames(temp) <- fullNames
    return(temp)
  }) %>%
    bind_rows() %>%
    pivot_longer(cols = !variable) %>%
    separate(col = name, into = c("al3", "dimension"), sep = " - ") %>%
    filter(dimension == "Estimate") %>%
    select(-dimension) %>%
    add_column(al2 = theRegion, .before = "al3")

  return(regional)
}) %>%
  bind_rows()

crops2006 <- all2006 %>%
  filter(str_detect(variable, regex("sheep|cattle|buffalo|pig|poultry|chicken|duck|turkey|livestock|deer|horse|eggs$|layer|sows|wool|lamb|heifer", ignore_case = TRUE), negate = TRUE))
livestock2006 <- all2006 %>%
  filter(str_detect(variable, regex("sheep|cattle|buffalo|pig|poultry|chicken|duck|turkey|livestock|deer|horse|eggs$|layer|sows|wool|lamb|heifer", ignore_case = TRUE)))

write_csv(x = crops2006, file = paste0(census_dir, "adb_tables/stage2/Australia_cropsDetailed_2005_2006_abs.csv"))
write_csv(x = livestock2006, file = paste0(census_dir, "adb_tables/stage2/Australia_livestockDetailed_2005_2006_abs.csv"))

# 2006/2007
theFiles <- list.files(path = abs_path, pattern = "71250[a-zA-Z]{2}\\d{3}_200607.xls")

all2007 <- map(.x = seq_along(theFiles), .f = function(ix){

  sheets <- excel_sheets(path = paste0(abs_path, theFiles[ix]))

  theRegion <- str_split(read_excel(path = paste0(abs_path, theFiles[ix]), sheet = 1)[6, 3, drop = TRUE], pattern = " [:punct:] ")[[1]][1]

  regional <- map(.x = 2:length(sheets), .f = function(iy){
    temp <- read_excel(path = paste0(abs_path, theFiles[ix]), sheet = iy, skip = 4, col_names = FALSE)
    dims <- dim(temp)

    cutRow <- str_which(string = temp[,1, drop = TRUE], pattern = "Commonwealth") - 3

    temp <- temp %>%
      slice(1:cutRow) %>%
      rownames_to_column('rn') %>%
      pivot_longer(cols = !rn)

    rep1 <- temp[1:dims[2], ] %>%
      fill(value, .direction = "down")
    rep2 <- temp[(dims[2]+1):dim(temp)[1], ]
    temp <- bind_rows(rep1, rep2) %>%
      pivot_wider(names_from = name, values_from = value) %>%
      select(-rn)

    fullNames <- temp %>%
      slice(1:2) %>%
      summarise(across(everything(), \(x) paste0(x, collapse = " - ")))
    fullNames[1] <- "variable"

    temp <- temp %>%
      slice(-(1:2))
    colnames(temp) <- fullNames
    return(temp)
  }) %>%
    bind_rows() %>%
    pivot_longer(cols = !variable) %>%
    separate(col = name, into = c("al3", "dimension"), sep = " - ") %>%
    filter(dimension == "Estimate") %>%
    select(-dimension) %>%
    add_column(al2 = theRegion, .before = "al3")

  return(regional)
}) %>%
  bind_rows()

crops2007 <- all2007 %>%
  filter(str_detect(variable, regex("Livestock", ignore_case = TRUE), negate = TRUE))
livestock2007 <- all2007 %>%
  filter(str_detect(variable, regex("Livestock", ignore_case = TRUE)))

write_csv(x = crops2007, file = paste0(census_dir, "adb_tables/stage2/Australia_cropsDetailed_2006_2007_abs.csv"))
write_csv(x = livestock2007, file = paste0(census_dir, "adb_tables/stage2/Australia_livestockDetailed_2006_2007_abs.csv"))

# 2010/2011
theFiles <- list.files(path = abs_path, pattern = "71210do\\d{3}_201011.xls")

all2011 <- map(.x = seq_along(theFiles), .f = function(ix){


}) %>%
  bind_rows()

# crops2011 <- all2011 %>%
#   filter(str_detect(variable, regex("sheep|cattle|buffalo|pig|poultry|chicken|duck|turkey|livestock|deer|horse|eggs$|layer|sows|wool|lamb|heifer", ignore_case = TRUE), negate = TRUE))
# livestock2011 <- all2011 %>%
#   filter(str_detect(variable, regex("sheep|cattle|buffalo|pig|poultry|chicken|duck|turkey|livestock|deer|horse|eggs$|layer|sows|wool|lamb|heifer", ignore_case = TRUE)))
#
# write_csv(x = crops2011, file = paste0(census_dir, "adb_tables/stage2/Australia_cropsDetailed_2010_2011_abs.csv"))
# write_csv(x = livestock2011, file = paste0(census_dir, "adb_tables/stage2/Australia_livestockDetailed_2010_2011_abs.csv"))




#   land management
# 2011/12 "4627_nrm.xls"
# 2012/13 "46270do002_201213.xls"
# 2013/14 "46270do002_201314.csv"
# 2014/15 "46270do002_2014-15.csv"
# 2015/16 "46270do002_201516.csv"
# 2016/17 "46270do002_201617.csv"
#
# land cover
# 1988 - 2020 "46162DO010_2020.xlsx"
