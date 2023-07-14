# script arguments ----
#
thisDataset <- "Camara2019"
description <- "These data sets include yearly maps of land cover classification for the state of Mato Grosso, Brazil, from 2001 (2000-09-01 to 2001-08-31) to 2017 (2016-09-01 to 2017-08-31), based on MODIS image time series (collection 6) at 250-meter spatial resolution (product MOD13Q1). Ground samples consisting of 1,892 time series with known labels are used as training data for a support vector machine classifier. We used the radial basis function kernel, with cost C=1 and gamma = 0.01086957. The classes include natural and human-transformed land areas, discriminating among different agricultural crops in state of land cover change maps for Mato Grosso State in Brazil. The results provide spatially explicit estimates of productivity increases in agriculture as well as the trade-offs between crop and pasture expansion."
url <- "https://doi.org/10.1594/PANGAEA.899706 https://"
licence <- "CC-BY-4.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Camara2019.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-09"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "training_dataset_v3.csv"))


# pre-process data ----
#
end <- data %>% select(-start_date) %>%
  rename(date = end_date)

start <- data %>% select(-end_date) %>%
  rename(date = start_date)

unique_data <- bind_rows(start, end)


# harmonise data ----
#
temp <- unique_data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Brazil",
    x = longitude,
    y = latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(date),
    externalID = id,
    externalValue = label,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = TRUE,
    sample_type = "field",
    collector = NA_character_,
    purpose = "map development") %>%
  select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
         externalID, externalValue, irrigated, presence,
         sample_type, collector, purpose, everything())


# harmonize with ontology ----
#
new_source(name = thisDataset,
           description = description,
           homepage = url,
           date = Sys.Date(),
           license = licence,
           ontology = ontoDir)

# matches <- tibble(new = c(unique(data$label)),
#                   old = c("Permanent grazing", "soybean", "soybean", "soybean", "cotton",
#                           "sunflower", NA, "Forests", "Fallow"))
out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")


