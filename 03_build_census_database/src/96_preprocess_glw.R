# script arguments ----
#


# set paths ----
#
incomingDir <- paste0(censusDBDir, "incoming/per_dataseries/gridded livestock of the world/")


# load metadata ----
#


# load data ----
#
glw3 <- read_csv(paste0(incomingDir, "gadm_36_glw3.csv.gz"))
glw4 <- read_csv(paste0(incomingDir, "gadm_410_glw4.csv.gz"))


# data processing ----
#
glw3_tidy <- glw3 %>%
  unite(col = "buffalo", contains("_bf")) %>%
  unite(col = "chicken", contains("_ch")) %>%
  unite(col = "cattle", contains("_ct")) %>%
  unite(col = "duck", contains("_dk")) %>%
  unite(col = "goat", contains("_gt")) %>%
  unite(col = "horse", contains("_ho")) %>%
  unite(col = "pig", contains("pg")) %>%
  unite(col = "sheep", contains("sh")) %>%
  select(name_0, name_1, name_2, name_3, name_4, name_5, glw3_pixel_areakm, buffalo, chicken, cattle, duck, goat, horse, pig, sheep) %>%
  pivot_longer(cols = c("buffalo", "chicken", "cattle", "duck", "goat", "horse", "pig", "sheep"), names_to = "commodity") %>%
  separate(col = value, into = c("census_ratio", "source", "year", "pixel", "polygon"), sep = "_") %>%
  mutate(across(where(is.character), ~na_if(x = ., y = "NA")),
         census_ratio = as.numeric(census_ratio),
         year = as.integer(year),
         pixel = as.numeric(pixel),
         polygon = as.numeric(polygon))

temp <- glw3_tidy %>%
  filter(!is.na(name_5))
write_csv(x = temp, file = paste0(censusDBDir, "adb_tables/stage2/_al6_livestock_", min(temp$year, na.rm = T), "_", max(temp$year, na.rm = T), "_glw3.csv"), na = "")

temp <- glw3_tidy %>%
  filter(is.na(name_5)) %>%
  filter(!is.na(name_4))
write_csv(x = temp, file = paste0(censusDBDir, "adb_tables/stage2/_al5_livestock_", min(temp$year, na.rm = T), "_", max(temp$year, na.rm = T), "_glw3.csv"), na = "")

temp <- glw3_tidy %>%
  filter(is.na(name_5) & is.na(name_4)) %>%
  filter(!is.na(name_3))
write_csv(x = temp, file = paste0(censusDBDir, "adb_tables/stage2/_al4_livestock_", min(temp$year, na.rm = T), "_", max(temp$year, na.rm = T), "_glw3.csv"), na = "")

temp <- glw3_tidy %>%
  filter(is.na(name_5) & is.na(name_4) & is.na(name_3)) %>%
  filter(!is.na(name_2))
write_csv(x = temp, file = paste0(censusDBDir, "adb_tables/stage2/_al3_livestock_", min(temp$year, na.rm = T), "_", max(temp$year, na.rm = T), "_glw3.csv"), na = "")

temp <- glw3_tidy %>%
  filter(is.na(name_5) & is.na(name_4) & is.na(name_3) & is.na(name_2)) %>%
  filter(!is.na(name_1))
write_csv(x = temp, file = paste0(censusDBDir, "adb_tables/stage2/_al2_livestock_", min(temp$year, na.rm = T), "_", max(temp$year, na.rm = T), "_glw3.csv"), na = "")

temp <- glw3_tidy %>%
  filter(is.na(name_5) & is.na(name_4) & is.na(name_3) & is.na(name_2) & is.na(name_1)) %>%
  filter(!is.na(name_0))
write_csv(x = temp, file = paste0(censusDBDir, "adb_tables/stage2/_al1_livestock_", min(temp$year, na.rm = T), "_", max(temp$year, na.rm = T), "_glw3.csv"), na = "")


glw4_tidy <- glw4 %>%
  unite(col = "buffalo", contains("_bf")) %>%
  unite(col = "chicken", contains("_ch")) %>%
  unite(col = "cattle", contains("_ct")) %>%
  unite(col = "duck", contains("_dk")) %>%
  unite(col = "goat", contains("_gt")) %>%
  unite(col = "horse", contains("_ho")) %>%
  unite(col = "pig", contains("pg")) %>%
  unite(col = "sheep", contains("sh")) %>%
  select(name_0, name_1, name_2, name_3, name_4, name_5, glw4_pixel_areakm, buffalo, chicken, cattle, duck, goat, horse, pig, sheep) %>%
  pivot_longer(cols = c("buffalo", "chicken", "cattle", "duck", "goat", "horse", "pig", "sheep"), names_to = "commodity") %>%
  separate(col = value, into = c("census_ratio", "source", "year", "pixel", "polygon"), sep = "_") %>%
  mutate(across(where(is.character), ~na_if(x = ., y = "NA")),
         census_ratio = as.numeric(census_ratio),
         year = as.integer(year),
         pixel = as.numeric(pixel),
         polygon = as.numeric(polygon))


temp <- glw4_tidy %>%
  filter(!is.na(name_5))
write_csv(x = temp, file = paste0(censusDBDir, "adb_tables/stage2/_al6_livestock_", min(temp$year, na.rm = T), "_", max(temp$year, na.rm = T), "_glw4.csv"), na = "")

temp <- glw4_tidy %>%
  filter(is.na(name_5)) %>%
  filter(!is.na(name_4))
write_csv(x = temp, file = paste0(censusDBDir, "adb_tables/stage2/_al5_livestock_", min(temp$year, na.rm = T), "_", max(temp$year, na.rm = T), "_glw4.csv"), na = "")

temp <- glw4_tidy %>%
  filter(is.na(name_5) & is.na(name_4)) %>%
  filter(!is.na(name_3))
write_csv(x = temp, file = paste0(censusDBDir, "adb_tables/stage2/_al4_livestock_", min(temp$year, na.rm = T), "_", max(temp$year, na.rm = T), "_glw4.csv"), na = "")

temp <- glw4_tidy %>%
  filter(is.na(name_5) & is.na(name_4) & is.na(name_3)) %>%
  filter(!is.na(name_2))
write_csv(x = temp, file = paste0(censusDBDir, "adb_tables/stage2/_al3_livestock_", min(temp$year, na.rm = T), "_", max(temp$year, na.rm = T), "_glw4.csv"), na = "")

temp <- glw4_tidy %>%
  filter(is.na(name_5) & is.na(name_4) & is.na(name_3) & is.na(name_2)) %>%
  filter(!is.na(name_1))
write_csv(x = temp, file = paste0(censusDBDir, "adb_tables/stage2/_al2_livestock_", min(temp$year, na.rm = T), "_", max(temp$year, na.rm = T), "_glw4.csv"), na = "")

temp <- glw4_tidy %>%
  filter(is.na(name_5) & is.na(name_4) & is.na(name_3) & is.na(name_2) & is.na(name_1)) %>%
  filter(!is.na(name_0))
write_csv(x = temp, file = paste0(censusDBDir, "adb_tables/stage2/_al1_livestock_", min(temp$year, na.rm = T), "_", max(temp$year, na.rm = T), "_glw4.csv"), na = "")



