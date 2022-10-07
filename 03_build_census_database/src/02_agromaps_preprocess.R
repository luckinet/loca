# script description ----
#
# the table contains the administrative levels 2 and 3 in the same table. Here, the
# tables are split into subsets and stored as seperate files.


# data processing ----
#
temp <- read_csv(file = paste0(DBDir, "adb_tables/stage1/dumpAgromaps.csv"))

temp %>%
  filter(`Administrative Level` == "Admin 1") %>%
  write_csv(path = paste0(steffen, "/areal database/adb_tables/stage2/_2__agromaps_1_1970_2011.csv"))

temp %>%
  filter(`Administrative Level` == "Admin 2") %>%
  write_csv(path = paste0(steffen, "/areal database/adb_tables/stage2/_3__agromaps_2_1970_2011.csv"))
