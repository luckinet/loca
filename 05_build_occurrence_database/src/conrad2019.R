# ----
# geography : _INSERT
# period    : _INSERT
# typology  :
#   - cover  : _INSERT
#   - dynamic: _INSERT
#   - use    : _INSERT
# features  : _INSERT
# data type : _INSERT
# doi/url   : _INSERT
# authors   : Peter Pothmann, Steffen Ehrmann
# date      : 2024-MM-DD
# status    : find data, update, inventarize, validate, normalize, done
# comment   : _INSERT
# ----

thisDataset <- _INSERT
message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
dir_input <- paste0(dir_occurr, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(dir_input, _INSERT))

# data_path_cmpr <- paste0(dir_input, "")
# unzip(exdir = dir_input, zipfile = data_path_cmpr)
# untar(exdir = dir_input, tarfile = data_path_cmpr)

data_path <- paste0(dir_input, _INSERT)
data <- read_csv(file = data_path)
data <- read_tsv(file = data_path)
data <- read_excel(path = data_path)
data <- read_parquet(file = data_path)
data <- st_read(dsn = data_path) %>% as_tibble()
# make sure that coordinates are transformed to EPSG:4326 (WGS84)


message(" --> normalizing data")
data <- data %>%
  mutate(obsID = row_number(), .before = 1)

other <- data %>%
  select(obsID, _INSERT)

schema_INSERT <-
  setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
            na_values = _INSERT) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%
  setIDVar(name = "obsID", type = "i", columns = 1) %>%
  setIDVar(name = "externalID", columns = _INSERT) %>%
  setIDVar(name = "open", type = "l", value = _INSERT) %>%
  setIDVar(name = "type", value = _INSERT) %>%
  setIDVar(name = "x", type = "n", columns = _INSERT) %>%
  setIDVar(name = "y", type = "n", columns = _INSERT) %>%
  setIDVar(name = "geometry", columns = _INSERT) %>%
  setIDVar(name = "date", columns = _INSERT) %>%
  setIDVar(name = "irrigated", type = "l", value = _INSERT) %>%
  setIDVar(name = "present", type = "l", value = _INSERT) %>%
  setIDVar(name = "sample_type", value = _INSERT) %>%
  setIDVar(name = "collector", value = _INSERT) %>%
  setIDVar(name = "purpose", value = _INSERT) %>%
  setObsVar(name = "concept", type = "c", columns = _INSERT)

temp <- reorganise(schema = schema_INSERT, input = data)


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = _INSERT,
           homepage = _INSERT,
           date = ymd(_INSERT),
           license = _INSERT,
           ontology = path_onto_odb)

out <- matchOntology(table = temp,
                     columns = "concept",
                     colsAsClass = FALSE,
                     dataseries = thisDataset,
                     ontology = path_onto_odb)

out <- list(harmonised = out, extra = other)


message(" --> writing output")
saveRDS(object = out, file = paste0(dir_occurr, "output/", thisDataset, ".rds"))
saveBIB(object = bib, file = paste0(dir_occurr, "references.bib"))

beep(sound = 10)
message("\n     ... done")



# script arguments ----
#
thisDataset <- ""
description <- ""
url <- "https://doi.org/ https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "")) # or bibtex_reader()

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd(),
           type = NA_character_,
           licence = licence,
           contact = NA_character_,
           disclosed = NA,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", ""))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = NA_character_,
    country = NA_character_,
    x = NA_real_,
    y = NA_real_,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = NA_character_,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = NA,
    sample_type = NA_character_,
    collector = NA_character_,
    purpose = NA_character_) %>%
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

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")




# script arguments ----
#
thisDataset <- "Conrad2019"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "",
           url = "https://www.geo.uni-halle.de/geooekologie/mitarbeiter/conrad/",
           download_date = "", # YYYY-MM-DD
           type = "", # dynamic or static
           licence = "",
           contact = "", # optional, if it's a paper that should be "see corresponding author"
           disclosed = "", # whether the data are freely available "yes"/"no"
           bibliography = bib,
           update = TRUE)


