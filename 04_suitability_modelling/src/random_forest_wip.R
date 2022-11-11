
# occ <- read_rds("./data/LUCAS.rds") %>%
#   filter(!is.na(year)) %>%
#   filter(year == "18")
#
# occ_vect <- vect(occ,
#                  geom = c("x", "y"),
#                  crs = "+proj=longlat +datum=WGS84")
#
# class_counts <- occ %>%
#   group_by(LC1_orig) %>%
#   summarise(freq = n())
# class_counts_100 <- class_counts %>%
#   filter(freq < 100)
#
# occ_vect_clean <- occ_vect[!as.character(occ_vect$LC1_orig) %in% as.character(class_counts_100$LC1_orig),]

# make a tif of all raster features
# raster_files <- list.files("./data/", pattern = "\\.tif$",
#                           full.names = TRUE)
# features <- rast()
# for (i in 1:length(raster_files)){
#  rast <- rast(raster_files[i])
#  rast <- crop(rast, occ_vect_clean)
#  features <- c(features, rast)
# }
# writeRaster(features, "./data/feature_layers.tif", filetype = "GTiff", overwrite = TRUE)

# features <- rast("./data/feature_layers.tif")
# features_tbl <- values(features) %>%
#   as_tibble() %>%
#   mutate(across(.cols = everything(), .fns = ~ if_else(is.nan(.x), NA_real_, .x)))

# Training features extraction
# extracted_feats <- terra::extract(features, occ_vect_clean) %>%
#   as_tibble()

occ_vect_clean_tbl <- tibble(response = as.factor(occ_vect_clean$LC1_orig),
                             type = substr(occ_vect_clean$LC1_orig, 1L, 1L),
                             extracted_feats) %>%
  filter(complete.cases(occ_vect_clean_tbl))

smallest_strata <- floor(0.7*min(table(occ_vect_clean_tbl$type)))

occ_vect_clean_tbl$type <- substr(occ_vect_clean_tbl$response, 1L, 1L)

# Vanilla random forest classifier with stratified sample on class type (A, B, ...) ----
rf_strata <- randomForest(y = occ_vect_clean_tbl$response,
                          x = occ_vect_clean_tbl[, 4:ncol(occ_vect_clean_tbl)],
                          ntree = 500,
                          strata = occ_vect_clean_tbl$type,
                          sampsize = rep(smallest_strata, length(unique(occ_vect_clean_tbl$type))))

conf_matrix <- as.data.frame(rf_strata$confusion)

conf_matrix$class.error

# save(rf_strata, file = "./models/rf_strata_v2.RData")

outcome <- terra::predict(object = features, model = rf_strata, type = "prob", na.rm = TRUE)

writeRaster(x = outcome,
            filename = paste0(getwd(), "/outcome/rf_strata_v2.tif"),
            overwrite = TRUE,
            filetype = "Gtiff",
            datatype = "FLT4S")

zeit messen

# Vanilla random forest classifier with balanced trees ----
smallest_class <- floor(0.7*min(table(occ_vect_clean_tbl$response)))
rf_balanced <- randomForest(y = occ_vect_clean_tbl$response,
                         x = occ_vect_clean_tbl[,4:ncol(occ_vect_clean_tbl)],
                         ntree = 500,
                         sampsize = rep(smallest_class,66),
                         importance = TRUE) # The good importance measure is mean decrease in ACCURACY

conf_matrix <- as.data.frame(rf_balanced$confusion)

save(rf_balanced,file = "./models/rf_balanced_v2.RData")

varImpPlot(rf_balanced)

# Vanilla random forest classifier with trees weighted by census data

