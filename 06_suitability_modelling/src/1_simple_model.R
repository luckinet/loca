library("randomForest")
library("terra")
library("rgdal")
library("dplyr")
library("stringr")

train_data <- readRDS("./data/LUCAS.rds")
train_data <- data.frame(train_data)
train_data <- vect(train_data, geom=c("x", "y"), crs="+proj=longlat +datum=WGS84")

train_data <- train_data[train_data$year == "18",]
train_data <- train_data[!is.na(train_data$year),]

class_counts <- as.data.frame(table(train_data$LC1_orig))
class_counts_100 <- class_counts[class_counts$Freq<100,]

train_data_clean <- train_data[!as.character(train_data$LC1_orig) %in% as.character(class_counts_100$Var1),]

#raster_files <- list.files("./data/", pattern = "\\.tif$",
#                           full.names = TRUE)

#features <- rast()
#for (i in 1:length(raster_files)){
#  rast <- rast(raster_files[i])
#  rast <- crop(rast, train_data_clean)
#  features <- c(features, rast)
#}

#writeRaster(features, "./data/feature_layers.tif", filetype = "GTiff", overwrite = TRUE)

features <- rast("./data/feature_layers.tif")

# Training features extraction
extracted_feats <- extract(features, train_data_clean)

train_data_clean <- data.frame(response = as.factor(train_data_clean$LC1_orig),
                               type = substr(train_data_clean$LC1_orig,1L,1L),
                               extracted_feats)

train_data_clean <- train_data_clean[complete.cases(train_data_clean),]

smallest_strata <- floor(0.7*min(table(train_data_clean$type)))

train_data_clean$type <- substr(train_data_clean$response,1L,1L)

# Vanilla random forest classifier with stratified sample on class type (A, B, ...)
rf_model <- randomForest(y = train_data_clean$response,
                         x = train_data_clean[,4:ncol(train_data_clean)],
                         ntree = 500,
                         sampsize = rep(smallest_strata,8),
                         strata = train_data_clean$type)

conf_matrix <- as.data.frame(rf_model$confusion)

conf_matrix$class.error

save(rf_model,file = "./models/rf_strata_v1.RData")

# Vanilla random forest classifier with balanced trees
smallest_class <- floor(0.7*min(table(train_data_clean$response)))
rf_model <- randomForest(y = train_data_clean$response,
                         x = train_data_clean[,4:ncol(train_data_clean)],
                         ntree = 500,
                         sampsize = rep(smallest_class,66), importance = TRUE) # The good importance measure is mean decrease in ACCURACY

conf_matrix <- as.data.frame(rf_model$confusion)

- weights related to relative proportion of each class
- distance-bias: distance as variables and samples are spatially clsutered, chcnaceare that distiance is a used as threshold that prevents the presence outside of these clusters; its the saver bet to weigh individial points by distance  (enables global usage of data, if they are properly downweighed)
- sampling-bias: instead of relative proportion of each class (see above), use the sampling-bias develope earlier (check script in archive)

- area in the random forest model is actually not the area under the pixel, but the area of the sampling unit, and it doesn't indicate how much is available, but from which "scale" the sample is taken and where it occurs



save(rf_model,file = "./models/rf_balanced_v1.RData")


varImpPlot(rf_model)