# preprocess data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "")) # several files, what do they mean?


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    x = ,
    y = ,
    year = ,
    month = ,
    day = ,
    country = NA_character_,
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = ,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = , # "field", "visual interpretation", "experience", "meta study" or "modelled"
    collector = , # "expert", "citizen scientist" or "student"
    purpose = , # "monitoring", "validation", "study" or "map development"
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, year, month, day, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())


# write output ----
validateFormat(object = temp, type = "in-situ point") %>%
  saveDataset(dataset = thisDataset)

# validateFormat(object = temp_sf, type = "in-situ areal") %>%
#   write_sf(dsn = paste0(thisDataset, "_sf.gpkg"), delete_layer = TRUE)

message("\n---- done ----")


#
# # from Caterina ----
# #
# # Reading the raw data
# Turkey_summer_2018<-readOGR(dsn='I:/MAS/01_data/LUCKINet/output/point data/point database/raw/5/Turkey_Groundtruth_Data_Summer_2018/All_Classes_Points_Final_Soeke.shp')
#
# Pakistan_summer_2017<-read.csv('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/5/Pakistan_Grountruth_Data_Summer_2017.csv')
#
# Pakistan_cotton_2017<-read_xlsx('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/5/Yield_Cotton_Summer_2017_Pakistan.xlsx')
#
# Turkey_cotton_2018<-read_xlsx('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/5/Yield_Cotton_Söke_Turkey_Oct_2018.xlsx',sheet = 'Sheet1')
#
# # calling only columns of interest and renaming them for the 4 data series
# colnames(Pakistan_summer_2017)[1] <- 'lat'
# colnames(Pakistan_summer_2017)[2] <- 'long'
# colnames(Pakistan_summer_2017)[6] <- 'class'
# Pakistan_summer_2017<-Pakistan_summer_2017[,c(1,2,6)]
# Pakistan_summer_2017$year<-2017
# Pakistan_summer_2017$country_fullname<-'Pakistan'
#
# colnames(Pakistan_cotton_2017)[1]<-'long'
# colnames(Pakistan_cotton_2017)[2]<-'lat'
# colnames(Pakistan_cotton_2017)[13]<-'class'
# Pakistan_cotton_2017<-Pakistan_cotton_2017[,c(1,2,13)]
# Pakistan_cotton_2017$year<-2017
# Pakistan_cotton_2017$country_fullname<-'Pakistan'
# Pakistan_cotton_2017<-separate_rows(Pakistan_cotton_2017,class, sep = ",")
# Pakistan_cotton_2017$class<-stri_replace_all_charclass(Pakistan_cotton_2017$class, "\\p{WHITE_SPACE}", "")
#
#
# colnames(Turkey_cotton_2018)[1] <- 'lat'
# colnames(Turkey_cotton_2018)[2] <- 'long'
# Turkey_cotton_2018<-Turkey_cotton_2018[,1:2]
# Turkey_cotton_2018$year<-2018
# Turkey_cotton_2018$country_fullname<-'Turkey'
# Turkey_cotton_2018$class<-'cotton'
#
#
# Turkey_summer_2018_attributes<-Turkey_summer_2018@data
# Turkey_summer_2018_coordinates<-Turkey_summer_2018@coords
# coordinates_to_transform<-SpatialPoints(Turkey_summer_2018_coordinates[,1:2], proj4string=CRS("+proj=utm +zone=35 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 "))
# Turkey_summer_2018_coordinates_transformed<-spTransform(coordinates_to_transform, CRS("+proj=longlat +datum=WGS84"))
# coords<-Turkey_summer_2018_coordinates_transformed@coords
# Turkey_summer_2018<-cbind(Turkey_summer_2018_attributes,coords)
# colnames(Turkey_summer_2018)[1] <- 'class'
# colnames(Turkey_summer_2018)[5] <- 'lat'
# colnames(Turkey_summer_2018)[6] <- 'long'
# Turkey_summer_2018<-Turkey_summer_2018[,c(1,5,6)]
# Turkey_summer_2018$year<-2018
# Turkey_summer_2018$country_fullname<-'Turkey'
#
# # creating unique class combination for manual cleaning
# Conrad_et_al<-rbind(Pakistan_summer_2017,Pakistan_cotton_2017,Turkey_cotton_2018,Turkey_summer_2018)
# unique_combination<-unique(Conrad_et_al$class)
# #write.csv(unique_combination,'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/5/processed/matching.csv')
#
# # reading again the file and assigning the codes to the observations by matching with Luckinet ontology
# Conrad_et_al_matching<-read.csv('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/5/processed/matching.csv')
# Conrad_et_al_matching<-Conrad_et_al_matching[!(Conrad_et_al_matching$MATCHING_CODE=="D"),]
# Conrad_et_al<-Conrad_et_al %>% right_join (Conrad_et_al_matching, by='class')
# Conrad_et_al<-Conrad_et_al[,c(1:2,4:6)]
# colnames(Conrad_et_al)[5] <- 'class'
#
# # Creating missing columns for database homogenization
# Conrad_et_al$point_ID<-NA
# Conrad_et_al$NUTS0<-countrycode(Conrad_et_al$country_fullname, origin='country.name', destination='iso2c')
# Conrad_et_al$NUTS1<-NA
# Conrad_et_al$NUTS2<-NA
# Conrad_et_al$GPS_prec<-NA
# Conrad_et_al$day<-NA
# Conrad_et_al$month<-NA
# Conrad_et_al$obs_type<-NA
#
# # splitting database per country
#
# mylist <- split (Conrad_et_al, Conrad_et_al$country_fullname)
#
# i=1
# for(i in 1:length(mylist)){
#   y=names(mylist)[i]
#   saveRDS(mylist[[i]], file=paste0('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/5/processed/per_country/',y,'.rds'))
#   print(paste("loop i: ", i, " done"))
# }
#
# # Cleaning occurrences outside country borders
#
# files<-list.files(path = paste0(MAS_data,'/raw/5/processed/per_country'), pattern = ".rds", full.names = T) %>%
#   lapply(readRDS)
#
# i=1
# for(i in 1:length(files)) {
#   y=as.factor(unique(files[[i]][["NUTS0"]]))
#   country<-files[[i]]
#   xy<-data.matrix(country[,c(1,2)])
#   country_shape<-SpatialPointsDataFrame(coords = xy, data=country, proj4string = CRS("+proj=longlat +datum=WGS84"))
#   countries<-countriesCoarse
#   shape<-countries[countries@data$ISO_A2=="PK",]
#   out<- point.in.poly(country_shape, shape)
#   first<-out@data
#   matching <- subset(first, ISO_A2=="PK")
#
#   # 1st loop (+lat/+log)
#   first_loop<-subset(first, is.na(ISO_A2))
#   first_loop[1]<-as.numeric(first_loop$lat)
#   first_loop[2]<-as.numeric(first_loop$long)
#   first_loop$lat<-abs(first_loop$lat)
#   first_loop$long<-abs(first_loop$long)
#   xy_first <- data.matrix(first_loop[,c(1,2)])
#   first_loop_shape<-SpatialPointsDataFrame(coords = xy_first, data=first_loop[,1:13], proj4string = CRS("+proj=longlat +datum=WGS84"))
#   out_first<- point.in.poly(first_loop_shape, shape)
#   second_loop<-out_first@data
#   matching2<- subset(second_loop, ISO_A2=="PK")
#
#   # 2nd loop (-lat/-log)
#   second_loop<-subset(second_loop, is.na(ISO_A2))
#   second_loop$lat<-second_loop$lat*-1
#   second_loop$long<-second_loop$long*-1
#   xy_second <- data.matrix(second_loop[,c(1,2)])
#   second_loop_shape<-SpatialPointsDataFrame(coords = xy_second, data=second_loop[,1:13], proj4string = CRS("+proj=longlat +datum=WGS84"))
#   out_second<- point.in.poly(second_loop_shape, shape)
#   third_loop<-out_second@data
#   matching3<- subset(third_loop, ISO_A2=="PK")
#
#   # 3rd loop (+lat/-log)
#   third_loop<-subset(third_loop, is.na(ISO_A2))
#   third_loop$long<-abs(third_loop$long)
#   xy_third <- data.matrix(third_loop[,c(1,2)])
#   third_loop_shape<-SpatialPointsDataFrame(coords = xy_third, data=third_loop[,1:13], proj4string = CRS("+proj=longlat +datum=WGS84"))
#   out_third<- point.in.poly(third_loop_shape, shape)
#   forth_loop<-out_third@data
#   matching4<- subset(forth_loop, ISO_A2=="PK")
#
#   # 4th loop (-lat/+log)
#   forth_loop<-subset(forth_loop, is.na(ISO_A2))
#   forth_loop$lat<-forth_loop$lat*-1
#   forth_loop$long<-abs(forth_loop$long)
#   xy_forth <- data.matrix(forth_loop[,c(1,2)])
#   forth_loop_shape<-SpatialPointsDataFrame(coords = xy_forth, data=forth_loop[,1:13], proj4string = CRS("+proj=longlat +datum=WGS84"))
#   out_forth<- point.in.poly(forth_loop_shape, shape)
#   fifth_loop<-out_forth@data
#   matching5<- subset(fifth_loop, ISO_A2=="PK")
#
#   cleaned<-rbind(matching,matching2,matching3,matching4,matching5)
#   cleaned<-cleaned[,1:13]
#   saveRDS(cleaned, file=paste0('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/5/processed/geo_cleaned/',y,'_geocleaned.rds'))
# }
#
# # cleaning occurrences in the sea
# TR<-readRDS('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/5/processed/geo_cleaned//TR_geocleaned.rds')
# PK<-readRDS('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/5/processed/geo_cleaned//PK_geocleaned.rds')
#
# Conrad_et_al<-rbind(TR,PK)
# Conrad_et_al[1]<-as.numeric(Conrad_et_al$lat)
# Conrad_et_al[2]<-as.numeric(Conrad_et_al$long)
# sea<-cc_sea(Conrad_et_al, lon = 'long', lat = 'lat', verbose=TRUE, value = "flagged")
# Conrad_et_al<-cbind(Conrad_et_al, sea)
# Conrad_et_al<-Conrad_et_al[Conrad_et_al$sea=='TRUE',]
# Conrad_et_al<-Conrad_et_al[,1:13]
# Conrad_et_al$dataset_name<-"Conrad et al."
# Conrad_et_al<-merge(x = Conrad_et_al, y = table, by = "dataset_name")
# Conrad_et_al<-Conrad_et_al[,c(1:24,26)]
# saveRDS(cleaned, file=paste0('I:/MAS/01_data/LUCKINet/output/point data/point database/data/5/Conrad_et_al.rds'))
#
#
# # from Ruben ----
# setwd("I:/MAS/01_data/LUCKINet/incoming/point data/raw_data")
#
# require(lubridate)
# require(sf)
#
# #----------------------------------------------------------------------------------------------------------#
# #
# #----------------------------------------------------------------------------------------------------------#
#
# ref = st_read('C:/Users/rr70wedu/Documents/example_data/admin/gadm36_0-simple.shp')
# s = st_read('./conrad_etal/conrad_etal_1.sqlite')
# st_crs(s) = st_crs(ref)
#
# s$land_use = s$name
# s$land_cover = 'Cropland'
# s$dataset_name = 'conrad_etal_1'
# s$origin_id = s$ogc_fid0
# s$origin_name = 'C. Conrad, Uni-Halle'
# s$origin_url = 'https://www.geo.uni-halle.de/geooekologie/mitarbeiter/conrad/'
# s$source = 'Field'
# s$priority = 1
# s$country_name = 'Turkey'
# s$country_iso3 = 'TUR'
# s$use_intensity = NA
# s$water_source = NA
# s$year = 2018
# s$month = NA
# s$day = NA
#
# s$land_cover[s$land_use == 'Water'] = 'Water'
# s$land_use[s$land_use == 'Water'] = NA
#
# pts = s[,c('dataset_name','origin_id','origin_name','origin_url','source',
#            'country_name','country_iso3','year','month','day','land_cover',
#            'land_use','priority','use_intensity','water_source','GEOMETRY')]
#
# st_write(pts, './conrad_etal/conrad_etal_point_processed.sqlite', append=FALSE)
#
# poly = do.call(rbind, lapply(1:nrow(pts), function(r) st_buffer(pts[r,], 0.00001, endCapStyle='ROUND')))
# st_write(poly, './conrad_etal/conrad_etal_poly_processed.sqlite', append=FALSE)
#
# #----------------------------------------------------------------------------------------------------------#
# #
# #----------------------------------------------------------------------------------------------------------#
#
# s = read.csv('./conrad_etal/conrad_etal_2.csv', stringsAsFactors=F)
#
# s$land_use = s$Cropping.pattern
# s$land_cover = 'Cropland'
# s$dataset_name = 'conrad_etal_2'
# s$origin_id = s$id
# s$origin_name = 'C. Conrad, Uni-Halle'
# s$origin_url = 'https://www.geo.uni-halle.de/geooekologie/mitarbeiter/conrad/'
# s$source = 'Field'
# s$priority = 1
# s$country_name = 'Turkey'
# s$country_iso3 = 'TUR'
# s$use_intensity = NA
# s$water_source = NA
# s$year = as.numeric(substr(s$Date, 1, 4))
# s$month = as.numeric(substr(s$Date, 6, 7))
# s$day = as.numeric(substr(s$Date, 9, 10))
#
# s = st_as_sf(s, coords=c('Longitude','Latitude'), crs=st_crs(s))
#
# pts = s[,c('dataset_name','origin_id','origin_name','origin_url','source',
#            'country_name','country_iso3','year','month','day','land_cover',
#            'land_use','priority','use_intensity','water_source','geometry')]
#
# st_write(pts, './conrad_etal/conrad_etal_point_processed.sqlite', append=TRUE)
#
# poly = do.call(rbind, lapply(1:nrow(pts), function(r) st_buffer(pts[r,], 0.00001, endCapStyle='ROUND')))
# st_write(poly, './conrad_etal/conrad_etal_poly_processed.sqlite', append=TRUE)
#
# #----------------------------------------------------------------------------------------------------------#
# #
# #----------------------------------------------------------------------------------------------------------#
#
# s = read.csv('./conrad_etal/conrad_etal_3.csv', stringsAsFactors=F)
# s = s[1:100,]
#
# s = do.call(rbind, lapply(1:nrow(s), function(r) {
#
#   cc = strsplit(s$crop_summer[r], '[,]')[[1]]
#   d1 = data.frame(land_use=cc, priority=1, stringsAsFactors=F)
#
#   cc = strsplit(s$crop_autumn[r], '[,]')[[1]]
#   d2 = data.frame(land_use=cc, priority=2, stringsAsFactors=F)
#
#   ods = rbind(d1, d2)
#
#   ods$origin_id = s$id[r]
#   ods$year = 2017
#   ods$month = NA
#   ods$day = NA
#
#   ind = which(tolower(ods$land_use)=='cotton')
#   ods$month[ind] = as.numeric(substr(s$Cotton_cultivation_date[r], 6, 7))
#   ods$day[ind] = as.numeric(substr(s$Cotton_cultivation_date[r], 9, 10))
#
#   ods$Longitude = s$Longitude[r]
#   ods$Latitude = s$Latitude[r]
#   ods$buffer = s$buffer[r]
#
#   return(ods)
#
# }))
#
# s$land_cover = 'Cropland'
# s$dataset_name = 'conrad_etal_3'
# s$origin_name = 'C. Conrad, Uni-Halle'
# s$origin_url = 'https://www.geo.uni-halle.de/geooekologie/mitarbeiter/conrad/'
# s$source = 'Field'
# s$country_name = 'Pakistan'
# s$country_iso3 = 'PAL'
# s$use_intensity = NA
# s$water_source = NA
#
# s = st_as_sf(s, coords=c('Longitude','Latitude'), crs=st_crs(s))
#
# pts = s[,c('dataset_name','origin_id','origin_name','origin_url','source',
#            'country_name','country_iso3','year','month','day','land_cover',
#            'land_use','priority','use_intensity','water_source','geometry')]
#
# st_write(pts, './conrad_etal/conrad_etal_point_processed.sqlite', append=TRUE)
#
# poly = do.call(rbind, lapply(1:nrow(pts), function(r) st_buffer(pts[r,], 0.00001, endCapStyle='ROUND')))
# st_write(poly, './conrad_etal/conrad_etal_poly_processed.sqlite', append=TRUE)
