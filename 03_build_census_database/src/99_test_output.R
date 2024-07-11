# ----
# title       : build census database - test output datasets
# description : this is the subscript of module 4 that test various aspects of the output datasets and collates them into an analysis matrix
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-07-03
# version     : 0.8.0
# status      : work in progress
# comment     : file.edit(paste0(dir_docs, "/documentation/03_build_census_database.md"))
# ----

tables <- list.files(path = paste0(dir_census_wip, "tables/stage3"), full.names = TRUE)
geometries <- list.files(path = paste0(dir_census_wip, "geometries/stage3"), full.names = TRUE)

inv_tables <- adb_inventory(type = "tables")
inv_geoms <- adb_inventory(type = "geometries")
inv_series <- adb_inventory(type = "dataseries")

targetVar <- "pig"
taregetYear <- "2010"

for(i in seq_along(tables)){

  nation <- str_split(last(str_split(tables[i], pattern = "/")[[1]]), "[.]")[[1]][1]
  message("  '", nation, "'")

  table <- readRDS(file = tables[i])

  # visually diagnose some missing data
  table |>
    filter(is.na(gazID)) |>
    distinct(gazMatch)
  table |>
    filter(is.na(ontoID)) |>
    distinct(ontoMatch)

  # build metadata
  tabIDs <- table |>
    distinct(tabID)

  temp_inv_tables <- inv_tables |>
    filter(tabID %in% tabIDs$tabID)
  tempLvls <- temp_inv_tables |>
    distinct(level)

  meta <- table |>
    group_by(gazID, geoID) |>
    summarise(sources = n_distinct(tabID),
              animals = n_distinct(animal),
              years = n_distinct(year),
              min_year = min(year),
              max_year = max(year)) |>
    ungroup()

  # summarise variables
  var <- table |>
    filter(!is.na(gazID)) |>
    filter(year == taregetYear) |>
    filter(str_detect(ontoMatch, "close")) |>
    pivot_wider(id_cols = c(gazID), names_from = animal, values_from = number_heads, values_fn = mean)

  # put it together
  geometry <- which(str_detect(string = geometries, pattern = nation))
  geometry <- st_read(dsn = geometries[geometry], max(tempLvls$level))

  full <- geometry |>
    filter(geoID %in% temp_inv_tables$geoID) |>
    left_join(meta, by = c("gazID", "geoID")) |>
    left_join(var, by = "gazID")

  thisGeoID <- full |>
    as_tibble() |>
    distinct(geoID)

  temp_inv_geoms <- inv_geoms |>
    filter(geoID %in% thisGeoID$geoID)
  temp_inv_series <- inv_series |>
    filter(datID %in% temp_inv_geoms$datID)

  ggplot(full) +
    geom_sf(aes(fill = !!sym(targetVar)), lwd = 0.05, color = "white") +
    scale_fill_gradientn(
      colours = c("#F1E4DBFF", "#D7C9BEFF", "#8B775FFF", "#9AA582FF", "#657359FF"),
      name = "headcount",
      trans = "log10"
    ) +
    labs(
      title = paste0("Headcount of ", targetVar, " in ", taregetYear),
      subtitle = paste0(nation, " at admin level ", max(tempLvls$level)),
      caption = paste0("Source: ", temp_inv_series$description, " (", temp_inv_series$homepage, ")")
    ) +
    theme_map() +
    theme(
      legend.position = "top",
      legend.justification = 0.5,
      legend.key.width = unit(1.75, "cm"),
      legend.margin = margin(),
      plot.title = element_text(size = 20, hjust = 0.5),
      plot.subtitle = element_text(hjust = 0.5)
    )

}
