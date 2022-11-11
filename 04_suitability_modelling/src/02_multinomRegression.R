# author and date of creation ----
#
# Steffen Ehrmann, 19.01.2021; based on code writen by Marina Jimenez and Ruben
# Remelgado


# script description ----
#
# This script computes the ratio between point frequency and average area of
# commodities to derive an inverse weight per commodity.
message("\n---- calculate biases ----")


# script arguments ----
#
cropProp_py <- paste0(modlDir, 'src/99_cropProbabilities.py')
assertList(x = profile, len = 12)                  # ensure that profile is set
assertList(x = files)


# command line arguments ----
#
# option_list <- list(
#   make_option(c("-y", "--year"), type = "numeric", default = NULL,
#               help = "year for which to map probabilities", metavar = "character"),
#   make_option(c("-d", "--drivers_vrt"), type = "logical", default = FALSE,
#               help = "whether or not to produce a vrt and subset of the included drivers", metavar = "character")
# )

# opt_parser <- OptionParser(option_list = option_list)
# args <- parse_args(opt_parser)
# args$year <- 2000


# load metadata ----
#
theYears <- profile$years[1]
targetCov <- c("luckinetID", "x", "y", "year",
               profile$suitability_predictors)


# load data ----
#
# points <- readRDS(file = paste0(runDir, "tables/points.rds"))
# census_comm <- readRDS(file = paste0(runDir, "tables/census_comm.rds"))
# census_luC <- readRDS(file = paste0(runDir, "tables/census_lu_cat.rds"))
# census_commC <- readRDS(file = paste0(runDir, "tables/census_comm_cat.rds"))
points <- readRDS(file = files$points)
census <- readRDS(file = files$census)

geom1 <- pull_geometries(path = paste0(dataDir, "areal_data/", profile$arealDB_dir),
                         nation = profile$arealDB_extent,
                         layer = "level_1")

geom2 <- pull_geometries(path = paste0(dataDir, "areal_data/", profile$arealDB_dir),
                         nation = profile$arealDB_extent,
                         layer = "level_2")

geom3 <- pull_geometries(path = paste0(dataDir, "areal_data/", profile$arealDB_dir),
                         nation = profile$arealDB_extent,
                         layer = "level_3")

# bias_freqArea <- readRDS(file = files$bias_freqArea)
covariates <- readRDS(file = files$covariates_values)
allConcepts <- readRDS(file = files$ids_all)

covMeta <- readRDS(file = files$covariates_meta)
targetCov <- covMeta %>%
  distinct(data_id) %>%
  filter(data_id %in% profile$suitability_predictors) %>%
  pull(data_id)

bbox_tiles <- st_read(dsn = files$geomTiles)


# data processing ----
#
# message("\n ---- aggregating data ----")
# pointsCat <- points %>%
#   left_join(landuse, by = "category") %>%
#   distinct(year, ahID, term, responseID, geom)
# pointsComm <- points %>%
#   left_join(ids_commodities, by = "term") %>%
#   distinct(year, ahID, term, responseID, geom)
# censusCat <- census_luC %>%
#   left_join(landuse, by = "category")
# censusComm <- census_comm %>%
#   rename(responseID = luckinetID) %>%
#   select(-class, -landuse, -category)

