# // Author and Date: Rhonda Ridley 31 July 2021  20137

# Libraries
library(sf)
library(sp)
library(tidyverse)
library(rgeos)
library(readxl)
library(stringi)

# Directory
db_wd<-'~/data/MAS-group-share/01_projects/LUCKINet/01_data/point_data/incoming/landcover_validation_datasets/Already_assessed/Rhonda_Ridley/Alemayehu_2019'
border_wd<-'~/data/MAS-group-share/04_personal/Caterina/Chapter_01/00_data/03_countryBorders'

# Data input
setwd(db_wd)
db<-read_excel('attachment.xlsx', col_names = TRUE)

# Extra data 
setwd(border_wd)
border<-read_sf('leve0simple.sqlite')

tmp = st_make_valid(border) # attempt to correct error Evaluation error: Found 22 features with invalid spherical geometry.
st_is_valid(tmp)
border<-tmp[-c(40,73,92,143,190,235),] # drop the 6 that can't be repaired

##################################################################################################################################################
##################################################################################################################################################
################################# MODULE 1 #######################################################################################################
##################################################################################################################################################
##################################################################################################################################################
#data structuring, reduce data set

part1<-db[c(1:21),c(1:4)]
names(part1)[1]<-'number'
names(part1)[2]<-'northing'
names(part1)[3]<-'easting'
names(part1)[4]<-'lc1_orig'

part2<-db[c(2:21),c(5:8)]
names(part2)[1]<-'number' #need same column names to join with other parts 
names(part2)[2]<-'northing'
names(part2)[3]<-'easting'
names(part2)[4]<-'lc1_orig'

part3<-db[c(23:42),c(1:4)]
names(part3)[1]<-'number' #need same column names to join with other parts 
names(part3)[2]<-'northing'
names(part3)[3]<-'easting'
names(part3)[4]<-'lc1_orig'

part4<-db[c(23:42),c(5:8)]
names(part4)[1]<-'number' #need same column names to join with other parts 
names(part4)[2]<-'northing'
names(part4)[3]<-'easting'
names(part4)[4]<-'lc1_orig'

db<-rbind(part1,part2,part3,part4)
db<-db[-c(21, 41, 61, 81),] #remove header rows

#UTM Zone 37 #pg 4 of publication
db<-db %>% drop_na(easting,northing)

db$northing<-stri_replace_all_regex(db$northing, "[m N]", "")
db$northing<-as.numeric(db$northing)

db$easting<-stri_replace_all_regex(db$easting, "[m E]", "")
db$easting<-as.numeric(db$easting)

db_sp<-st_as_sf(db, 
                coords = c("easting", "northing"),
                crs = 20137) #epsg code for Ethiopia
db <- st_transform(db_sp, crs = 4326)

db_spatial <- as (db, 'Spatial')
db <- spTransform(db, CRS(latlong))
easting<-db$easting
northing<-db$northing
#convert easting and northing
ConvertCoordinates <- function(easting,northing) {
  out = cbind(easting,northing)
  mask = !is.na(easting)
  sp <-  sp::spTransform(sp::SpatialPoints(list(easting[mask],northing[mask]),proj4string=sp::CRS(bng)),sp::CRS(wgs84))
  out[mask,]=sp@coords
  out
}


#names(db)[2]<-'long'
#names(db)[3]<-'lat'

db$lc2_orig<-NA 
db$lc3_orig<-NA

db$lc1_orig_def<-NA
db$lc2_orig_def<-NA
db$lc3_orig_def<-NA
db$lc1_orig_ont<-'Globeland30' #extracted from abstract page 6 in publication: Remote Sens. 2019, 11, 554; doi:10.3390/rs11050554 
db$lc2_orig_ont<-NA
db$lc3_orig_ont<-NA

db$lu1_orig<-NA
db$lu2_orig<-NA
db$lu1_orig_def<-NA
db$lu2_orig_def<-NA
db$lu1_orig_ont<-NA
db$lu2_orig_ont<-NA

db$sample_type<-'field work & visual interpretation' # pg 3 publication
db$data_collector<-'expert' 
db$country_ext<-'NO'
db$year<-2017 # email correspondence
db$day<-NA
db$month<-NA
db$spatial_unit_size<-30 # #pg 4 of publication
db$spatial_info<-'provided'
db$purpose<-'LULC class monitoring' #publication pg 1
db$database_ID<-'00_26'

##################################################################################################################################################
##################################################################################################################################################
################################# MODULE 2 #######################################################################################################
##################################################################################################################################################
##################################################################################################################################################
## 1) CLEANING DATA OUT OF MAINLAND. Geo-cleaning of coordinates outside country borders.
db_sp<-st_as_sf(db, # the function st_as_sf is used to transform the database in a spatial object, lat, long to spatial geometry
                coords = c("long", "lat"),
                crs = 4326) # question, not stated in publication, confirm this with the authors.

int <- sf::st_intersects(db_sp , border) # st_intersects is used to find the intersection between each point and the country borders
x<-sapply(int, function(x) length(x) == 0) # 0 means that there is not intersection with any country border
unique(x)

int_2 <- sf::st_intersects(db_sp, border) # doing the intersection again for those points (at the country borders) intersecting 2 countries
x<-sapply(int_2, function(x) length(x) == 2) # 2 means that there are two countries intersected
#y<-which(x==TRUE)

