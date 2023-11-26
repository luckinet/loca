abs_path <- paste0(census_dir, "adb_tables/stage1/abs/")

# historic data ----
# merge spreadsheets into a single table
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

write_csv(x = crops_historic, file = paste0(census_dir, "adb_tables/stage2/Australia_al2_cropsHistoric_1861_2011_abs.csv"))

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

write_csv(x = livestock_historic, file = paste0(census_dir, "adb_tables/stage2/Australia_al2_livestockHistoric_1860_2011_abs.csv"))


# 2000/2001 ----
# merge several files into a single table
theFiles <- list.files(path = abs_path, pattern = "71250do\\d{3}_200001.zip")

all2001 <- map(.x = seq_along(theFiles), .f = function(ix){

  unzip(zipfile = paste0(abs_path, theFiles[ix]), exdir = paste0(abs_path, "temp"))

  theFile <- list.files(path = paste0(abs_path, "temp"), full.names = TRUE)

  theRegion <- str_split(read_excel(path = theFile, sheet = 1)[7, 3, drop = TRUE], pattern = " [:punct:] ")[[1]][1]

  regional <- reorg_abs(file = theFile, skip = 4, trim_by = "Commonwealth", offset = 3) %>%
    bind_rows() %>%
    pivot_longer(cols = !variable) %>%
    separate(col = name, into = c("al3", "dimension"), sep = " -_-_ ") %>%
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

write_csv(x = crops2001, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_crops_2000_2001_abs.csv"))
write_csv(x = livestock2001, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_livestock_2000_2001_abs.csv"))


# 2001/2002 ----
# only pdf


# 2002/2003 ----
# only pdf


# 2003/2004 ----
# only pdf


# 2004/2005 ----
# only pdf


# 2005/2006 ----
theFiles <- list.files(path = abs_path, pattern = "71250[a-zA-Z]{2}\\d{3}_200506.xls")

all2006 <- map(.x = seq_along(theFiles), .f = function(ix){

  theRegion <- str_split(read_excel(path = paste0(abs_path, theFiles[ix]), sheet = 1)[6, 3, drop = TRUE], pattern = " [:punct:] ")[[1]][1]

  regional <- reorg_abs(file = paste0(abs_path, theFiles[ix]), skip = 4, trim_by = "Commonwealth", offset = 3) %>%
    bind_rows() %>%
    pivot_longer(cols = !variable) %>%
    separate(col = name, into = c("al3", "dimension"), sep = " -_-_ ") %>%
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

write_csv(x = crops2006, file = paste0(census_dir, "adb_tables/stage2/Australia_al2_crops_2005_2006_abs.csv"))
write_csv(x = livestock2006, file = paste0(census_dir, "adb_tables/stage2/Australia_al2_livestock_2005_2006_abs.csv"))


# 2006/2007 ----
theFiles <- list.files(path = abs_path, pattern = "71250[a-zA-Z]{2}\\d{3}_200607.xls")

all2007 <- map(.x = seq_along(theFiles), .f = function(ix){

  theRegion <- str_split(read_excel(path = paste0(abs_path, theFiles[ix]), sheet = 1)[6, 3, drop = TRUE], pattern = " [:punct:] ")[[1]][1]

  regional <- reorg_abs(file = paste0(abs_path, theFiles[ix]), skip = 4, trim_by = "Commonwealth", offset = 3) %>%
    bind_rows() %>%
    pivot_longer(cols = !variable) %>%
    separate(col = name, into = c("al3", "dimension"), sep = " -_-_ ") %>%
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

write_csv(x = crops2007, file = paste0(census_dir, "adb_tables/stage2/Australia_al2_crops_2006_2007_abs.csv"))
write_csv(x = livestock2007, file = paste0(census_dir, "adb_tables/stage2/Australia_al2_livestock_2006_2007_abs.csv"))


# 2007/2008 ----
all2008 <- reorg_abs(file = paste0(abs_path, "71210do002_200708.xls"), skip = 4, trim_by = "Commonwealth", offset = 3)
all2008_names <- c("New South Wales", "Victoria", "Queensland", "South Australia", "Western Australia", "Tasmania", "NT and ACT")

all2008 <- map(.x = seq_along(all2008), .f = function(ix){
  all2008[[ix]] %>%
    pivot_longer(cols = !variable) %>%
    separate(col = name, into = c("al3", "dimension"), sep = " -_-_ ") %>%
    filter(dimension == "Estimate") %>%
    filter(!is.na(variable)) %>%
    select(-dimension) %>%
    add_column(al2 = all2008_names[ix], .before = "al3")
}) %>%
  bind_rows()

crops2008 <- all2008 %>%
  filter(str_detect(variable, regex("Livestock", ignore_case = TRUE), negate = TRUE))
livestock2008 <- all2008 %>%
  filter(str_detect(variable, regex("Livestock", ignore_case = TRUE)))

write_csv(x = crops2008, file = paste0(census_dir, "adb_tables/stage2/Australia_al2_crops_2007_2008_abs.csv"))
write_csv(x = livestock2008, file = paste0(census_dir, "adb_tables/stage2/Australia_al2_livestock_2007_2008_abs.csv"))


# 2008/2009 ----
all2009 <- reorg_abs(file = paste0(abs_path, "71210do005_200809.xls"), skip = 4, trim_by = "Commonwealth", offset = 3)
all2009_names <- c("Australia", "New South Wales", "Victoria", "Queensland", "South Australia", "Western Australia", "Tasmania", "Northern Territory", "Australian Capital Territory")

all2009 <- map(.x = seq_along(all2009), .f = function(ix){
  all2009[[ix]] %>%
    pivot_longer(cols = !variable) %>%
    separate(col = name, into = c("al3", "dimension"), sep = " -_-_ ") %>%
    filter(dimension == "Estimate") %>%
    filter(!is.na(variable)) %>%
    select(-dimension) %>%
    add_column(al2 = all2009_names[ix], .before = "al3")
}) %>%
  bind_rows()

crops2009 <- all2009 %>%
  filter(str_detect(variable, regex("Livestock", ignore_case = TRUE), negate = TRUE))
livestock2009 <- all2009 %>%
  filter(str_detect(variable, regex("Livestock", ignore_case = TRUE)))

write_csv(x = crops2009, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_crops_2008_2009_abs.csv"))
write_csv(x = livestock2009, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_livestock_2008_2009_abs.csv"))


# 2009/2010 ----
all2010 <- reorg_abs(file = paste0(abs_path, "71210do002_200910.xls"), skip = 4, trim_by = "Commonwealth", offset = 3)
all2010_names <- c("New South Wales", "Victoria", "Queensland", "South Australia", "Western Australia", "Tasmania", "Northern Territory", "Australian Capital Territory")

all2010 <- map(.x = seq_along(all2010), .f = function(ix){
  all2010[[ix]] %>%
    pivot_longer(cols = !variable) %>%
    separate(col = name, into = c("al3", "dimension"), sep = " - ") %>%
    filter(dimension == "Estimate") %>%
    filter(!is.na(variable)) %>%
    select(-dimension) %>%
    add_column(al2 = all2010_names[ix], .before = "al3")
}) %>%
  bind_rows()

crops2010 <- all2010 %>%
  filter(str_detect(variable, regex("Livestock", ignore_case = TRUE), negate = TRUE))
livestock2010 <- all2010 %>%
  filter(str_detect(variable, regex("Livestock", ignore_case = TRUE)))

write_csv(x = crops2010, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_crops_2009_2010_abs.csv"))
write_csv(x = livestock2010, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_livestock_2009_2010_abs.csv"))


# 2010/2011 ----
theFiles <- list.files(path = abs_path, pattern = "71210do\\d{3}_201011.xls")

all2011 <- map(.x = seq_along(theFiles), .f = function(ix){

  theRegion <- str_split(string = str_split(read_excel(path = paste0(abs_path, theFiles[ix]), sheet = 1)[6, 3, drop = TRUE], pattern = "[:punct:] ")[[1]][4], pattern = "[:punct:]")[[1]][1]

  regional <- reorg_abs(file = paste0(abs_path, theFiles[ix]), skip = 4, trim_by = "Commonwealth", offset = 2)
  theDistricts <- map(str_split(colnames(regional[[1]])[seq(2, dim(regional[[1]])[2], 2)], " -_-_ "), 1)
  map(.x = 2:length(regional), .f = function(iy){
    regional[[iy]] %>%
      select(-c(2:3)) %>%
      pivot_longer(cols = !variable) %>%
      separate(col = name, into = c("al4", "dimension"), sep = " -_-_ ") %>%
      filter(dimension == "Estimate") %>%
      filter(!is.na(variable)) %>%
      select(-dimension) %>%
      add_column(al2 = theRegion, .before = "al4") %>%
      add_column(al3 = theDistricts[[iy]], .before = "al4")
  }) %>%
    bind_rows()
}) %>%
  bind_rows()

crops2011 <- all2011 %>%
  filter(str_detect(variable, regex("Livestock", ignore_case = TRUE), negate = TRUE))
livestock2011 <- all2011 %>%
  filter(str_detect(variable, regex("Livestock", ignore_case = TRUE)))

write_csv(x = crops2011, file = paste0(census_dir, "adb_tables/stage2/Australia_al4_crops_2010_2011_abs.csv"))
write_csv(x = livestock2011, file = paste0(census_dir, "adb_tables/stage2/Australia_al4_livestock_2010_2011_abs.csv"))


# 2011/2012 ----
all2012 <- reorg_abs(file = paste0(abs_path, "7121_sa4.xls"), skip = 5, trim_by = ".. not applicable", offset = 3, territory = "rows") %>%
  bind_rows()

crops2012 <- all2012 %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE), negate = TRUE))
livestock2012 <- all2012 %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE)))

write_csv(x = crops2012, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_crops_2011_2012_abs.csv"))
write_csv(x = livestock2012, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_livestock_2011_2012_abs.csv"))


# 2012/2013 ----
all2013 <- reorg_abs(file = paste0(abs_path, "71210do004_201213.xls"), skip = 5, trim_by = ".. not applicable", offset = 3, territory = "rows") %>%
  bind_rows()

crops2013 <- all2013 %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE), negate = TRUE))
livestock2013 <- all2013 %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE)))

write_csv(x = crops2013, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_crops_2012_2013_abs.csv"))
write_csv(x = livestock2013, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_livestock_2012_2013_abs.csv"))


# 2013/2014 ----
all2014 <- reorg_abs(file = paste0(abs_path, "71210do004_201314.xls"), skip = 5, trim_by = ".. not applicable", offset = 3, territory = "rows") %>%
  bind_rows()

crops2014 <- all2014 %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE), negate = TRUE))
livestock2014 <- all2014 %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE)))