message(" --> determine frequency/area bias (still implement)")
# derive point/area ratio per commodity and territory (area bias)
#
# ---- landuse categories
#
points_in_geom1 <- st_intersects(x = geom1, y = points)
biasCat <- map(.x = unique(geom1$ahID), .f = function(ix){

  # subset census and point data to the current territory
  tempCensus <- census %>%
    filter(ahID == ix)
  geoIDs <- tempCensus %>%
    distinct(geoID) %>%
    pull(geoID)
  if(!length(geoIDs) > 0){
    return(tibble(nation = character(), ahID = character(), ahLevel = double(), responseID = character(), mean_area = double(), freq_points = integer(), ratio = double(), areaBias = double()))
  }
  assertChoice(x = geoIDs, choices = unique(geom1$geoID))
  pointSub <- points_in_geom1[geom1$ahID == ix & geom1$geoID == geoIDs]
  if(!length(pointSub) > 0){
    return(tibble(nation = character(), ahID = character(), ahLevel = double(), responseID = character(), mean_area = double(), freq_points = integer(), ratio = double(), areaBias = double()))
  }
  tempPoints <- points[pointSub[[1]],]

  # aggregate census and point data by landuse_group
#   tempCensus_agg <- tempCensus %>%
#     group_by(nation, ahID, ahLevel, responseID) %>%
#     summarise(mean_area = mean(area, na.rm = T), .groups = "keep") %>%
#     ungroup()
#   tempPoints_agg <- tempPoints %>%
#     st_drop_geometry() %>%
#     group_by(responseID) %>%
#     summarise(freq_points = n()) %>%
#     ungroup()
#
#   # join and calculate ratio
#   out <- tempCensus_agg %>%
#     full_join(tempPoints_agg, by = "responseID") %>%
#     mutate(ratio = freq_points/mean_area,
#            areaBias = ratio * (1 / min(ratio, na.rm = T)),
#            areaBias = 1 / areaBias) %>%
#     select(nation, ahID, ahLevel, responseID, everything())
#
})
# biasCat <- bind_rows(biasCat) %>%
#   filter_at(.vars = c("mean_area", "freq_points"),
#             .vars_predicate = all_vars(!is.na(.)))
bias_freqArea <- tibble(responseID = unique(points$luckinetID),
                        freqArea_bias = 1)

# ---- commodities
#
# points_in_geom3 <- st_intersects(x = geom3_in, y = pointsComm)
# biasComm <- map(.x = unique(geom3_in$ahID), .f = function(ix){
#
#   # subset census and point data to the current territory
#   tempCensus <- censusComm %>%
#     filter(ahID == ix)
#   geoIDs <- tempCensus %>%
#     distinct(geoID) %>%
#     pull(geoID)
#   if(!length(geoIDs) > 0){
#     return(tibble(nation = character(), ahID = character(), ahLevel = double(), responseID = character(), mean_area = double(), freq_points = integer(), ratio = double(), areaBias = double()))
#   }
#   assertChoice(x = geoIDs, choices = unique(geom3_in$geoID))
#   pointSub <- points_in_geom3[geom3_in$ahID == ix & geom3_in$geoID == geoIDs]
#   if(!length(pointSub) > 0){
#     return(tibble(nation = character(), ahID = character(), ahLevel = double(), responseID = character(), mean_area = double(), freq_points = integer(), ratio = double(), areaBias = double()))
#   }
#   tempPoints <- pointsComm[pointSub[[1]],]
#
#   # aggregate census and point data by landuse_group
#   tempCensus_agg <- tempCensus %>%
#     group_by(nation, ahID, ahLevel, responseID) %>%
#     summarise(mean_area = mean(harvested, na.rm = T), .groups = "keep") %>%
#     ungroup()
#   tempPoints_agg <- tempPoints %>%
#     st_drop_geometry() %>%
#     group_by(responseID) %>%
#     summarise(freq_points = n()) %>%
#     ungroup()
#
#   # join and calculate ratio
#   out <- tempCensus_agg %>%
#     full_join(tempPoints_agg, by = "responseID") %>%
#     mutate(ratio = freq_points/mean_area,
#            areaBias = ratio * (1 / min(ratio, na.rm = T)),
#            areaBias = 1 / areaBias) %>%
#     select(nation, ahID, ahLevel, responseID, everything())
#
# })
# biasComm <- bind_rows(biasComm) %>%
#   filter_at(.vars = c("mean_area", "freq_points"),
#             .vars_predicate = all_vars(!is.na(.)))



message(" --> determine distance bias (still implement)")
# potentially also implement distance weighting here (distance bias)


message("\n---- parameter estimation ----")
# This script loads model covariates, meta-data on covariates and biases such as
# evidence deviation or spatial distances (as model weights), to estimate model
# coefficients and store the results.

# prepare modelling data
message(" --> manage covariate data and biases")
toModel <- covariates %>%
  filter(if_all(all_of(targetCov), ~ !is.na(.))) %>%
  select(all_of(targetCov)) %>%
  distinct() %>%
  left_join(allConcepts, by = "luckinetID") %>%
  # left_join(bias_freqArea, by = "luckinetID") %>%
  # mutate(response = as.factor(`landuse group`)) %>%
  select(-x, -y, -year, -class, -luckinetID)


