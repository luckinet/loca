fao_path <- paste0(dir_census_wip, "tables/stage1/faostat/")

# split table ----
#
unzip(zipfile = paste0(fao_path, "Production_Crops_Livestock_E_All_Data_(Normalized).zip"),
      exdir = paste0(fao_path, "temp/"))

cropLivestock_in <- read_csv(file = paste0(fao_path, "temp/Production_Crops_Livestock_E_All_Data_(Normalized).csv"))


harvested <- cropLivestock_in |>
  filter(Element == "Area harvested")

production <- cropLivestock_in |>
  filter(Element == "Production")

yield <- cropLivestock_in |>
  filter(Element == "Yield")

livestock <- cropLivestock_in |>
  filter(Element == "Stocks")

write_csv(x = harvested, file = paste0(dir_census_wip, "tables/stage2/_al1_cropsHarvested_1961_2022_faostat.csv"), na = "")
write_csv(x = production, file = paste0(dir_census_wip, "tables/stage2/_al1_cropsProduction_1961_2022_faostat.csv"), na = "")
write_csv(x = yield, file = paste0(dir_census_wip, "tables/stage2/_al1_cropsYield_1961_2022_faostat.csv"), na = "")
write_csv(x = livestock, file = paste0(dir_census_wip, "tables/stage2/_al1_livestock_1961_2022_faostat.csv"), na = "")

unlink(paste0(fao_path, "temp/"), recursive = TRUE)
