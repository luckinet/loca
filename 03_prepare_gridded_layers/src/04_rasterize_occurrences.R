message("\n---- rasterize occurrences ----")

options(adb_path = dir_census) # include this as option in adb_inventory


# load data ----
#
vct_gadm_lvl1 <- st_read(dsn = paste0(dir_input, "gadm36_levels.gpkg"), layer = "level0")

tbl_geoscheme <- readRDS(file = path_geoscheme_gadm)
tbl_invDataseries <- adb_inventory(type = "dataseries")
tbl_invTables <- adb_inventory(type = "tables")

if(!exists("rst_modelregion")){
  rst_modelregion <- rast(path_modelregion)
}

tbl_countries <- get_concept(class = "al1", ontology = path_gaz) |>
  arrange(label) |>
  select(-has_broader_match, -has_narrower_match, -has_exact_match, -has_close_match) |>
  left_join(tbl_geoscheme, by = c("label" = "unit")) |>
  mutate(ahID = str_replace_all(id, "[.]", ""), .after = "id")


# make paths ----
#
path_rst_gadm1 <- str_replace(path_ahID_model, "\\{LVL\\}", "1")


# derive data objects ----
#
ext_model <- model_info$parameters$extent
names(ext_model) <- c("xmin", "xmax", "ymin", "ymax")

target_nations <- st_crop(x = vct_gadm_lvl1, y = ext_model) |>
  left_join(tbl_countries, by = "NAME_0")

target_years <- as.character(model_info$parameters$year)

faostat_datID <- tbl_invDataseries |>
  filter(name == "faostat") |>
  pull(datID)
faostat_tabID <- tbl_invTables |>
  filter(datID == faostat_datID) |>
  pull(tabID)

for(i in 1:dim(target_nations)[1]){

  message(" --> ", target_nations$label[i])

  thisNation <- readRDS(file = paste0(dir_census, "tables/stage3/", target_nations$label[i], ".rds"))

  temp <- thisNation |>
    filter(tabID %in% faostat_tabID) |>
    filter(year %in% target_years) |>
    filter(!is.na(ontoID)) |>
    filter(str_detect(string = ontoMatch, pattern = "close")) |>
    filter(!is.na(hectares_harvested) | !is.na(hectares_covered)) |>
    mutate(ahID = str_replace_all(gazID, "[.]", ""),
           cropID = str_replace_all(ontoID, "[.]", ""))

  for(j in 11){#seq_along(target_years)){

    tempYear <- temp |>
      filter(year == target_years[j])

    message("   --> ", target_years[j])

    target_crops <- unique(tempYear$cropID)

    for(k in seq_along(target_crops)){

      tempYearCrop <- tempYear |>
        filter(cropID == target_crops[k])

      if(dim(tempYearCrop)[1] == 1){

        message("     --> ", tempYearCrop$ontoMatch, " (", tempYearCrop$cropID, ")")

        path_out <- str_replace(path_occurrence, "\\{CNCP\\}", target_crops[k]) |>
          str_replace("\\{YR\\}", target_years[j])

        if(!testFileExists(x = path_out, access = "rw")){
          writeRaster(x = rst_modelregion,
                      filename = path_out,
                      overwrite = TRUE,
                      filetype = "GTiff",
                      datatype = "INT1U",
                      gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))
          rst_temp <- rst_modelregion
        } else {
          rst_temp <- rast(path_out)
        }

        ifel(rast(path_rst_gadm1) == as.numeric(target_nations$ahID[i]),
             yes = 1, no = rst_temp, this must be so that the layer actually contains NA values, and FAO adds 0s where something is
             filename = path_out,
             overwrite = TRUE,
             filetype = "GTiff",
             datatype = "INT1U",
             gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))
      }

    }

  }

}