message(" --> run estimation model")
message("     drivers: ", paste0(profile$suitability_predictors, collapse = "\n              "), "\n")
message("     response: landuse groups")
luGModel <- toModel %>%
  left_join(allConcepts %>% select(term, luckinetID), by = c("landuse group" = "term")) %>%
  select(-landuse, -`landuse group`, -term) %>%
  filter(!is.na(luckinetID))


# Run model with target covariates
model <- multinom(luckinetID ~ .,
                  # weights = freqArea_bias,
                  data = luGModel)

# Obtain raw (untransformed) coefficients from the model
mycoefs <- summary(model)$coefficients

# Obtain the class probabilities
levels <- unique(luGModel$luckinetID)
allNames <- c(rownames(mycoefs), levels[!levels %in% rownames(mycoefs)])
allCoefs <- rbind(mycoefs, rep(0, dim(mycoefs)[2]))
rownames(allCoefs) <- allNames
luGCoefs <- as.data.frame(allCoefs) %>%
  rownames_to_column(var = " ")

message("     response: landuse")
luModel <- toModel %>%
  left_join(allConcepts %>% select(term, luckinetID), by = c("landuse" = "term")) %>%
  select(-landuse, -`landuse group`, -term) %>%
  filter(!is.na(luckinetID))


# Run model with target covariates
model <- multinom(luckinetID ~ .,
                  # weights = freqArea_bias,
                  data = luModel)

# Obtain raw (untransformed) coefficients from the model
mycoefs <- summary(model)$coefficients

# Obtain the class probabilities
levels <- unique(luModel$luckinetID)
allNames <- c(rownames(mycoefs), levels[!levels %in% rownames(mycoefs)])
allCoefs <- rbind(mycoefs, rep(0, dim(mycoefs)[2]))
rownames(allCoefs) <- allNames
luCoefs <- as.data.frame(allCoefs) %>%
  rownames_to_column(var = " ")

message("     response: commodities (still implement)")
# commModel <- toModel %>%
#   left_join(allConcepts %>% select(term, luckinetID), by = c("landuse group" = "term")) %>%
#   select(-landuse, -`landuse group`, -term) %>%
#   filter(!is.na(luckinetID))
#
#
# # Run model with target covariates
# model <- multinom(luckinetID ~ .,
#                   # weights = freqArea_bias,
#                   data = commModel)
#
# # Obtain raw (untransformed) coefficients from the model
# mycoefs <- summary(model)$coefficients
#
# # Obtain the class probabilities
# levels <- unique(luGModel$luckinetID)
# allNames <- c(rownames(mycoefs), levels[!levels %in% rownames(mycoefs)])
# allCoefs <- rbind(mycoefs, rep(0, dim(mycoefs)[2]))
# rownames(allCoefs) <- allNames
# commCoefs <- as.data.frame(mycoefs) %>%
#   rownames_to_column(var = " ")

message("\n---- model prediction ----")
# This script loads model meta-data, extracts the relavant information for the
# model run of a particular year (paths to gridded layers and spatial extent of
# the model) and calls the python script 'cropProbabilities.py' based on those
# information. Eventually, it offers the option to extract gridded objects of
# the covariates, for visual inspection of the model results.

