# split GEO column into several according to territorial level ----
#
can_al4 <- list.files(path = paste0(census_dir, "adb_tables/stage2/"), pattern = "Canada_al4", full.names = TRUE)

for(i in seq_along(can_al4)){

  temp <- read_csv(can_al4[i]) %>%
    mutate(GEO_new = if_else(str_detect(string = GEO, pattern = "\\[PR"), GEO, NA_character_),
           GEO2 = if_else(str_detect(string = GEO, pattern = "\\[CAR"), GEO, NA_character_),
           GEO3 = if_else(str_detect(string = GEO, pattern = "\\[CD"), GEO, NA_character_),
           GEO4 = if_else(str_detect(string = GEO, pattern = "\\[CCS"), GEO, NA_character_),
           GEO = GEO_new) %>%
    select(REF_DATE, GEO, GEO2, GEO3, GEO4, everything())

}
