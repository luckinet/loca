# script arguments ----
#
thisDataset <- "Genesys"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "Genesys is a database which allows users to explore the world’s crop diversity conserved in genebanks through a single website.",
           url = "https://www.genesys-pgr.org/",
           type = "dynamic",
           licence = "dataset specific",
           bibliography = bib,
           download_date = "2020-03-16",
           contact = "see reference for data",
           disclosed = "yes",
           update = TRUE)


# preprocess data ----
#
genesysFiles <- list.files(thisPath, full.names = TRUE)

if(!any(str_detect(genesysFiles, "full_dataset"))){
  genesysFiles %>%
    map(.f = read_excel) %>%
    bind_rows() %>%
    saveRDS(file = paste0(thisPath, "/full_dataset.rds"))
}


# read dataset ----
#
data <- read_rds(paste0(thisPath, "full_dataset.rds"))


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
cnts <- tibble(iso_a3 = unique(data$ORIGCTY)) %>%
  filter(!is.na(iso_a3)) %>%
  left_join(countries, by = "iso_a3") %>%
  filter(!is.na(unit))

temp <- data %>%
  mutate(
    fid = row_number(),
    x = DECLONGITUDE,
    y = DECLATITUDE,
    luckinetID = ,
    datasetID = thisDataset,
    iso_a3 = ORIGCTY,
    irrigated = NA_character_,
    externalID = ACCENUMB,
    externalValue = CROPNAME,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field", # "field", "visual interpretation" or "experience"
    collector = "expert", # "expert", "citizen scientist" or "student"
    purpose = "monitoring", # "monitoring", "validation", "study" or "map development"
    epsg = 4326) %>%   # see https://epsg.io for other codes
  separate(col = COLLDATE, into = c("year", "month", "day"), sep = "") %>%
  left_join(cnts %>% select(iso_a3, unit), by = "iso_a3") %>%
  select(datasetID, fid, country, x, y, epsg, year, month, day, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")




# # harmonise data ----
# #
# # pre-filter unneeded rows
# # temp <- input %>%
# #   filter(!duplicated(ACCENUMB)) %>% not sure whether that makes sense, because some of those duplicated IDs (?) contain non-duplicated data
#
# # ... assign quality code
# temp <- input %>%
#   make_QC(coordinates = c("DECLONGITUDE", "DECLATITUDE"),
#           attributes = c("COLLDATE", "ORIGCTY", "GENUS", "SPECIES", "CROPNAME"))
#
# # reconstruct values:
# #
# # 1. observation year
# temp <- temp %>%
#   mutate(year = as.numeric(str_sub(COLLDATE, 1, 4)))
#
# # 2. countries (ahID)
#
# # 3. concept names (luckinetID)
#
# # 4. spatial entity (fid)
# temp <- temp %>%
#   mutate(fid = seq_along(QC))
#
#
# table <- reorganise(temp, schema_genesys)
#
#
# # before preparing data for storage, test that all variables are available
# assertNames(x = names(table),
#             must.include = c("fid", "x", "y", "date", "irrigated", "ahID",
#                              "datasetID", "luckinetID", "externalID",
#                              "externalValue", "QC", "source_type"))
#
# # make points and attributes table
# points <- temp %>%
#   select(fid, x, y)
#
# attributes <- temp %>%
#   select(-x, -y)
#
# # make a point geom and set the attribute table
# geom <- points %>%
#   gs_point() %>%
#   setFeatures(table = attributes)
#
#
# # write output ----
# #
# write_csv(meta, paste0(dataDir, "availability_point_data.csv"), na = "")
# saveDataset(object = geom, dataset = thisDataset)





# The following steps have been carried out by Ruben:
#
# - Evaluated if the samples fall within the reported country
# - If samples don’t exist within the reported country:
#   * Update lat/lon since negative coordinates often appear as positive and vice-versa. Test all possible combinations of change (i.e, -lat/+lon, +lat/-lon, etc) and, at every iteration, check if a sample is within the right country. When a match is found, exclude the corrected samples from further checking.
#   *  Exclude samples without a match after the correction
# - Check dates:
#   * Dates should be presented as YYYY-MM-DD, but sometimes have an YYYYDDD format. Evaluate existing cases and exclude those that do not have at least the year and those from which a year cannot be interpreted (e.g. some samples had only 2-3 digits).
#   * Exclude all samples without a date/year
# - Translate labels that relate to species (e.g. often pastures are described by single plant species)
#


# from Caterina ----
#
# libraries

# library('tidyverse')
# library('data.table')
# library("readxl")
# library('countrycode')
# library('CoordinateCleaner')
# library(stringr)
# library(naniar)

# data_path

# cluster_data<-'/gpfs1/data/idiv_meyer/01_projects/Caterina'

# calling Genesys files

# Genesys<-list.files(path = paste0(cluster_data,"/raw/4"), pattern = ".xlsx", full.names = T) %>%
#   lapply(read_excel) %>%
#   bind_rows

#saveRDS(Genesys, path = paste0(cluster_data,"/raw/4/processed/Genesys.rds"))

# calling the full file

# Genesys<-readRDS("/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/4/processed/Genesys.rds")

# Selecting columns of interest

# Genesys<-Genesys[,c(3,9,10,12,14,17:23,25)]

# Deleting duplicates

# Genesys<-Genesys[!duplicated(Genesys[1]),]

# Removing samples without coordinates

# Genesys<-Genesys[(!Genesys$DECLATITUDE=='NA'),]
# Genesys<-Genesys %>%
#   filter(!is.na(DECLATITUDE))
# Genesys<-Genesys[(!Genesys$DECLATITUDE==''),]
# Genesys<-Genesys[(!Genesys$DECLATITUDE==0),]

# Genesys<-Genesys[(!Genesys$DECLONGITUDE=='NA'),]
# Genesys<-Genesys %>%
#   filter(!is.na(DECLONGITUDE))
# Genesys<-Genesys[(!Genesys$DECLONGITUDE==''),]
# Genesys<-Genesys[(!Genesys$DECLONGITUDE==0),]

# Removing samples without country information and year

# Genesys<-Genesys[(!Genesys$ORIGCTY=='NA'),]
# Genesys<-Genesys %>%
#   filter(!is.na(ORIGCTY))
# Genesys<-Genesys[(!Genesys$ORIGCTY==''),]
# Genesys<-Genesys[(!Genesys$ORIGCTY==0),]
#
# Genesys<-Genesys[(!Genesys$COLLDATE=='NA'),]
# Genesys<-Genesys %>%
#   filter(!is.na(COLLDATE))
# Genesys<-Genesys[(!Genesys$COLLDATE==''),]
# Genesys<-Genesys[(!Genesys$COLLDATE==0),]

# Cleaning date of observation (year, month, day)

# Genesys$year<-as.numeric(substr(Genesys$COLLDATE, 1, 4))
# Genesys<- Genesys[(!Genesys$year > 2020),]
# Genesys<-Genesys %>%
#   filter(!is.na(year))

# Genesys$month<-as.numeric(substr(Genesys$COLLDATE, 5, 6))
# Genesys$month[Genesys$month==-7 | Genesys$month==29 | Genesys$month==-5 | Genesys$month==-3 | Genesys$month==15 | Genesys$month==0 | Genesys$month==90 | Genesys$month==20] <- NA
#
# Genesys$day<-as.numeric(substr(Genesys$COLLDATE, 7,8))
# Genesys$day[Genesys$day==0] <- NA

# month_to_adjust<- nchar(Genesys$month)
# day_to_adjust<- nchar(Genesys$day)
# Genesys<-cbind(Genesys,month_to_adjust,day_to_adjust)
#
# Genesys$month<-with(Genesys, ifelse(Genesys$month_to_adjust == 1, paste0(0, month), paste0(month)))
# Genesys$day<-with(Genesys, ifelse(Genesys$day_to_adjust == 1, paste0(0, day), paste0(day)))

# Genesys<-Genesys[,c(1:6,8:12,14:16)]

# Delete rows where there is no information about the crop observed

# Genesys<-Genesys[!(is.na(Genesys$GENUS)) | !(is.na(Genesys$SPECIES))| !(is.na(Genesys$CROPNAME)),]

# Cleaning occurrences in the sea

# sea<-cc_sea(Genesys, lon = 'DECLONGITUDE', lat = 'DECLATITUDE', verbose=TRUE, value = "flagged")
# Genesys<-cbind(Genesys, sea)
# Genesys<-Genesys[Genesys$sea=='TRUE',]

# Cleaning country codes

# Genesys$ORIGCTY <- replace(Genesys$ORIGCTY, Genesys$ORIGCTY == "ROM",
#                            "SAU")
# Genesys$ORIGCTY <- replace(Genesys$ORIGCTY, Genesys$ORIGCTY == "SCG",
#                            "SAU")
# Genesys$ORIGCTY <- replace(Genesys$ORIGCTY, Genesys$ORIGCTY == "YUG",
#                            "SAU")
# Genesys$country_name<-countrycode(Genesys$ORIGCTY, origin='iso3c', destination='country.name')

# saveRDS(Genesys, path = paste0(cluster_data,"/raw/4/processed/Genesys_first_cleaning.rds"))
# file moved to the computer



Genesys<-readRDS("I:/MAS/01_data/LUCKINet/output/point data/point database/raw/4/processed/Genesys_first_cleaning.rds")

unique_combination<-unique(Genesys[,c('GENUS','SPECIES','SUBTAXA','CROPNAME')])

# saving the file for manual cleaning
#write.csv(unique_combination,'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/4/processed/matching.csv')

# reading again the file and assigning the codes to the observations
Genesys_matching<-read.csv('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/4/processed/matching.csv')
Genesys_matching<-Genesys_matching[!(Genesys_matching$luck_ID=="D"),]
Genesys<-Genesys %>% inner_join (Genesys_matching, by=c('GENUS',"SPECIES",'SUBTAXA','CROPNAME'))
Genesys<-merge(x = Genesys, y = ontology, by = "luck_ID")

# to be added to the ontology

to_be_added<-Genesys[,c(1,18)]
to_be_added<-to_be_added %>% distinct(luck_ID,extracted_term)
names(to_be_added)[2]<-'data_ID_4'
write.csv(to_be_added,'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/4/processed/to_be_added.csv')

# standardizing the columns structure and renaming them

# colnames(Genesys)[2] <- 'point_ID'
# colnames(Genesys)[3] <- 'genus'
# colnames(Genesys)[4] <- 'species'
# colnames(Genesys)[5] <- 'scientificName'
# colnames(Genesys)[6] <- 'generic_name'
# Genesys$ORIGCTY<-countrycode(Genesys$ORIGCTY, origin='iso3c', destination='iso2c')
#
# colnames(Genesys)[7] <- 'NUTS0'
# colnames(Genesys)[8] <- 'lat'
# colnames(Genesys)[9] <- 'long'
# colnames(Genesys)[17] <- 'country_fullname'


# drops<-c('COORDDATUM','GEOREFMETH','sea','extracted_term','faoID')
# Genesys<-Genesys[,!(names(Genesys) %in% drops)]
# Genesys<-Genesys[,1:15]
# colnames(Genesys)[10] <- 'GPS_prec'
# Genesys$province<-NA
# Genesys$locality<-NA
# Genesys$obs_type<-NA
# Genesys$land_use <-NA

# unique

# Genesys<-Genesys %>% distinct(year,month, lat, long, luck_name,.keep_all = TRUE)


# saving the file organized per country

# SE: skipping this, because atm I would save them per dataset and not per country.

# mylist <- split (Genesys, Genesys$country_fullname)
#
# i=1
# for(i in 1:length(mylist)){
#   y=names(mylist)[i]
#   saveRDS(mylist[[i]], file=paste0('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/4/processed/per_country/',y,'.rds'))
#   print(paste("loop i: ", i, " done"))
# }

# Cleaning occurrences outside country borders

# SE: skipping this, because the QC already contains information on whether the
# point is potentially flawed, and the country code has been recreated for all
# points by intersecting with the internal data 'countries', so any data-point
# without country can simply be foudn by filtering on that

# files<-list.files(path = paste0(MAS_data,'/raw/4/processed/per_country'), pattern = ".rds", full.names = T) %>%
#   lapply(readRDS)
#
# i=1
# for(i in 1:length(files)) {
#   y=(unique(files[[i]][["NUTS0"]]))
#   country<-files[[i]]
#   xy<-data.matrix(country[,c(9,8)])
#   country_shape<-SpatialPointsDataFrame(coords = xy, data=country, proj4string = CRS("+proj=longlat +datum=WGS84"))
#   countries<-countriesCoarse
#   shape<-countries[countries@data$ISO_A2==y,]
#   out<- point.in.poly(country_shape, shape)
#   first<-out@data
#   matching <- subset(first, ISO_A2==y)
#
#   # 1st loop (+lat/+log)
#   first_loop<-subset(first, is.na(ISO_A2))
#
#   if (nrow(first_loop)>0){
#     first_loop$LATITUDE<-abs(first_loop$lat)
#     first_loop$LONG<-abs(first_loop$long)
#     xy_first <- data.matrix(first_loop[,c(9,8)])
#     first_loop_shape<-SpatialPointsDataFrame(coords = xy_first, data=first_loop[,1:19], proj4string = CRS("+proj=longlat +datum=WGS84"))
#     out_first<- point.in.poly(first_loop_shape, shape)
#     second_loop<-out_first@data
#     matching2<- subset(second_loop, ISO_A2==y)
#
#     # 2nd loop (-lat/-log)
#     second_loop<-subset(second_loop, is.na(ISO_A2))
#     second_loop$LATITUDE<-second_loop$lat*-1
#     second_loop$LONG<-second_loop$long*-1
#     xy_second <- data.matrix(second_loop[,c(9,8)])
#     second_loop_shape<-SpatialPointsDataFrame(coords = xy_second, data=second_loop[,1:19], proj4string = CRS("+proj=longlat +datum=WGS84"))
#     out_second<- point.in.poly(second_loop_shape, shape)
#     third_loop<-out_second@data
#     matching3<- subset(third_loop, ISO_A2==y)
#
#     # 3rd loop (+lat/-log)
#     third_loop<-subset(third_loop, is.na(ISO_A2))
#     third_loop$LATITUDE<-abs(third_loop$lat)
#     xy_third <- data.matrix(third_loop[,c(9,8)])
#     third_loop_shape<-SpatialPointsDataFrame(coords = xy_third, data=third_loop[,1:19], proj4string = CRS("+proj=longlat +datum=WGS84"))
#     out_third<- point.in.poly(third_loop_shape, shape)
#     forth_loop<-out_third@data
#     matching4<- subset(forth_loop, ISO_A2==y)
#
#     # 4th loop (-lat/+log)
#     forth_loop<-subset(forth_loop, is.na(ISO_A2))
#     forth_loop$LATITUDE<-forth_loop$lat*-1
#     forth_loop$LONG<-abs(forth_loop$long)
#     xy_forth <- data.matrix(forth_loop[,c(9,8)])
#     forth_loop_shape<-SpatialPointsDataFrame(coords = xy_forth, data=forth_loop[,1:19], proj4string = CRS("+proj=longlat +datum=WGS84"))
#     out_forth<- point.in.poly(forth_loop_shape, shape)
#     fifth_loop<-out_forth@data
#     matching5<- subset(fifth_loop, ISO_A2==y)
#
#     cleaned<-rbind(matching,matching2,matching3,matching4,matching5)
#     cleaned<-cleaned[,1:19]
#   }else{
#     cleaned<-matching [,1:19]
#   }
#
#   setwd('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/4/processed/geo_cleaned')
#
#   saveRDS(cleaned, file=paste0('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/4/processed/geo_cleaned/',y,'_geocleaned.rds'))
#
#   print(paste("loop i: ", i, " done"))
#
# }


to_be_added<-read.csv('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/4/processed/to_be_added.csv')

list <- split (to_be_added, to_be_added$luck_ID)

i=1

for (i in 1:length(list))
{
  luck_ID=names(list)[i]
  data_ID_4<-concatenate(list[[i]][["data_ID_4"]], collapse = ";", rm.space = FALSE)
  extracted<-cbind(luck_ID,data_ID_4)
  extracted<-as.data.frame(extracted)
  saveRDS(extracted, file=paste0('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/4/processed/extracted_terms/',i,'.rds'))
}

extracted<-list.files('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/4/processed/extracted_terms', pattern = ".rds", full.names = T) %>%
  map(readRDS) %>%
  bind_rows()

ontology<-full_join(x = ontology, y = extracted, by = "luck_ID")

write.csv(ontology,'C:/Users/cb58hypi/source/luckinet_ontology_alpha200424.csv')
write.csv(ontology,'I:/MAS/01_data/LUCKINet/archive/luckinet_ontology_alpha200424.csv')



