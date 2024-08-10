# ----
# title       : document code snippets
# description : This is a script that contains all sort of snippets that do some useful thing that was needed somewhere in the pipeline
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-08-04
# version     : 0.0.0
# status      : working
# comment     : file.edit(paste0(dir_docs, "/documentation/_.md"))
# ----

# calculate the percent national agricultural area and the permille global agricultural area
faolanduse <- read_csv(file = "C:/Users/steff/Projekte/loca/00_data/04_census_data/tables/stage2/processed/_al1_landuse_1961_2018_faostat.csv")

ignoreReg <- c("World", "Americas", "Asia", "Africa", "Net Food Importing Developing Countries", "Low Income Food Deficit Countries", "Europe", "Least Developed Countries", "Northern America", "Eastern Europe", "South America", "Land Locked Developing Countries", "Eastern Asia", "Oceania", "Australia and New Zealand", "Melanesia", "Polynesia", "Micronesia", "Caribbean", "Northern Africa", "Eastern Africa", "Southern Asia", "Middle Africa", "Western Africa", "Western Asia", "South-eastern Asia", "European Union (28)", "European Union (27)", "Central Asia", "Southern Africa", "Central America", "Northern Europe", "Southern Europe", "Small Island Developing States", "Western Europe", "China")

faolanduse |>
  filter(!Area %in% ignoreReg & Year == 2018 & Item %in% c("Country area", "Agriculture")) |>
  pivot_wider(id_cols = "Area", names_from = "Item", values_from = "Value") |>
  mutate(country = round(`Country area`),
         agriculture = round(Agriculture),
         national_percent = round(agriculture / country * 100, 2),
         global_permille = round(agriculture / sum(country) * 1000, 7)) |>
  arrange(desc(country)) |>
  select(-`Country area`, -Agriculture) |>
  mutate(global_permille_sci = formatC(global_permille, format = "e", digits = 2)) |>
  # View() |>
  write_csv(file = paste0(dir_data, "_misc/global_agriculture_area.csv"), na = "missing")


# other left-over code ----
# lc_limits <- tibble(landcover = rep(c("Cropland_lc", "Forest_lc", "Meadow_lc", "Other_lc"), each = 4),
#                     lcID = rep(c(10, 20, 30, 40), each = 4),
#                     luckinetID = as.character(rep(c(1120, 1122, 1124, 1126), 4)),
#                     short = rep(c("crop", "forest", "grazing", "other"), 4),
#                     min = c(0.5, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0),
#                     max = c(1, 0.5, 0.5, 0.5, 0.5, 1, 0.5, 0.5, 0.5, 0.5, 1, 0.5, 0, 0, 0, 1))
