allInput <- list.files(paste0(dir_census, "tables/stage1/rosstat"), recursive = TRUE, full.names = TRUE)

# store files with good name ----
#
map(seq_along(allInput), function(ix){

  tempData <- read_csv(file = allInput[ix], col_names = FALSE)

  tempName <- tail(str_split(allInput[ix], "/")[[1]], 1)
  tempName <- str_split(tempName, "[.]")[[1]][1]
  newName <- str_split(tempName, "_")[[1]]
  newName <- paste0("Russian Federation_al3_", newName[3], newName[4], "_2008_2022_rosstat")

  write_delim(x = tempData, file = paste0(dir_census, "tables/stage2/", newName, ".csv"), delim = ",", na = "", col_names = FALSE)

})


# planted area (sown, cultivated):
# Cultivated areas of agricultural crops in farms of all categories
#   - {Посевные площади сельскохозяйственных культур} в хозяйствах всех категорий
# Area of perennial plantings
#   - {Площадь многолетних насаждений}
#
# harvested area:
# -
#
# yield
# Crop yield (per harvested area)
#   - {Урожайность сельскохозяйственных культур} (в расчете на убранную площадь)
#
# production
# Gross yields of agricultural crops
#   - {Валовые сборы сельскохозяйственных культур}
# Gross yields of agricultural crops in farms of all categories
#   - {Валовые сборы сельскохозяйственных культур} в хозяйствах всех категорий
#
# livestock
# Livestock and poultry
#   - {Поголовье скота и птицы}
# Number of livestock and poultry at the end of the year
#   - {Поголовье скота и птицы} на конец года
# Number of livestock and poultry in farms of all categories at the end of the year
#   - {Поголовье скота и птицы} в хозяйствах всех категорий на конец года
#
# machines
# Availability of tractors, combines and agricultural machines in agricultural organizations at the end of the year
#   - Наличие {тракторов}, {комбайнов} и сельскохозяйственных {машин} в сельскохозяйственных организациях на конец года
# Availability of agricultural machinery in agricultural organizations at the end of the year
#   - Наличие сельскохозяйственной {техники} в сельскохозяйственных организациях на конец года
#
# fertilizer
# Mineral fertilizers applied (in terms of 100% nutrients) for crop crops in agricultural organizations
#   - Внесено {минеральных удобрений} (в пересчете на 100% питательных веществ) под посевы сельскохозяйственных культур в сельскохозяйственных организациях
# Organic fertilizers were applied to agricultural crops in agricultural organizations
#   - Внесено {органических удобрений} под посевы сельскохозяйственных культур в сельскохозяйственных организациях