write_csv(x = crops2014, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_crops_2013_2014_abs.csv"))
write_csv(x = livestock2014, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_livestock_2013_2014_abs.csv"))

# 2014/2015 ----
theFile <- paste0(abs_path, "71210do006_201415.csv")
temp <- read_csv(file = theFile, skip = 4)

crops2015 <- temp %>%
  filter(str_detect(`Commodity label`, regex("Livestock", ignore_case = TRUE), negate = TRUE))
livestock2015 <- temp %>%
  filter(str_detect(`Commodity label`, regex("Livestock", ignore_case = TRUE)))

write_csv(x = crops2015, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_crops_2014_2015_abs.csv"))
write_csv(x = livestock2015, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_livestock_2014_2015_abs.csv"))

# 2015/2016 ----
theFile <- paste0(abs_path, "7121do004_201516.csv")
temp <- read_csv(file = theFile, skip = 4)

crops2016 <- temp %>%
  filter(str_detect(`Commodity description` , regex("Livestock", ignore_case = TRUE), negate = TRUE))
livestock2016 <- temp %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE)))

write_csv(x = crops2016, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_crops_2015_2016_abs.csv"))
write_csv(x = livestock2016, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_livestock_2015_2016_abs.csv"))


# 2016/2017 ----
theFile <- paste0(abs_path, "71210do005_201617.csv")
temp <- read_csv(file = theFile, skip = 4)

crops2017 <- temp %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE), negate = TRUE))
livestock2017 <- temp %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE)))

