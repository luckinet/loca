# author and date of creation ----
#
# Steffen Ehrmann, 21.02.2022

# script description ----
#
# This script loads model covariates and meta-data to classify models for
# landuse groups, landuse and commodities and to predict each of them into a
# a raster of class probabilities.
message("\n---- parameter estimation ----")


# script arguments ----
#
assertList(x = profile, len = 12)                  # ensure that profile is set
assertList(x = files)


# load metadata ----
#
targetCov <- c("luckinetID", "x", "y", "year",
               profile$suitability_predictors)


# load data ----
#
# bias_freqArea <- readRDS(file = files$bias_freqArea)
covariates <- readRDS(file = files$covariates_values)
allConcepts <- readRDS(file = files$ids_all)


# data processing ----
#
# prepare modelling data
message(" --> manage covariate data and biases")
message("     drivers: ", paste0(profile$suitability_predictors, collapse = "\n              "), "\n")

toModel <- covariates %>%
  filter(if_all(all_of(targetCov), ~ !is.na(.))) %>%
  select(all_of(targetCov)) %>%
  distinct() %>%
  left_join(allConcepts, by = "luckinetID") %>%
  # left_join(bias_freqArea, by = "luckinetID") %>%
  # mutate(response = as.factor(`landuse group`)) %>%
  select(-x, -y, -year, -class, -luckinetID)



message(" --> response: landuse groups")
message("     train random forest")

message("     validate parameters")

message("     predict output rasters")




# luGModel <- toModel %>%
#   left_join(allConcepts %>% select(term, luckinetID), by = c("landuse group" = "term")) %>%
#   select(-landuse, -`landuse group`, -term) %>%
#   filter(!is.na(luckinetID))
#
#
# # Run model with target covariates
# model <- multinom(luckinetID ~ .,
#                   # weights = freqArea_bias,
#                   data = luGModel)
#
# # Obtain raw (untransformed) coefficients from the model
# mycoefs <- summary(model)$coefficients
#
# # Obtain the class probabilities
# levels <- unique(luGModel$luckinetID)
# allNames <- c(rownames(mycoefs), levels[!levels %in% rownames(mycoefs)])
# allCoefs <- rbind(mycoefs, rep(0, dim(mycoefs)[2]))
# rownames(allCoefs) <- allNames
# luGCoefs <- as.data.frame(allCoefs) %>%
#   rownames_to_column(var = " ")

message(" --> response: landuse")
message("     train random forest")

message("     validate parameters")

message("     predict output rasters")

# luModel <- toModel %>%
#   left_join(allConcepts %>% select(term, luckinetID), by = c("landuse" = "term")) %>%
#   select(-landuse, -`landuse group`, -term) %>%
#   filter(!is.na(luckinetID))
#
#
# # Run model with target covariates
# model <- multinom(luckinetID ~ .,
#                   # weights = freqArea_bias,
#                   data = luModel)
#
# # Obtain raw (untransformed) coefficients from the model
# mycoefs <- summary(model)$coefficients
#
# # Obtain the class probabilities
# levels <- unique(luModel$luckinetID)
# allNames <- c(rownames(mycoefs), levels[!levels %in% rownames(mycoefs)])
# allCoefs <- rbind(mycoefs, rep(0, dim(mycoefs)[2]))
# rownames(allCoefs) <- allNames
# luCoefs <- as.data.frame(allCoefs) %>%
#   rownames_to_column(var = " ")

message(" --> response: commodities")
message("     train random forest")

message("     validate parameters")

message("     predict output rasters")

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


# write output ----
#
# write_csv(x = luGCoefs, file = files$suitLUGcoef)
# write_csv(x = luCoefs, file = files$suitLUcoef)
# write_csv(x = commCoefs, file = files$suitCOMMcoef)

message("---- done ----")


# Hello Steff,
#
# Just a quick note on RFs. They are sensitive to class imbalance which usually is
# the case in our domains. A very neat trick is to make the sample that goes into
# each of the trees of the forest forcefully balanced. I usually set it to be
# around 0.7 of the smallest class you got. So something like

samp_size <- floor(0.7 * min(table(train_table$y)))

# where y is your vector of classes, also y has to be a factor so that randomForest
# will know its a classification task.

rf <- randomForest(y = as.factor(train_table$y),
                   x = tain_table[, not_y],
                   ntree = 1000,
                   importance = TRUE,
                   sampsize = rep(samp_size, length(unique(train_table$y))))

# with that last line you tell the model it will make trees with the same amount of
# examples of each class.
#
# The randomForest package is not the fastest but it allows you to do this trick
# which in general has worked for me like a charm. There are others like ranger
# that are way faster but will sometimes prove problematic with this class imbalance
# stuff. If this doesnt work you can move to XGBoost which is blazing fast and
# super accurate but a tad more difficult to specify and optimize. RF usually
# works great with the default hyperparameters.
#
# By the way random forest estimate accuracy on the fly with a cool technique
# (out of the box estimation) so you can just do

rf$confusion

# to get a feel if ur model has promise, straightaway after training!
#
#   Cheers!

predict(model, newdata, type = "probability") # this should be a table with as many columns as there are classes

Outdf <- data.frame(x= original$x, y = original$y , predicted)
Coordinates (outdf ) =~ x + y
Gridded (outdf) = true
Outdf <- raster(outdf) # Need to set the projection there



