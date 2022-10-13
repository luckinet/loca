# script arguments ----
#
thisDataset <- "Parizzi2017"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- ""
url <- ""    # ideally the doi, but if it doesn't have one, the main source of the database
license <- ""

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Parizzi_2017.bib"))

regDataset(name = thisDataset,
           description = NA_character_,
           url = "https://doi.org/10.1594/PANGAEA.881658",
           download_date = "2022-01-10",
           type = "static",
           licence = "CC-BY-3.0",
           contact = NA_character_,
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_tsv(paste0(thisPath, "Parizzi_2017.tab"), skip = 29)

# manage ontology ---
#
newConcepts <- tibble(target = c("Forests", "Forests", "Shrubland",
                                 "Temporary grazing", "sugarcane"),
                      new = unique(data$LCC),
                      class = c("landcover", "landcover", "landcover",
                                "land-use", "commodity"),
                      description = NA,
                      match = "close",
                      certainty = 3)

luckiOnto <- new_source(name = thisDataset,
                        description = description,
                        date = Sys.Date(),
                        homepage = url,
                        license = license,
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = newConcepts$new,
                         target = get_concept(x = newConcepts %>% select(label = target), ontology = luckiOnto),
                         source = thisDataset,
                         description = newConcepts$description,
                         match = newConcepts$match,
                         certainty = newConcepts$certainty,
                         ontology = luckiOnto, matchDir = paste0(occurrenceDBDir, "01_concepts/"))


# harmonise data ----
#
temp <- data %>%
  distinct(LCC, .keep_all = TRUE) %>%
  mutate(
    fid = row_number(),
    x = Longitude,
    y = Latitude,
    luckinetID = ,
    year = NA_real_,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    country = "Brazil",
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = LCC,
    LC1_orig = LCC,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = NA_character_, # "field", "visual interpretation" or "experience"
    collector = NA_character_, # "expert", "citizen scientist" or "student"
    purpose = NA_character_, # "monitoring", "validation", "study" or "map development"
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, year, month, day, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")

#
# # from Caterina ----
# setwd("I:/MAS/01_data/LUCKINet/output/point data/point database/raw/10")
#
# require(lubridate)
# require(sf)
#
# s = st_read('./parizzi_etal.shp')
# s$'season1_label' = s$landuse
# s$'season2_label' = NA
# s$source = 'https://doi.pangaea.de/10.1594/PANGAEA.881658'
# s$country = 'Brazil'
# s$iso3 = 'BRA'
# s$month = NA
# s$day = NA
#
# s = s[,c(6:8,2,9:10,4:5,3)]
#
# s = st_as_sf(s)
#
# s_coords <- st_as_sf(s, coords = c("long","lat"))
#
# s <- unlist(st_geometry(s)) %>%
#   matrix(ncol=2,byrow=TRUE) %>%
#   as_tibble() %>%
#   setNames(c("long","lat"))
#
# s<-bind_cols(s,s_coords)
# s<-s[,1:9]
# s$season1_label<-as.character(s$season1_label)
# s<-s[s$season1_label=="Sugar Cane",]
# names(s$country)<-'country_fullname'
# names(s$iso3)<-'NUTS0'
# names(s$season1_label)<-'original_label'
#
# write.csv(s,'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/10/processed/parizzi_etal.csv')
#
# ## cleaning point in the sea and out of country borders for database 8, 9 and 10
# camara_1<-read.csv('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/8/processed/camara_1.csv')
# camara_2<-read.csv('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/9/processed/camara_2.csv')
# parizzi_etal<-read.csv('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/10/processed/parizzi_etal.csv')
#
# full<-rbind(camara_1,camara_2,parizzi_etal)
#
# # cleaning occurrences in the sea
# library(CoordinateCleaner)
# sea<-cc_sea(full, lon = 'long', lat = 'lat', verbose=TRUE, value = "flagged")
# full<-cbind(full, sea)
# full<-full[full$sea=='TRUE',]
#
# full<-full[,1:22]
#
# # cleaning occurrences outside country borders
#
# mylist <- split (full, full$country_fullname,drop= TRUE)
#
# i=1
# for(i in 1:length(mylist)){
#   y=names(mylist)[i]
#   saveRDS(mylist[[i]], file=paste0('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/10/processed/per_country/',y,'.rds'))
#   print(paste("loop i: ", i, " done"))
# }
#
# # cleaning occurrences outside country borders
# library(rworldmap)
# files<-list.files(path = ('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/10/processed/per_country'), pattern = ".rds", full.names = T) %>%
#   lapply(readRDS)
#
# i=1
# for(i in 1:length(files)) {
#   y=(unique(files[[i]][["country_fullname"]]))
#   country<-files[[i]]
#   xy<-data.matrix(country[,c(8,9)])
#   country_shape<-SpatialPointsDataFrame(coords = xy, data=country, proj4string = CRS("+proj=longlat +datum=WGS84"))
#   countries<-countriesCoarse
#
#   shape<-countries[countries@data$ADMIN=="Brazil",]
#   out<- point.in.poly(country_shape, shape)
#   first<-out@data
#   matching <- subset(first, ADMIN=="Brazil")
#
#   # 1st loop (+lat/+log)
#   first_loop<-subset(first, is.na(ISO_A2))
#
#   if (nrow(first_loop)>0){
#     first_loop$lat<-abs(first_loop$lat)
#     first_loop$long<-abs(first_loop$long)
#     xy_first <- data.matrix(first_loop[,c(8,9)])
#     first_loop_shape<-SpatialPointsDataFrame(coords = xy_first, data=first_loop[,1:22], proj4string = CRS("+proj=longlat +datum=WGS84"))
#     out_first<- point.in.poly(first_loop_shape, shape)
#     second_loop<-out_first@data
#     matching2<- subset(second_loop, ADMIN=="Brazil")
#
#     # 2nd loop (-lat/-log)
#     second_loop<-subset(second_loop, is.na(ISO_A2))
#     second_loop$lat<-second_loop$lat*-1
#     second_loop$long<-second_loop$long*-1
#     xy_second <- data.matrix(second_loop[,c(8,9)])
#     second_loop_shape<-SpatialPointsDataFrame(coords = xy_second, data=second_loop[,1:22], proj4string = CRS("+proj=longlat +datum=WGS84"))
#     out_second<- point.in.poly(second_loop_shape, shape)
#     third_loop<-out_second@data
#     matching3<- subset(third_loop, ADMIN=="Brazil")
#
#     # 3rd loop (+lat/-log)
#     third_loop<-subset(third_loop, is.na(ISO_A2))
#     third_loop$lat<-abs(third_loop$lat)
#     xy_third <- data.matrix(third_loop[,c(8,9)])
#     third_loop_shape<-SpatialPointsDataFrame(coords = xy_third, data=third_loop[,1:22], proj4string = CRS("+proj=longlat +datum=WGS84"))
#     out_third<- point.in.poly(third_loop_shape, shape)
#     forth_loop<-out_third@data
#     matching4<- subset(forth_loop, ADMIN=="Brazil")
#
#     # 4th loop (-lat/+log)
#     forth_loop<-subset(forth_loop, is.na(ADMIN))
#     forth_loop$lat<-forth_loop$lat*-1
#     forth_loop$long<-abs(forth_loop$long)
#     xy_forth <- data.matrix(forth_loop[,c(8,9)])
#     forth_loop_shape<-SpatialPointsDataFrame(coords = xy_forth, data=forth_loop[,1:22], proj4string = CRS("+proj=longlat +datum=WGS84"))
#     out_forth<- point.in.poly(forth_loop_shape, shape)
#     fifth_loop<-out_forth@data
#     matching5<- subset(fifth_loop, ADMIN=="Brazil")
#
#     cleaned<-rbind(matching,matching2,matching3,matching4,matching5)
#     cleaned<-cleaned[,1:22]
#   }else{
#     cleaned<-matching [,1:22]
#   }
#
#   setwd('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/10/processed/geo_cleaned')
#
#   saveRDS(cleaned, file=paste0('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/10/processed/geo_cleaned/',y,'_geocleaned.rds'))
#
#   print(paste("loop i: ", i, " done"))
#
# }
#
# # adding the name of the databases
# db<-readRDS('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/10/processed/geo_cleaned/Brazil_geocleaned.rds')
#
# df <- data.frame (source  = c("https://doi.pangaea.de/10.1594/PANGAEA.899706/", "https://doi.pangaea.de/10.1594/PANGAEA.911560/", "https://doi.pangaea.de/10.1594/PANGAEA.881658"),
#                   dataset_name = c("camara_1", "camara_2",'parizzi_etal'))
# Brazil_geocleaned<-inner_join(db,df,by='source')
# #saveRDS(Brazil_geocleaned, file=('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/10/processed/geo_cleaned/Brazil_geocleaned.rds')) # file moved to cluster for intergration
#
#
#
# # from Ruben ----
# #
# library(lubridate)
# require(sf)
#
# ref = st_read('C:/Users/rr70wedu/Documents/example_data/admin/gadm36_0-simple.shp')
# s = read.csv('./parizzi_etal/parizzi_etal.csv', stringsAsFactors=F)
#
# s0 = read.csv('./parizzi_etal/parizzi_etal.csv', stringsAsFactors=F, colClasses=rep("character",ncol(s)))
# xnc = sapply(s0$Longitude, function(i) nchar(strsplit(i, '[.]')[[1]][1]))
# ync = sapply(s0$Latitude, function(i) nchar(strsplit(i, '[.]')[[1]][1]))
#
# p = read.csv('spatialPrecision.csv')
# s$bsize = apply(cbind(p$rad[match(xnc, p$nr_char)],p$rad[match(ync, p$nr_char)]), 1, max)
#
# rm(s0, xnc, ync)
#
# s = s[which(!is.na(s$Longitude) & !is.na(s$Latitude)),]
# s = st_as_sf(s, coords=c('Longitude','Latitude'), crs=st_crs(ref))
#
# s$land_use = s$LCC
# s$priority = 1
# s$dataset_name = 'parizzi_etal'
# s$origin_id = s$sample_id
# s$origin_name = 'Pangea'
# s$origin_url = 'https://doi.pangaea.de/10.1594/PANGAEA.881658'
# s$source = NA
# s$country_name = 'Brazil'
# s$country_iso3 = 'BRA'
# s$month = NA
# s$day = NA
# s$source = NA
# s$use_intensity = NA
# s$water_source = NA
#
# s = do.call(rbind, lapply(1:nrow(s), function(i) {
#
#   lr = s$Reference..See.Further.details.link.for.....[i]
#   yr = as.numeric(strsplit(lr, ' ')[[1]])
#   yr = yr[!is.na(yr)]
#   pts = do.call(rbind, lapply(yr, function(y) {
#     tmp = s[i,]
#     tmp$year = y
#     return(tmp)
#   }))
#
#   return(pts)
#
# }))
#
# s$land_cover = ''
# s$land_cover[s$LCC %in% c("Grass-shrub savannah", 'Forest savannah','Park savannah + Wooded savannah')] = 'Savanna'
# s$land_use[s$LCC %in% c("Grass-shrub savannah", 'Forest savannah','Park savannah + Wooded savannah')] = NA
# s$land_cover[s$LCC == 'Planted pasture'] = 'Grassland'
# s$land_cover[s$LCC == 'Sugar Cane'] = 'Cropland'
#
# pts = s[,c('dataset_name','origin_id','origin_name','origin_url','source','country_name','country_iso3','year',
#            'month','day','land_cover','land_use','priority',
#            'use_intensity','water_source','geometry')]
#
# st_write(pts, './parizzi_etal/parizzi_etal_point_processed.sqlite', append=FALSE)
#
# ply = do.call(rbind, lapply(1:nrow(pts), function(r) return(st_buffer(pts[r,], s$bsize[r], endCapStyle='ROUND'))))
# st_write(ply, './parizzi_etal/parizzi_etal_poly_processed.sqlite', append=F)