int_3 = lapply(int_2, function(l) l[[1]]) # selecting the 1st of the 2 countries intersected

db_sp$country <- border$name_0[unlist(int_3)] # extracting the country name from the intersection
db_sp$iso3 <- border$gid_0[unlist(int_3)] # extracting the iso3 from the intersection
unique(db_sp$iso3) # unique list of countries

## 2) CLEANING COUNTRY INTERSECTION. Checking if the country extrapolated from coordinates and region reported makes sense.
#x<-as.data.frame(db_sp[,c(1,28)])
#x<-x[,1:2]


# 3) CLEANING CLASS. 
#no cover values provided 
##################################################################################################################################################
##################################################################################################################################################
################################# MODULE 3 #######################################################################################################
##################################################################################################################################################
##################################################################################################################################################
# 1) classification of land cover of interest

unique(db$lc1_orig) #get list of lc1_orig

db_sp$lc1_label <- db_sp$lc1_orig #copy orig LC to LC label column

db_sp$lc1_label[db_sp$lc1_orig=='Forest Land'] <- 'forest' #change lc label 
db_sp$lc1_label[db_sp$lc1_orig=='Grass Land'] <- 'grassland' #change lc label
db_sp$lc1_label[db_sp$lc1_orig=='Wetland'] <- 'wetland' #change lc label
db_sp$lc1_label[db_sp$lc1_orig=='Cultivation  Land'] <- 'cropland' #change lc label
db_sp$lc1_label[db_sp$lc1_orig=='HG Agroforestry/Settlement'] <- 'urban and built-up land' #change lc label

unique(db_sp$lc1_label)

db_sp$lc2_label<-NA
db_sp$lc3_label<-NA

##################################################################################################################################################
##################################################################################################################################################
################################# MODULE 4 #######################################################################################################
##################################################################################################################################################
##################################################################################################################################################
# 1) Transforming back from spatial object to database
coordinates<-as.data.frame(st_coordinates(db_sp))
names(coordinates)[1]<-'long'
names(coordinates)[2]<-'lat'
db_sp<-cbind.data.frame(db_sp,coordinates) # use cbind.data.frame not cbind and as.data.frame
db_sp<-db_sp[,c(1,2,4:34)] # drop geometry column

# 2) Standardizing data type
db_sp$long<-as.numeric(db_sp$long)
db_sp$lat<-as.numeric(db_sp$lat)
db_sp$country<-as.character(db_sp$country)
db_sp$iso3<-as.character(db_sp$iso3)
db_sp$country_ext<-as.character(db_sp$country_ext)
db_sp$lc1_orig<-as.character(db_sp$lc1_orig)
db_sp$lc2_orig<-as.character(db_sp$lc2_orig)
db_sp$lc3_orig<-as.character(db_sp$lc3_orig)
db_sp$lc1_label<-as.character(db_sp$lc1_label)
db_sp$lc2_label<-as.character(db_sp$lc2_label)
db_sp$lc3_label<-as.character(db_sp$lc3_label)
db_sp$lc1_orig_def<-as.character(db_sp$lc1_orig_def)
db_sp$lc2_orig_def<-as.character(db_sp$lc2_orig_def)
db_sp$lc3_orig_def<-as.character(db_sp$lc3_orig_def)
db_sp$lc1_orig_ont<-as.character(db_sp$lc1_orig_ont)
db_sp$lc2_orig_ont<-as.character(db_sp$lc2_orig_ont)
db_sp$lc3_orig_ont<-as.character(db_sp$lc3_orig_ont)
db_sp$lu1_orig<-as.character(db_sp$lu1_orig)
db_sp$lu2_orig<-as.character(db_sp$lu2_orig)
db_sp$lu1_orig_def<-as.character(db_sp$lu1_orig_def)
db_sp$lu2_orig_def<-as.character(db_sp$lu2_orig_def)
db_sp$lu1_orig_ont<-as.character(db_sp$lu1_orig_ont)
db_sp$lu2_orig_ont<-as.character(db_sp$lu2_orig_ont)
db_sp$spatial_unit_size<-as.numeric(db_sp$spatial_unit_size) # was spatial_unit
db_sp$spatial_info<-as.character(db_sp$spatial_info)
db_sp$day<-as.character(db_sp$day)
db_sp$month<-as.character(db_sp$month)
db_sp$year<-as.character(db_sp$year)
db_sp$sample_type<-as.character(db_sp$sample_type)
db_sp$data_collector<-as.character(db_sp$data_collector)
db_sp$purpose<-as.character(db_sp$purpose)
db_sp$database_ID<-as.character(db_sp$database_ID)

#re-ordering columns by name
db_sp<-db_sp[,c("long", "lat", "country", "iso3", "country_ext", "lc1_orig", "lc2_orig", "lc3_orig", "lc1_label", "lc2_label", "lc3_label", "lc1_orig_def", "lc2_orig_def", "lc3_orig_def", "lc1_orig_ont", "lc2_orig_ont", "lc3_orig_ont", "lu1_orig", "lu2_orig", "lu1_orig_def", "lu2_orig_def", "lu1_orig_ont", "lu2_orig_ont", "spatial_unit_size", "spatial_info", "day", "month", "year", "sample_type", "data_collector", "purpose", "database_ID")] 

# Data output
setwd(db_wd)
write.csv(db_sp,'Alemayehu_2019_01step.csv',row.names = F)