# # from Caterina ----
# #
# library(sf)
# library(tidyverse)
#
# setwd("I:/MAS/01_data/LUCKINet/output/point data/point database/raw/8")
#
# s = sf::st_read('./training_dataset_v3.shp')
# s$label=as.character(s$label)
# odf = do.call(rbind, lapply(s$label, function(i) {
#   tmp = strsplit(i, '_')[[1]]
#   if(length(tmp) > 1) {
#     return(data.frame(crop1=tmp[1], crop2=tmp[2]))
#   } else {
#     return(data.frame(crop1=tmp[1], crop2='NA'))
#   }
# }))
#
# s$crop1 = odf$crop1
# s$crop2 = odf$crop2
#
# require(lubridate)
# require(sf)
#
# opts = do.call(rbind, lapply(1:nrow(s), function(r) {
#
#   ad1 = as.Date(s$start_date[r])
#   ad2 = as.Date(s$end_date[r])
#
#   d1 = day(ad1)
#   d2 = day(ad2)
#   m1 = month(ad1)
#   m2 = month(ad2)
#   y1 = year(ad1)
#   y2 = year(ad2)
#   ay = seq(y1, y2, 1)
#
#   if (length(ay) == 1) {
#     ad0 = mean(c(ad1,ad2))
#     am = month(ad0)
#     ad = day(ad0)
#   }
#
#   if ((length(ay) > 1) & (length(ay) < 3)) {
#     am = c(m1, m2)
#     ad = c(d1, d2)
#   }
#
#   if (length(ay) > 2) {
#     nd = length(yr[2:(length(yr)-1)])
#     ad = c(d1, replicate(nd, NA), d2)
#     am = c(m1, replicate(nd, NA), m2)
#   }
#
#   odf = data.frame(year=ay, month=am, day=ad)
#   odf$'season1_label' = s$crop1[r]
#   odf$'season2_label' = s$crop2[r]
#   odf$source = s$source[r]
#   odf$geometry = s$geometry[r]
#
#   return(odf)
#
# }))
#
# opts$source = 'https://doi.pangaea.de/10.1594/PANGAEA.899706/'
# opts$country = 'Brazil'
# opts$iso3 = 'BRA'
# opts = opts[,c(7:9,1:6)]
#
#
# opts0 = st_as_sf(opts)
#
# trial <- st_as_sf(opts0, coords = c("long","lat"))
#
# trial_coords <- unlist(st_geometry(trial)) %>%
#   matrix(ncol=2,byrow=TRUE) %>%
#   as_tibble() %>%
#   setNames(c("long","lat"))
#
# opts0_trial<-bind_cols(trial,trial_coords)
#
# camara_1<-opts0_trial[,1:10]
#
# camara_1$country<-'country_fullname'
#
# camara_1$iso3<-'NUTS0'
#
# setwd('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/8/processed')
#
# # write.csv(camara_1,'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/8/processed/camara_1.csv') manual manipulation of the file
#
#
#
# setwd("I:/MAS/01_data/LUCKINet/output/point data/point database/raw/9")
#
# library(mefa)
# s = read.csv('./Amazonia_2001-2019.csv', stringsAsFactors=F)
#
# odf = do.call(rbind, lapply(s$label, function(i) {
#   tmp = strsplit(i, '_')[[1]]
#   if(length(tmp) > 1) {
#     return(data.frame(crop1=tmp[1], crop2=tmp[2]))
#   } else {
#     return(data.frame(crop1=tmp[1], crop2='NA'))
#   }
# }))
#
# s$crop1 = odf$crop1
# s$crop2 = odf$crop2
#
# require(lubridate)
# require(sf)
#
# opts = do.call(rbind, lapply(1:nrow(s), function(r) {
#
#   ad1 = as.Date(s$start_date[r])
#   ad2 = as.Date(s$end_date[r])
#
#   d1 = day(ad1)
#   d2 = day(ad2)
#   m1 = month(ad1)
#   m2 = month(ad2)
#   y1 = year(ad1)
#   y2 = year(ad2)
#   ay = seq(y1, y2, 1)
#
#   if (length(ay) == 1) {
#     ad0 = mean(c(ad1,ad2))
#     am = month(ad0)
#     ad = day(ad0)
#   }
#
#   if ((length(ay) > 1) & (length(ay) < 3)) {
#     am = c(m1, m2)
#     ad = c(d1, d2)
#   }
#
#   if (length(ay) > 2) {
#     nd = length(yr[2:(length(yr)-1)])
#     ad = c(d1, replicate(nd, NA), d2)
#     am = c(m1, replicate(nd, NA), m2)
#   }
#
#   odf = data.frame(year=ay, month=am, day=ad, longitude=s$longitude[r], latitude=s$latitude[r])
#   odf$'season1_label' = s$crop1[r]
#   odf$'season2_label' = s$crop2[r]
#   odf$source = s$source[r]
#   odf$geometry = s$geometry[r]
#
#   return(odf)
#
# }))
#
# opts$source = 'https://doi.pangaea.de/10.1594/PANGAEA.911560/'
# opts$country = 'Brazil'
# opts$iso3 = 'BRA'
#
# opts0 = st_as_sf(opts, coords=c('longitude','latitude'), crs=st_crs(4326))
# opts0 = opts0[,c(6:8,1:5,9)]
#
# opts0 = st_as_sf(opts0)
#
# trial <- st_as_sf(opts0, coords = c("long","lat"))
#
# trial_coords <- unlist(st_geometry(trial)) %>%
#   matrix(ncol=2,byrow=TRUE) %>%
#   as_tibble() %>%
#   setNames(c("long","lat"))
#
# camara_2<-bind_cols(trial,trial_coords)
# camara_2<-camara_2[,1:10]
#
# trial<-camara_2
# trial2<-rep(trial, times=2)
# names(trial$season1_label)<-'original_label'
# trial<-as.data.frame(trial)
#
# trial2<-trial2[66105:132208,]
# trial2$season1_label=trial2$season2_label
# trial2$month<-NA
# trial2$day<-NA
#
# trial2<-as.data.frame(trial2)
#
# camara_2<-rbind(trial,trial2)
# camara_2<-camara_2[,c(1:7,9:10)]
# camara_2$season1_label <- as.character(camara_2$season1_label)
#
# camara_2<-camara_2[!(camara_2$season1_label=="Savanna" & camara_2$season1_label=="Wetlands" & camara_2$season1_label=="NA" & camara_2$season1_label=="Roraima"),]
#
# # creating little dataframe to match
# df <- data.frame (season1_label  = c("Forest", "Pasture", "Soy", "Fallow","Millet","Corn","Cotton","Sunflower"),
#                   luck_name = c("forest management", "meadow and pasture", "soybean","land with temporary fallow","millet","maize","seed cotton","Sunflower"),
#                   luck_ID = c(416, NA, 379, 139,249,236,368,395)
# )
#
# camara_2<-inner_join(camara_2,df,by='season1_label')
# names(camara_2$season1_label)<-"original_label"
#
# # write.csv(camara_2,'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/9/processed/camara_2.csv')
#
#
# # from Ruben ----
# setwd("I:/MAS/01_data/LUCKINet/incoming/point data/raw_data")
#
# require(lubridate)
# require(sf)
#
# #-------------------------------------------------------------------------------------------------------------#
# #
# #-------------------------------------------------------------------------------------------------------------#
#
# s = read.csv('./camara_etal/camara_etal_all.csv', stringsAsFactors=F)
# odf = do.call(rbind, lapply(s$label, function(i) {
#   tmp = strsplit(i, '_')[[1]]
#   if(length(tmp) > 1) {
#     return(data.frame(crop1=tmp[1], crop2=tmp[2]))
#   } else {
#     return(data.frame(crop1=tmp[1], crop2='NA'))
#   }
# }))
#
# s$crop1 = odf$crop1
# s$crop2 = odf$crop2
#
# #-------------------------------------------------------------------------------------------------------------#
# #
# #-------------------------------------------------------------------------------------------------------------#
#
# opts = do.call(rbind, lapply(1:nrow(s), function(r) {
#
#   ad1 = as.Date(s$start_date[r])
#   ad2 = as.Date(s$end_date[r])
#
#   d1 = day(ad1)
#   d2 = day(ad2)
#   m1 = month(ad1)
#   m2 = month(ad2)
#   y1 = year(ad1)
#   y2 = year(ad2)
#   ay = seq(y1, y2, 1)
#
#   if (length(ay) == 1) {
#     ad0 = mean(c(ad1,ad2))
#     am = month(ad0)
#     ad = day(ad0)
#   }
#
#   if ((length(ay) > 1) & (length(ay) < 3)) {
#     am = c(m1, m2)
#     ad = c(d1, d2)
#   }
#
#   if (length(ay) > 2) {
#     nd = length(yr[2:(length(yr)-1)])
#     ad = c(d1, replicate(nd, NA), d2)
#     am = c(m1, replicate(nd, NA), m2)
#   }
#
#   odf = data.frame(year=ay, month=am, day=ad, longitude=s$longitude[r], latitude=s$latitude[r])
#   odf$origin_id = s$id_sample[r]
#   odf$'primary_use' = s$crop1[r]
#   odf$'secondary_use' = s$crop2[r]
#   odf$source = s$source[r]
#   odf$geometry = s$geometry[r]
#
#   return(odf)
#
# }))
#
# opts1 = opts
# opts1$priority = 1
# opts1$land_use = opts1$primary_use
# opts2 = opts[which(!is.na(opts$secondary_use) & (opts$secondary_use != 'NA')),]
# opts2$priority = 2
# opts2$land_use = opts2$secondary_use
#
# opts = rbind(opts1, opts2)
#
# rm(opts1, opts2)
#
# #-------------------------------------------------------------------------------------------------------------#
# #
# #-------------------------------------------------------------------------------------------------------------#
#
# opts$dataset_name = 'camara_etal'
# opts$origin_name = 'Pangea'
# opts$origin_url = 'https://doi.pangaea.de/10.1594/PANGAEA.911560/'
# opts$country_name = 'Brazil'
# opts$country_iso3 = 'BRA'
# opts$source = NA
# opts$use_intensity = NA
# opts$water_source = NA
# opts$source = 'Field'
#
# #-----------------------------------------------------------------------------------------------------------------#
# #
# #-----------------------------------------------------------------------------------------------------------------#
#
# opts$land_cover = ''
# opts$land_cover[opts$land_use=='Forest'] = 'Forest'
# opts$land_use[opts$land_cover=='Forest'] = NA
# opts$land_cover[opts$land_use=='Cerrado'] = 'Savanna'
# opts$land_use[opts$land_cover=='Savanna'] = NA
# opts$land_cover[opts$land_use=='Pasture'] = 'Grassland'
# opts$land_cover[opts$land_use=='Soy'] = 'Cropland'
# opts$land_cover[opts$land_use=='Fallow'] = 'Other'
# opts$land_use[opts$land_use == 'NA'] = NA
# opts$land_cover[opts$land_use == 'Forest'] = 'Forest'
# opts$land_use[opts$land_cover == 'Forest'] = NA
# opts$land_cover[opts$land_use == 'Savanna'] = 'Savanna'
# opts$land_use[opts$land_cover == 'Savanna'] = NA
# opts$land_cover[opts$land_use == 'Wetlands'] = 'Wetland'
# opts$land_use[opts$land_cover == 'Wetland'] = NA
# opts$land_cover[opts$land_use == 'Pasture'] = 'Grassland'
# opts$land_cover[opts$land_use == 'Fallow'] = 'Other'
# opts$land_cover[opts$land_cover == ''] = 'Cropland'
#
# #-------------------------------------------------------------------------------------------------------------#
# #
# #-------------------------------------------------------------------------------------------------------------#
#
# pts = st_as_sf(opts, coords=c('longitude','latitude'), crs=st_crs(4326), remove=F)
# pts = pts[!duplicated(pts[,c('latitude','longitude','land_cover','land_use','year','month')]),]
# pts = pts[,c('dataset_name','origin_id','origin_name','origin_url','source',
#              'country_name','country_iso3','year','month','day','land_cover',
#              'land_use','priority','use_intensity','water_source','geometry')]
#
# st_write(pts, './camara_etal/camara_etal_point_processed.sqlite', append=FALSE)
