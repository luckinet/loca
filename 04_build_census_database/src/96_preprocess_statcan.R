# split GEO column into several according to territorial level ----
#
can_al4 <- list.files(path = paste0(dir_census, "tables/stage2"), pattern = "Canada_al4", full.names = TRUE)
can_al4 <- list.files(path = paste0(dir_census, "tables/stage1/statcan"), full.names = TRUE)


for(i in seq_along(can_al4)){

  theZip <- can_al4[i]
  fileName <- str_split(tail(str_split(theZip, "/")[[1]], 1), "-")[[1]][1]

  unzip(zipfile = can_al4[i], exdir = paste0(dir_census, "tables/stage1/statcan/temp/"))

  tempIn <- read_csv(paste0(fileName, ".csv"))
  temp <- tempIn %>%
    mutate(al = if_else(str_detect(string = GEO, pattern = "\\[PR"), "al2",
                        if_else(str_detect(string = GEO, pattern = "\\[CAR"), "al3",
                                if_else(str_detect(string = GEO, pattern = "\\[CD"), "al4",
                                        if_else(str_detect(string = GEO, pattern = "\\[CCS"), "al5", "al1"))))) %>%
    mutate(GEO_new = if_else(str_detect(string = GEO, pattern = "\\[PR"), GEO, NA_character_),
           GEO2 = if_else(str_detect(string = GEO, pattern = "\\[CAR"), GEO, NA_character_),
           GEO3 = if_else(str_detect(string = GEO, pattern = "\\[CD"), GEO, NA_character_),
           GEO4 = if_else(str_detect(string = GEO, pattern = "\\[CCS"), GEO, NA_character_),
           GEO = GEO_new) %>%
    fill(GEO, .direction = "down") %>%
    group_by(GEO_new) %>%
    fill(GEO2, .direction = "down") %>%
    group_by(GEO2) %>%
    fill(GEO3, .direction = "down") %>%
    group_by(GEO3) %>%
    fill(GEO4, .direction = "down") %>%
    select(REF_DATE, GEO, GEO2, GEO3, GEO4, everything()) %>%
    filter(!is.na(GEO4)) fix this so that the correct territorial level is selected

  write_csv(x = temp, file = paste0(dir_census, "tables/stage2/Canada_", fileName, "_statcan.csv"))

}
