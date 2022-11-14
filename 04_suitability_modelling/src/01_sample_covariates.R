# script arguments ----
#
message("\n---- sample covariates ----")

assertList(x = profile, len = 12)
assertList(x = files)


# load data ----
#
message(" --> load occurrence locations")
points <- read_rds(file = files$points)


# data processing ----
#
extracted_features <- NULL
for(i in seq_along(profile$years)){

  theYear <- profile$years[i]
  message(" --> sample covariates for '", theYear, "'")


  message("     ... prepare occurrence data")
  tempOcc <- points %>%
    filter(year == theYear)
  tempOcc <- vect(tempOcc,
                  geom = ,    which column in the point data stores the geometries?
                  crs = "+proj=longlat +datum=WGS84")

  class_counts <- tempOcc %>%
    group_by() %>%  insert the correct column here
    summarise(freq = n())
  class_counts_100 <- class_counts %>%
    filter(freq < 100)

  clean_occ <- tempOcc[!as.character(tempOcc$LC1_orig) %in% as.character(class_counts_100$LC1_orig),]


  message("     ... prepare features")
  features <- rast(files$predictors)


  message("     ... extract features")
  extracted_features <- terra::extract(x = features, y = clean_occ, fun = ) %>%  probably gonna need a custom function here
    as_tibble() %>%
    mutate(year = theYear) %>%
    bind_rows(extracted_features, .)

}


# first, build a table of the covariate metadata
# covMeta <- get_meta_gridDB(path = profile$dir, covariates = profile$suitability_predictors)
# assertNumeric(x = unique(covMeta$xRes), len = 1)
# assertNumeric(x = unique(covMeta$yRes), len = 1)

# then bring point data into correct form ...
# coords <- as_tibble(st_coordinates(points))
# colnames(coords) <- tolower(colnames(coords))
# samples <- points %>%
#   st_drop_geometry() %>%
#   bind_cols(coords)

# ... and sample
# message(" --> sample covariates")
# covariates <- sample_grid(samples = samples, grid_meta = covMeta)


# write output ----
#
# saveRDS(object = covMeta, file = files$covariates_meta)
saveRDS(object = extracted_features, file = files$covariates_values)

message("\n---- done ----")
