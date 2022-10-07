# script arguments ----
#
thisDataset <- "GFSAD30"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "",
           url = "https://croplands.org/app/data/search?page=1&page_size=200",
           download_date = "", # YYYY-MM-DD
           type = "", # dynamic or static
           licence = "",
           contact = "", # optional, if it's a paper that should be "see corresponding author"
           disclosed = "", # whether the data are freely available "yes"/"no"
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "GFSAD30_2000-2010.csv"), col_types = "iiiddciiiiicccl") %>%
  bind_rows(read_csv(paste0(thisPath, "GFSAD30_2011-2021.csv"), col_types = "iiiddciiiiicccl"))


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
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")





# # script arguments ----
# #
# thisDataset <- "GlobalCropland"
#
#
# # reference ----
# #
# bib <- read.bib(file = "references.bib")[thisDataset]
# assertClass(x = bib, classes = "bibentry")
#
#
# # read dataset ----
# #
# file1<-read.csv(file = paste0(DBDir, "input/", thisDataset, "/globalCropland_2000-2012.csv"))
# file2<-read.csv(file = paste0(DBDir, "input/", thisDataset, "/globalCropland_2013-2020.csv"))
#
#
# # read metadata ----
# #
# matching <- read.csv(file = paste0(DBDir, "input/", thisDataset, "/matching.csv"))
# ontology <- read.csv(file = paste0(DBDir, "input/", thisDataset, "/luckinet_ontology_alpha200424.csv"))
#
#
# # create some new directories ----
# dir.create(paste0(DBDir, "input/", thisDataset, "/per_country"))
# dir.create(paste0(DBDir, "input/", thisDataset, "/geo_cleaned"))
#
#
# # harmonise data ----
# #
# # changing names of columns of interest and adjusting the date of observation
# GlobalCropland<-rbind(file1,file2)
#
# colnames(GlobalCropland)[1] <- 'point_ID'
# GlobalCropland$dataset_name<-'GlobalCropland'
# GlobalCropland$month[GlobalCropland$month==0] <- NA
# colnames(GlobalCropland)[5] <- 'long'
# colnames(GlobalCropland)[6] <- 'country_fullname'
# colnames(GlobalCropland)[12] <-'obs_type'
#
# month_to_adjust<-nchar(GlobalCropland$month)
# GlobalCropland<-cbind(GlobalCropland,month_to_adjust)
# GlobalCropland$month<-with(GlobalCropland, ifelse(GlobalCropland$month_to_adjust == 1, paste0("0", month), paste0(month)))
#
# # cleaning missing data
# GlobalCropland<-GlobalCropland[!(GlobalCropland$country_fullname==""),]
#
# # selecting columns of interest
# GlobalCropland<-GlobalCropland[,c(1:9,11:12,16)]
#
# # creating NUTS0 column
# GlobalCropland$NUTS0<-countrycode(GlobalCropland$country_fullname, origin='country.name', destination='iso2c', nomatch=NA)
#
# # Creating missing columns for database homogenization
# GlobalCropland$NUTS1<-NA
# GlobalCropland$NUTS2<-NA
# GlobalCropland$GPS_prec<-NA
# GlobalCropland$day<-NA
#
# # adjusting intensity column
# GlobalCropland<-GlobalCropland %>%
#   mutate (intensity = if_else (intensity  == 0, "unkown",
#                                if_else (intensity  == 1, "single",
#                                         if_else (intensity  == 2, "double",
#                                                  if_else (intensity  == 3, "triple",
#                                                           if_else (intensity  == 4, "continuous", NA_character_))))))
#
# colnames(GlobalCropland)[10] <-'rotation'
#
# # filtering the land uses
# cropland<-GlobalCropland[GlobalCropland$land_use_type==1,]
#
# # unique class combination and saving the file for manual cleaning
# unique_combination<-unique(GlobalCropland[,c('crop_primary','crop_secondary')])
#
# # saving the cleaned file organized per country
# matching<-separate_rows(matching,luck_ID, sep = ";")
# matching<-matching[,1:3]
#
# cropland<-cropland %>% right_join (matching, by=c("crop_primary", "crop_secondary"))
# cropland<-cropland[cropland$luck_ID!= "D", ]
# cropland<-merge(x = cropland, y = ontology, by = "luck_ID")
# cropland<-cropland[,c(1:7,11:18,20)]
# cropland<-cropland[,c(2:16)]
# colnames(cropland)[15] <- 'class'
#
# cropland$country_fullname<-as.character(cropland$country_fullname)
#
# cropland$country_fullname <- replace(cropland$country_fullname, cropland$country_fullname == "Viet Nam",
#                                      "Vietnam")
#
# mylist <- split (cropland, cropland$country_fullname,drop= TRUE)
#
# i=1
# for(i in 1:length(mylist)){
#   y=names(mylist)[i]
#   saveRDS(mylist[[i]], file=paste0(DBDir, "input/", thisDataset, "/per_country/", y, ".rds"))
#   print(paste("loop i: ", i, " done"))
# }
#
# # cleaning occurrences outside country borders
# files<-list.files(path = paste0(DBDir, "input/", thisDataset, "/per_country"), pattern = ".rds", full.names = T) %>%
#   lapply(readRDS)
#
# i=1
# for(i in 1:length(files)) {
#   y=(unique(files[[i]][["country_fullname"]]))
#   country<-files[[i]]
#   xy<-data.matrix(country[,c(5,4)])
#   country_shape<-SpatialPointsDataFrame(coords = xy, data=country, proj4string = CRS("+proj=longlat +datum=WGS84"))
#   countries<-countriesCoarse
#   shape<-countries[countries@data$ADMIN==y,]
#   out<- point.in.poly(country_shape, shape)
#   first<-out@data
#   matching <- subset(first, ADMIN==y)
#
#   # 1st loop (+lat/+log)
#   first_loop<-subset(first, is.na(ISO_A2))
#
#   if (nrow(first_loop)>0){
#     first_loop$lat<-abs(first_loop$lat)
#     first_loop$long<-abs(first_loop$long)
#     xy_first <- data.matrix(first_loop[,c(5,4)])
#     first_loop_shape<-SpatialPointsDataFrame(coords = xy_first, data=first_loop[,1:15], proj4string = CRS("+proj=longlat +datum=WGS84"))
#     out_first<- point.in.poly(first_loop_shape, shape)
#     second_loop<-out_first@data
#     matching2<- subset(second_loop, ADMIN==y)
#
#     # 2nd loop (-lat/-log)
#     second_loop<-subset(second_loop, is.na(ISO_A2))
#     second_loop$lat<-second_loop$lat*-1
#     second_loop$long<-second_loop$long*-1
#     xy_second <- data.matrix(second_loop[,c(5,4)])
#     second_loop_shape<-SpatialPointsDataFrame(coords = xy_second, data=second_loop[,1:15], proj4string = CRS("+proj=longlat +datum=WGS84"))
#     out_second<- point.in.poly(second_loop_shape, shape)
#     third_loop<-out_second@data
#     matching3<- subset(third_loop, ADMIN==y)
#
#     # 3rd loop (+lat/-log)
#     third_loop<-subset(third_loop, is.na(ISO_A2))
#     third_loop$lat<-abs(third_loop$lat)
#     xy_third <- data.matrix(third_loop[,c(5,4)])
#     third_loop_shape<-SpatialPointsDataFrame(coords = xy_third, data=third_loop[,1:15], proj4string = CRS("+proj=longlat +datum=WGS84"))
#     out_third<- point.in.poly(third_loop_shape, shape)
#     forth_loop<-out_third@data
#     matching4<- subset(forth_loop, ADMIN==y)
#
#     # 4th loop (-lat/+log)
#     forth_loop<-subset(forth_loop, is.na(ADMIN))
#     forth_loop$lat<-forth_loop$lat*-1
#     forth_loop$long<-abs(forth_loop$long)
#     xy_forth <- data.matrix(forth_loop[,c(5,4)])
#     forth_loop_shape<-SpatialPointsDataFrame(coords = xy_forth, data=forth_loop[,1:15], proj4string = CRS("+proj=longlat +datum=WGS84"))
#     out_forth<- point.in.poly(forth_loop_shape, shape)
#     fifth_loop<-out_forth@data
#     matching5<- subset(fifth_loop, ADMIN==y)
#
#     cleaned<-rbind(matching,matching2,matching3,matching4,matching5)
#     cleaned<-cleaned[,1:15]
#   }else{
#     cleaned<-matching [,1:15]
#   }
#
#   saveRDS(cleaned, file=paste0(DBDir, "input/", thisDataset, "/geo_cleaned/", y, "_geocleaned.rds"))
#
#   print(paste("loop i: ", i, " done"))
#
# }
#
# # cleaning occurrences in the sea
# GlobalCropland<-list.files(path = paste0(DBDir, "input/", thisDataset, "/geo_cleaned"), pattern = ".rds", full.names = T) %>%
#   lapply(readRDS) %>%
#   bind_rows
# sea<-cc_sea(GlobalCropland, lon = 'long', lat = 'lat', verbose=TRUE, value = "flagged")
# GlobalCropland<-cbind(GlobalCropland, sea)
# GlobalCropland<-GlobalCropland[GlobalCropland$sea=='TRUE',]
# GlobalCropland<-GlobalCropland[,1:15]
# GlobalCropland$dataset_name<- as.factor(GlobalCropland$dataset_name)
# GlobalCropland<-merge(x = GlobalCropland, y = table, by = "dataset_name")
# GlobalCropland<-GlobalCropland[,c(1:25,27)]
# colnames(GlobalCropland)[3]<-'year'
#
#
# # write output ----
# #
# write_csv(meta, paste0(dataDir, "availability_point_data.csv"), na = "")
# saveDataset(object = geom, dataset = thisDataset)
#




