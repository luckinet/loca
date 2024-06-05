# split GEO column into several according to territorial level ----
#
can_al4 <- list.files(path = paste0(dir_census_wip, "tables/stage1/statcan"), full.names = TRUE)


for(i in seq_along(can_al4)){

  theZip <- can_al4[i]
  fileName <- str_split(tail(str_split(theZip, "/")[[1]], 1), "-")[[1]][1]
  if(fileName == "temp") next

  unzip(zipfile = can_al4[i], exdir = paste0(dir_census_wip, "tables/stage1/statcan/temp/"))

  tempIn <- read_csv(paste0(dir_census_wip, "tables/stage1/statcan/temp/", fileName, ".csv"))

  if(any(str_detect(string = tempIn$GEO, pattern = "\\[PR|\\[CD|\\CCS|\\[CAR"))){

    temp <- tempIn |>
      mutate(al2 = if_else(str_detect(string = GEO, pattern = "\\[PR"), GEO, NA_character_),
             al3 = if_else(str_detect(string = GEO, pattern = "\\[CD"), GEO, NA_character_),
             al4 = if_else(str_detect(string = GEO, pattern = "\\[CCS"), GEO, NA_character_)) |>
      filter(!str_detect(string = GEO, pattern = "\\[CAR")) |>
      fill(al2, .direction = "down") |>
      group_by(al2) |>
      fill(al3, .direction = "down") |>
      group_by(al3) |>
      fill(al4, .direction = "down") |>
      select(REF_DATE, al2, al3, al4, everything()) |>
      filter(!is.na(al4))
    # there are still some units that are duplicated, find a way to deal with them, e.g. Quebec -> Memphrémagog -> Hatley

  } else {
    temp <- tempIn |>
      filter(!str_detect(string = GEO, pattern = "Canada")) |>
      rename(al2 = GEO)
  }

  write_csv(x = temp, file = paste0(dir_census_wip, "tables/stage2/Canada_", fileName, "_statcan.csv"), na = "")

}
