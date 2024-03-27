# ----
# title        : rasterize occurrences
# authors      : Steffen Ehrmann
# version      : 0.7.0
# date         : 2024-03-27
# description  : _INSERT
# documentation: -
# ----
message("\n---- rasterize occurrences ----")

# 1. make paths ----
#
path_rst_gadm1 <- str_replace(path_ahID_model, "\\{LVL\\}", "1")
options(adb_path = dir_census) # include this as option in adb_inventory

# 2. load data ----
#
vct_gadm_lvl1 <- st_read(dsn = paste0(dir_input, "gadm36_levels.gpkg"), layer = "level0")

tbl_geoscheme <- readRDS(file = path_geoscheme_gadm)
tbl_invDataseries <- adb_inventory(type = "dataseries")
tbl_invTables <- adb_inventory(type = "tables")

if(!exists("rst_modelregion")){
  rst_modelregion <- rast(path_modelregion)
}

# 3. data processing ----
#
tbl_countries <- get_concept(class = "al1", ontology = path_gaz) |>
  arrange(label) |>
  select(-has_broader_match, -has_narrower_match, -has_exact_match, -has_close_match) |>
  left_join(tbl_geoscheme, by = c("label" = "unit")) |>
  mutate(ahID = str_replace_all(id, "[.]", ""), .after = "id")

## derive data objects ----
#
ext_model <- model_info$parameters$extent
names(ext_model) <- c("xmin", "xmax", "ymin", "ymax")

target_nations <- st_crop(x = vct_gadm_lvl1, y = ext_model) |>
  left_join(tbl_countries, by = "NAME_0")

target_years <- as.character(model_info$parameters$year)

faostat_datID <- tbl_invDataseries |>
  filter(name %in% c("faostat", "frafao")) |>
  pull(datID)
faostat_tabID <- tbl_invTables |>
  filter(datID %in% faostat_datID) |>
  pull(tabID)

for(i in 1:dim(target_nations)[1]){

  message(" --> ", target_nations$label[i])

  if(testFileExists(x = paste0(dir_census, "tables/stage3/", target_nations$label[i], ".rds"))){
    thisNation <- readRDS(file = paste0(dir_census, "tables/stage3/", target_nations$label[i], ".rds"))
  } else {
    next
  }

  if(!testNames(x = names(thisNation), must.include = c("hectares_harvested", "hectares_covered"))){
    next
  }

  basis <- thisNation |>
    filter(year %in% target_years) |>
    filter(!is.na(ontoID)) |>
    filter(str_detect(string = ontoMatch, pattern = "close")) |>
    filter(!is.na(hectares_harvested) | !is.na(hectares_covered)) |>
    mutate(ahID = str_replace_all(gazID, "[.]", ""),
           cropID = str_replace_all(ontoID, "[.]", ""))

  basisFao <- basis |>
    filter(tabID %in% faostat_tabID)

  basisNat <- basis |>
    filter(!tabID %in% faostat_tabID)

  tgt_yr <-target_years[1]# for(tgt_yr in target_years){

  yearFao <- basisFao |>
    filter(year == tgt_yr)
  yearNat <- basisNat |>
    filter(year == tgt_yr)

  message("   --> ", tgt_yr)

  target_crops <- unique(c(yearFao$cropID, yearNat$cropID))

  tgt_crop <- target_crops[25] # for(tgt_crop in target_crops){

  yearCropFao <- yearFao |>
    filter(cropID == tgt_crop)
  yearCropNat <- yearNat |>
    filter(cropID == tgt_crop)

  path_out <- str_replace(path_occurrence, "\\{CNCP\\}", tgt_crop) |>
    str_replace("\\{YR\\}", tgt_yr)

  if(!testFileExists(x = path_out, access = "rw")){
    writeRaster(x = setValues(rst_modelregion, values = NA_integer_),
                filename = path_out,
                overwrite = TRUE,
                filetype = "GTiff",
                datatype = "INT1U",
                gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))
  }

  # write the fao basis data
  if(dim(yearCropFao)[1] == 1){

    message("     --> ", yearCropFao$cropID, ": ", yearCropFao$ontoMatch)
    rst_temp <- rast(path_out)

    ifel(rast(path_rst_gadm1) == as.numeric(target_nations$ahID[i]),
         yes = 0, no = rst_temp,
         filename = path_out,
         overwrite = TRUE,
         filetype = "GTiff",
         datatype = "INT1U",
         gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))
  }

  # make and write the subnational data
  if(dim(yearCropNat)[1] != 0){

    message("     --> ", yearCropNat$cropID, ": ", yearCropNat$ontoMatch)
    rst_temp <- rast(path_out)

    rst_tgt_ahID <- rast() # get the respective administrative level layer
    tgt_ahIDs <- # get the ahIDs

      ifel(rst_tgt_ahID == tgt_ahIDs,
           yes = 1, no = rst_temp,
           filename = path_out,
           overwrite = TRUE,
           filetype = "GTiff",
           datatype = "INT1U",
           gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9", "PREDICTOR=2"))

  }

  # }
  gc()

  # }

}

# 4. write output ----
#

# beep(sound = 10)
message("\n     ... done")