write_csv(x = crops2016, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_crops_2016_2017_abs.csv"))
write_csv(x = livestock2016, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_livestock_2016_2017_abs.csv"))


# 2017/2018 ----
theFile <- paste0(abs_path, "71210do005_201718.csv")
temp <- read_csv(file = theFile, skip = 4)

crops2018 <- temp %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE), negate = TRUE))
livestock2018 <- temp %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE)))

write_csv(x = crops2018, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_crops_2017_2018_abs.csv"))
write_csv(x = livestock2018, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_livestock_2017_2018_abs.csv"))

# 2018/2019 ----
theFile <- paste0(abs_path, "71210do005_201819.csv")
temp <- read_csv(file = theFile, skip = 4)

crops2019 <- temp %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE), negate = TRUE))
livestock2019 <- temp %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE)))

write_csv(x = crops2019, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_crops_2018_2019_abs.csv"))
write_csv(x = livestock2019, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_livestock_2018_2019_abs.csv"))

# 2019/2020 ----
theFile <- paste0(abs_path, "71210DO003_201920.csv")
temp <- read_csv(file = theFile, skip = 4)

crops2020 <- temp %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE), negate = TRUE))
livestock2020 <- temp %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE)))

write_csv(x = crops2020, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_crops_2019_2020_abs.csv"))
write_csv(x = livestock2020, file = paste0(census_dir, "adb_tables/stage2/Australia_al3_livestock_2019_2020_abs.csv"))

# 2020/2021 ----
all2021 <- list.files(path = abs_path, pattern = "AGCDCASGS202021.xlsx", full.names = TRUE) %>%
  read_excel(sheet = 2, skip = 6, col_names = FALSE)

fullNames <- all2021[1, ]
all2021 <- all2021 %>%
  slice(-1)
colnames(all2021) <- fullNames

crops2021 <- all2021 %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE), negate = TRUE))
livestock2021 <- all2021 %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE)))