for(i in seq_along(theYears)){

  message(" --> prepare covariates")
  thisYear <- theYears[i]
  targetPaths <- map_chr(.x = seq_along(targetCov), .f = function(ix){
    temp <- covMeta %>%
      filter(data_id %in% targetCov[ix]) %>%
      filter(year %in% thisYear)
    if(dim(temp)[1] > 1){
      stop("too many drivers selected!")
    } else if(dim(temp)[1] < 1){
      out <- covMeta %>%
        filter(data_id %in% targetCov[ix]) %>%
        mutate(year_dist = abs(year - thisYear)) %>%
        group_by(data_id) %>%
        filter(year_dist == min(year_dist)) %>%
        select(-year_dist) %>%
        pull(path)
    } else {
      out <- temp %>% pull(path)
    }
    return(out)
  })

  write_csv(x = tibble(path = targetPaths), file = files$covariates_paths)

  # ... looping through tiles
  message(" --> run prediction model")
  targets <- bbox_tiles$target
  for(j in seq_along(targets)){

    if(!targets[i]){
      next
    }
    message( paste0("     --> tile ", j, " ..."))

    tempBbox <- getPoints(bbox_tiles) %>%
      filter(fid == j)
    tempBbox <- paste0(c(min(tempBbox$x), min(tempBbox$y), max(tempBbox$x), max(tempBbox$y)),
                       collapse = " ")

    # call for python function cropProbabilities.py, which builds the map (runs
    # model prediction)
    message("     landuse groups")
    system(paste0('python ', cropProp_py,
                  ' -e ', tempBbox,
                  ' -c ', files$suitLUGcoef,
                  ' -v ', files$covariates_paths,
                  ' -i ', paste0(thisYear, "_", profile$name, "_", profile$version, "_", j),
                  ' ', paste0(profile$dir, "tiles/")))

    message("     landuse")
    system(paste0('python ', cropProp_py,
                  ' -e ', tempBbox,
                  ' -c ', files$suitLUcoef,
                  ' -v ', files$covariates_paths,
                  ' -i ', paste0(thisYear, "_", profile$name, "_", profile$version, "_", j),
                  ' ', paste0(profile$dir, "tiles/")))

    message("     commodities (still implement)")
    # system(paste0('python ', cropProp_py,
    #               ' -e ', tempBbox,
    #               ' -c ', files$suitCOMMcoef,
    #               ' -v ', files$covariates_paths,
    #               ' -i ', paste0(thisYear, "_", profile$name, "_", profile$version, "_", j),
    #               ' ', paste0(profile$dir, "tiles/")))

  }

}

# write output ----
#
saveRDS(object = bias_freqArea, file = files$bias_freqArea)
# saveRDS(object = biasComm,
#         file = paste0(runDir, "suitability/bias_comm.rds"))

write_csv(x = luGCoefs, file = files$suitLUGcoef)
write_csv(x = luCoefs, file = files$suitLUcoef)
# write_csv(x = commCoefs, file = files$suitCOMMcoef)

message("\n---- done ----")



######## old stuff