# comm <- commodities %>%
#   select(faoID, crop_primary = gC_CID)
# lc <- landcover %>%
#   select(lcID, land_use_type = gC_LID)
#
# # load the dataset
# theData <- read_csv(file = paste0(input_path, "/point data/globalCropland/raw/globalCropland_2000-2012.csv"),
#                     col_types = "iiiddciiiiicccl") %>%
#   bind_rows(read_csv(file = paste0(input_path, "/point data/globalCropland/raw/globalCropland_2013-2020.csv"),
#                      col_types = "iiiddciiiiicccl")) %>%
#   mutate(fid = seq_along(id))
#
# # seperate into coordinates and attributes, and modify attributes
# theCoords <- theData %>%
#   select(x = lon, y = lat, fid)
#
# outData <- theData %>%
#   select(-lon, -lat) %>%
#   filter(!land_use_type %in% c(4:7)) %>%
#   mutate(date = as.Date(paste0(year, "-", formatC(month, digits = 1, flag = "0"), "-01")),
#          water = if_else(water == 0, NA_integer_, water-1L),
#          irrigated = as.logical(water),
#          dataset = "globalCropland") %>%
#   left_join(comm) %>%
#   left_join(lc) %>%
#   select(fid, date, country, lcID, faoID, irrigated, source_type, dataset)
#
# # make geom
# theGeom <- theCoords %>%
#   gs_point() %>%
#   setFeatures(outData) %>%
#   getFeatures(!is.na(faoID) & !is.na(date))
#
# outFeats <- getFeatures(x = theGeom)
# outCoords <- getPoints(x = theGeom)
# out_gC <- left_join(x = outFeats, y = outCoords, by = "fid")
