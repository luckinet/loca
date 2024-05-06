# ----
# title        : rasterize GADM
# authors      : Steffen Ehrmann
# version      : 1.0.0
# date         : 2024-03-27
# description  : _INSERT
# documentation: -
# ----
message("\n---- rasterize gadm ----")


# load data ----
#
tbl_geoscheme <- readRDS(file = path_geoscheme_gadm)


# data processing ----
#
tbl_countries <- get_concept(class = "al1", ontology = path_gaz) %>% add also the other administrative layers here
  arrange(label) %>%
  select(-has_broader_match, -has_narrower_match, -has_exact_match, -has_close_match) %>%
  left_join(tbl_geoscheme, by = c("label" = "unit")) %>%
  mutate(ahID = str_replace_all(id, "[.]", ""), .after = "id")

## rasterize simplified geometries
message(" --> rasterize administrative layers")
for(i in 1){ # 1:4

  message(" --> administrative level ", i)

  vct_temp <- st_read(dsn = paste0(dir_data_in, "gadm36_levels.gpkg"), layer = paste0("level", i-1))
  vct_temp <- vct_temp[!st_is_empty(vct_temp), , drop = FALSE]

  vct_temp %>% st_cast("MULTIPOLYGON") %>%
    full_join(tbl_countries, by = "NAME_0") %>% # need to fix tbl_countries, or switch it out with a tbl_admin2 or so when rasterizing the other admin levels.
    filter(!is.na(id)) %>%
    arrange(id) %>%
    st_write(dsn = paste0(dir_data_wip, "gadm_temp.gpkg"), delete_layer = TRUE)

  gdalUtilities::gdal_rasterize(src_datasource = paste0(dir_data_wip, "gadm_temp.gpkg"),
                                dst_filename = str_replace(path_ahID, "LVL", as.character(i)),
                                a = "ahID", at = TRUE,
                                te = ext(model_info$parameters$extent)[c(1, 3, 2, 4)], tr = c(0.00833333333333333, 0.00833333333333333),
                                co = c("COMPRESS=DEFLATE", "ZLEVEL=9"))

}
file.remove(paste0(dir_data_wip, "gadm_temp.gpkg"))


# write output ----
#

# beep(sound = 10)
message("\n     ... done")