# ## ---------- This script shows how to run the multinomial model in 1 archetype ----------##
# # I show how to run the multinomial model: 1. without weights,  2. with weights 3. with covariates
# ## Libraries
# library(nnet) # package to run the multinomial model
#
# ## My data paths
# archetypes <- "I:/MAS/04_personal/Marina/alpha_version/4.Input/01_samples/"
# covariates <- "I:/MAS/04_personal/Marina/alpha_version/4.Input/02_model_covariates/"
#
# # Read data
# # Read the points for 1 archetype
# myarchetype <- read.csv(paste0(archetypes,"samples_11001001.csv"))
# # Read the attached covariates for that archetype
# mycovariate <- read.csv(paste0(covariates, "model_covariates_11001001.csv"))
# # Read the attached weights to the archetype from the census data
# # I do not have access to the weights yet, so I will make them up
# # These weights have to be replaced for the real ones
# n_commodities <- dim(table(myarchetype$target_census_alpha200709))
# proportions_census <- c(0.2, 0.1, 0.15, 0.3, 0.05, 0.025, 0.175)
# names(proportions_census) <- names(table(myarchetype$target_census_alpha200709))
# #Check they sum to 1
# sum(proportions_census)
#
# #Obtain the point proportions: how much each commodity contributes to the total sum of points
# sum_weights_points <-sum(table(myarchetype$target_census_alpha200709))
# proportions_points <-table(myarchetype$target_census_alpha200709)/sum_weights_points
# #Check they sum up to 1
# sum(proportions_points)
#
# ######################## Models #######################
#
# # ____________________________________________________#
#
# ##### 1. Run multinomial model without weights
# model_out <-multinom(target_census_alpha200709~1, data=myarchetype)
# # Obtain raw (untransformed) coefficients from the model
# summary(model_out)$coefficients
# # Obtain the class probabilities
# fitted(model_out)[1,]
#
# # Alternative way to obtain the class probabilities
# coeffs_out <- as.matrix(summary(model_out)$coefficients)
# coeffs_out <- rbind(coeffs_out,0)
# numerator_out <- exp(coeffs_out)
# denominator_out <- colSums(numerator_out)
# # This probs match the ones obtained from using the fitted function, fitted() in  model_out
# prob_mat_out<- t(t(numerator_out)/denominator_out)
# prob_mat_out # Note the probability without a name is for the crop that was used as the base, in this case barley
#
#
# # ____________________________________________________#
#
# ##### 2. Run multinomial model with weights
# # Calculate the weights that has to go into the model
# myweight <- proportions_census/proportions_points
# myarchetype$weight1 <- 0
# # Assign the weights to each point
# myarchetype$weight1 <- myweight[match(myarchetype$target_census_alpha200709,names(myweight) )]
# weight_vec <- as.numeric(myarchetype$weight1)
# # Run the model
# model_out_weight <-multinom(target_census_alpha200709~1, data=myarchetype, weights = weight_vec)
# # Obtain raw (untransformed) coefficients from the model
# summary(model_out_weight)$coefficients
# # Obtain the class probabilities
# fitted(model_out_weight)[1,]
#
#
#
# # Alternative way to obtain the class probabilities
# coeffs_out_weight <- as.matrix(summary(model_out_weight)$coefficients)
# coeffs_out_weight <- rbind(coeffs_out_weight,0)
# numerator_out_weight <- exp(coeffs_out_weight)
# denominator_out_weight <- colSums(numerator_out_weight)
# # This probs match the ones obtained from using the fitted function, fitted() in  model_out
# prob_mat_out_weight<- t(t(numerator_out_weight)/denominator_out_weight)
# prob_mat_out_weight # Note the probability without a name is for the crop that was used as the base, in this case barley
#
# # ____________________________________________________#
#
# ##### 3. Run multinomial model with covariates
# # Create a data frame with covariates and point data
# myarchetype_cov <- cbind(myarchetype$target_census_alpha200709, mycovariate)
# colnames(myarchetype_cov)[1] <- "target_census_alpha200709"
# # Run the model with 2 covariates: elevation mean and yearly total precipitation
# model_out_covs <-multinom(target_census_alpha200709~meElevation_30as.elevationMeanLand+CHELSA_pClimate.yearTotal, data=myarchetype_cov)
# # Obtain raw (untransformed) coefficients from the model
# summary(model_out_covs)$coefficients
# # Obtain the class probabilities
# fitted(model_out_covs)
#
#
# # Alternative way to obtain the class probabilities
# coeffs_out_covs <- as.matrix(summary(model_out_covs)$coefficients)
# coeffs_out_covs <- rbind(coeffs_out_covs,0)
# numerator_out_covs <- exp(coeffs_out_covs%*%t(variable.mat))
# # Add the covariate matrix
# variable.mat <- cbind(myarchetype_cov$meElevation_30as.elevationMeanLand,myarchetype_cov$CHELSA_pClimate.yearTotal)
# variable.mat <- cbind(1,variable.mat)
# denominator_out_covs <- colSums(numerator_out_covs)
# # This probs match the ones obtained from using the fitted function, fitted() in  model_out
# prob_mat_out_covs<- t(t(numerator_out_covs)/denominator_out_covs)
# prob_mat_out_covs # Note the probability without a name is for the crop that was used as the base, in this case barley
#
# # ____________________________________________________#
#
# ##### 4. Run multinomial model with covariates and weights
# # Calculate the weights that has to go into the model
# myweight <- proportions_census/proportions_points
# myarchetype$weight1 <- 0
# # Assign the weights to each point
# myarchetype$weight1 <- myweight[match(myarchetype$target_census_alpha200709,names(myweight) )]
# weight_vec <- as.numeric(myarchetype$weight1)
# # Create a data frame with covariates and point data
# myarchetype_cov <- cbind(myarchetype$target_census_alpha200709, mycovariate)
# colnames(myarchetype_cov)[1] <- "target_census_alpha200709"
# # Run the model with 2 covariates: elevation mean and yearly total precipitation
# model_out_covs <-multinom(target_census_alpha200709~meElevation_30as.elevationMeanLand+CHELSA_pClimate.yearTotal,
#                           data=myarchetype_cov, weights = weight_vec)
# # Obtain raw (untransformed) coefficients from the model
# summary(model_out_covs)$coefficients
# # Obtain the class probabilities
# fitted(model_out_covs)
#
#
#
#
# # Alternative way to obtain the class probabilities
# coeffs_out_covs <- as.matrix(summary(model_out_covs)$coefficients)
# coeffs_out_covs <- rbind(coeffs_out_covs,0)
# numerator_out_covs <- exp(coeffs_out_covs%*%t(variable.mat))
# # Add the covariate matrix
# variable.mat <- cbind(myarchetype_cov$meElevation_30as.elevationMeanLand,myarchetype_cov$CHELSA_pClimate.yearTotal)
# variable.mat <- cbind(1,variable.mat)
# denominator_out_covs <- colSums(numerator_out_covs)
# # This probs match the ones obtained from using the fitted function, fitted() in  model_out
# prob_mat_out_covs<- t(t(numerator_out_covs)/denominator_out_covs)
# prob_mat_out_covs # Note the probability without a name is for the crop that was used as the base, in this case barley
#
#
# # ____________________________________________________#
# ##. 5 Run multinomial model Weights for distance
#
# library(geodist)
# # Say our archetype is in Rio, and I obtained the centre lat and long for Rio
# Rio_lat <- rep(-22.908333,dim(myarchetype)[1])
# Rio_long <- rep(-43.196388,dim(myarchetype)[1])
#
# Rand_lat <-  rep(-22.66528,dim(myarchetype)[1])
# Rand_long <- rep(-63.65167,dim(myarchetype)[1])
# #Calculates the geodesic distance in km between two points, then I dibide by 1000 tO convert to Kms
# #my_dist <-geodist_vec(x1=myarchetype$x, y1=myarchetype$y, x2=Rand_long ,y2=Rand_lat, paired=TRUE,measure="geodesic")/1000
# my_dist <-geodist_vec(x1=myarchetype$x, y1=myarchetype$y, x2=Rio_long ,y2=Rio_lat, paired=TRUE,measure="geodesic")/1000
#
# # We want furhter apart points to count less than close points so we need some kind of inverse function like:
# stand_distance <- (my_dist-min(my_dist))/(max(my_dist)-min(my_dist))
# #Plot difference weighing functions
# plot(sort(1/my_dist), ylim=c(0,1), frame.plot = F, ylab=" Distance functions", xlab="", type="l")
# lines(sort(1/(1+my_dist)), col="blue")
# lines(sort(100/(100+my_dist)), col="green")
# lines(sort(1000/(1000+my_dist)), col="orange")
# lines(sort(10000/(10000+my_dist)), col="red")
# lines(sort(stand_distance),col="purple") # suggested function
# lines(sort(exp(-my_dist/7000)), col="pink")
# lines(sort(exp(-my_dist^2/7000^2)), col="brown")
#
#
# # Does not take individual point weights for some reason
# myarchetype$standard_distance <- stand_distance
# model_out_weight_dist <-multinom(target_census_alpha200709~1, data=myarchetype, weights =standard_distance)
# for(i in 1:7){
#   print(range(fitted(model_out_weight_dist)[,i]))
# }
#
#
# # Check if it is because it takes only the first 7 weights
# myweight <- stand_distance[1:7]
# names(myweight) <- names(table(myarchetype$target_census_alpha200709))
# myarchetype$weight1 <- 0
# # Assign the weights to each point
# myarchetype$weight1 <- myweight[match(myarchetype$target_census_alpha200709,names(myweight) )]
# weight_vec <- as.numeric(myarchetype$weight1)
# model_out_weight_dist1 <-multinom(target_census_alpha200709~1, data=myarchetype, weights =weight_vec)
# fitted(model_out_weight_dist1)[1:5,]
#
# #### Check if the average is what is taken
# test.weight <-aggregate(myarchetype$standard_distance, list(myarchetype$target_census_alpha200709), mean)
# test.weight <- test.weight[,2]
# names(test.weight) <- names(table(myarchetype$target_census_alpha200709))
# myarchetype$test.weight <- 0
# # Assign the weights to each point
# myarchetype$test.weight <- test.weight[match(myarchetype$target_census_alpha200709,names(test.weight) )]
# weight_vec1 <- as.numeric(myarchetype$test.weight)
# model_out_weight_dist2 <-multinom(target_census_alpha200709~1, data=myarchetype, weights =weight_vec1)
# fitted(model_out_weight_dist2)[1,]
# fitted(model_out_weight_dist1)[1,]
# fitted(model_out_weight_dist)[1,]
#
# # weights take the average weight for each class and applies it, rather than using a single weight for each point