write_csv(x = crops2021, file = paste0(census_dir, "adb_tables/stage2/Australia_al4_crops_2020_2021_abs.csv"))
write_csv(x = livestock2021, file = paste0(census_dir, "adb_tables/stage2/Australia_al4_livestock_2020_2021_abs.csv"))

# 2021/2022 ----
all2022 <- list.files(path = abs_path, pattern = "AGCDCNAT_STATE202122.xlsx", full.names = TRUE) %>%
  read_excel(sheet = 2, skip = 6, col_names = FALSE)

fullNames <- all2022[1, ]
all2022 <- all2022 %>%
  slice(-1)
colnames(all2022) <- fullNames

crops2022 <- all2022 %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE), negate = TRUE))
livestock2022 <- all2022 %>%
  filter(str_detect(`Commodity description`, regex("Livestock", ignore_case = TRUE)))

write_csv(x = crops2022, file = paste0(census_dir, "adb_tables/stage2/Australia_al2_crops_2021_2022_abs.csv"))
write_csv(x = livestock2022, file = paste0(census_dir, "adb_tables/stage2/Australia_al2_livestock_2021_2022_abs.csv"))



# land management ----
# 2011/12 "4627_nrm.xls"
# 2012/13 "46270do002_201213.xls"
# 2013/14 "46270do002_201314.csv"
# 2014/15 "46270do002_2014-15.csv"
# 2015/16 "46270do002_201516.csv"
# 2016/17 "46270do002_201617.csv"
#
# land cover
# 1988 - 2020 "46162DO010_2020.xlsx"
