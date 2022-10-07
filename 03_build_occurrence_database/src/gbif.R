# script arguments ----
#
thisDataset <- ""
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "",
           url = "http://api.gbif.org/v1/occurrence/download/request/0022170-181108115102211.zip",
           type = "",
           licence = "",
           bibliography = bib,
           update = )


# preprocess data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#

data <- read_csv(paste0(thisPath, ""))


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

# before preparing data for storage, test that all required variables are available
assertNames(x = names(temp),
            must.include = c("datasetID", "fid", "country", "x", "y", "epsg",
                             "year", "month", "day", "irrigated",
                             "externalID", "externalValue", "LC1_orig", "LC2_orig", "LC3_orig",
                             "sample_type", "collector", "purpose"))


# write output ----
#
saveDataset(object = geom, dataset = thisDataset)

# from Caterina ----
#

```{bash extracting GBIF core darwin}

cd /gpfs1/data/idiv_meyer/01_projects/Caterina/raw/1
wget http://api.gbif.org/v1/occurrence/download/request/0022170-181108115102211.zip
unzip GBIF.zip
awk 'BEGIN { FS = "\t" } ; { print $1 FS $37 FS $62 FS $64 FS $68 FS $69 FS $103 FS $104 FS $105 FS $121 FS $122 FS $123 FS $124 FS $125 FS $133 FS $134 FS $135 FS $136 FS $183 FS $191 FS $192 FS $193 FS $194 FS $195 FS $196 FS $207 FS $216 FS $218 FS $219 FS $230 FS $231}' occurrence.txt > selected_columns.csv
cd /gpfs1/data/idiv_meyer/01_projects/Caterina/raw/1
split -l 10000000 selected_columns.txt
awk '{if (NR!=1) {print}}' xaa > header.csv
sed -i '1d' xaa

```


# Preparing names to be extracted from GBIF
ontology$split<-str_count(ontology$luck_ID, pattern = "_")

# preparing the scientific names
scientificNames<-as.character(ontology$luck_name[ontology$split==5])

# preparing the synonyms of the scientific names
ontology<-separate_rows(ontology,synonyms_scientific_name, sep = ';')
scientificNames_synonyms<-ontology$synonyms_scientific_name
scientificNames_synonyms<-scientificNames_synonyms[!is.na(scientificNames_synonyms)]

# combining the 2 vectors to define all the names to be extracted from GBIF
extracted<-combine(scientificNames,scientificNames_synonyms)
extracted<-unique(extracted)

i=1
for(i in seq_along(extracted)){

  name_meta <- name_backbone(name=extracted[i])
  original_extracted<-extracted[i]
  name_meta<-cbind(original_extracted,name_meta)
  setwd("I:/MAS/01_data/LUCKINet/output/point data/point database/raw/1/")
  saveRDS(name_meta,file=(paste0("name_meta_",i,'.rds')))
  print(i)
}
# files moved to the cluster

# putting together the file on the cluster
all<-list.files(path = "/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/1/processed/extracted_names/", full.names = T) %>%
  lapply(readRDS) %>%
  bind_rows

# saving the file which was moved to the cluster
saveRDS(all, saveRDS(all, '/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/1/processed/extracted_names/ALL_extracted.rds'))


# libraries

library('tidyverse')
library('data.table')
library("readxl")
library('countrycode')
library('CoordinateCleaner')
library('memisc')

# calling the GBIF names to be extracted

ALL_extracted<-readRDS('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/1/processed/extracted_names/ALL_extracted.rds')
words<-str_count(ALL_extracted$original_extracted, '\\w+')

ALL_extracted<-cbind(ALL_extracted,words)

species_GBIF<-ALL_extracted[ALL_extracted[, "words"] == 2 | ALL_extracted[, "words"] == 3,]
species_of_interest<-species_GBIF[,15] # species to be extracted from GBIF
species_of_interest<-species_of_interest[!is.na(species_of_interest)]
species_of_interest<-unique(species_of_interest)

genus_GBIF<-ALL_extracted[ALL_extracted[, "words"] == 1,]
genus_of_interest<-genus_GBIF[,14] # genus to be extracted from GBIF
genus_of_interest<-genus_of_interest[!is.na(genus_of_interest)]
genus_of_interest<-unique(genus_of_interest)

varieties_GBIF<-ALL_extracted[ALL_extracted[, "words"] > 3,]
varieties_of_interest<-varieties_GBIF[,4]
varieties_of_interest<-varieties_of_interest[!is.na(varieties_of_interest)]
varieties_of_interest<-unique(varieties_of_interest)


# uploading GBIF data and starting some cleaning

header<-read.table('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/1/processed/header',sep="\t",header=T,fill=T,quote='\'')
file_names<-list.files('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/1/processed/selected_columns')
setwd('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/1/processed/selected_columns')
i=as.integer(Sys.getenv('SGE_TASK_ID'))
table<-fread(file_names[i])
names(table) <- names(header)
table<-table[(!table$decimalLatitude=='NA'),]
table<-table[(!table$decimalLatitude==''),]
table<-table[(!table$decimalLatitude==0),]
table<-table[(!table$decimalLongitude=='NA'),]
table<-table[(!table$decimalLongitude==''),]
table<-table[(!table$decimalLongitude==0),]
table<-table[(!table$year==''),]
table<-table[!duplicated(table[1]),] # to deleted records with duplicate gbifID
table<-table[(!table$countryCode==''),]
table<-table[(!table$countryCode=='NA'),]

# cleaning the date of observation

year_to_adjust<- nchar(table$year)
month_to_adjust<- nchar(table$month)
day_to_adjust<- nchar(table$day)
GBIF<-cbind(table,year_to_adjust,month_to_adjust,day_to_adjust)
GBIF<-GBIF[GBIF$year_to_adjust==4,]
GBIF$day<-with(GBIF, ifelse(GBIF$day_to_adjust == 1, paste0(0, day), paste0(day)))
GBIF$month<-with(GBIF, ifelse(GBIF$month_to_adjust == 1, paste0(0, month), paste0(month)))

# selecting columns and species/genus/varieties of interest from GBIF

GBIF<-GBIF[,c(4,7:11,13:19,25,30)]

selected_species<-subset(GBIF, (species %in% species_of_interest))
selected_species<- inner_join(selected_species, species_GBIF, by = "species")
selected_species<-selected_species[,c(1:16)]
names(selected_species)[13] <- "scientificName"
names(selected_species)[14] <- "genus"
selected_species$real_extracted<-selected_species$species

selected_genus<-subset(GBIF, (genus %in% genus_of_interest))
selected_genus<- inner_join(selected_genus, genus_GBIF, by = "genus")
selected_genus<-selected_genus[,c(1:16)]
names(selected_genus)[13] <- "scientificName"
names(selected_genus)[15] <- "species"
selected_genus$real_extracted<-selected_genus$genus

selected_variety<-subset(GBIF, (scientificName %in% varieties_of_interest))
selected_variety<- inner_join(selected_variety, varieties_GBIF, by = "scientificName")
selected_variety<-selected_variety[,c(1:16)]
names(selected_variety)[14] <- "genus"
names(selected_variety)[15] <- "species"
selected_variety$real_extracted<-selected_variety$scientificName

# binding different tables extracted in one GBIF file

GBIF<-rbind(selected_species,selected_genus,selected_variety)

# extracting the full country name

GBIF$GBIF_country_name<-countrycode(GBIF$countryCode, origin='iso2c', destination='country.name')

# further cleaning with CoordinateCleaner package

selected_species<- GBIF %>%
  cc_inst(lon = 'decimalLongitude', lat = 'decimalLatitude', buffer=1000) %>% # Removes or flags records assigned to the location of zoos, botanical gardens, herbaria, universities and museums
  cc_sea(lon = 'decimalLongitude', lat = 'decimalLatitude') # Removes or flags coordinates outside the reference landmass


#saving the data

saveRDS(selected_species,paste0("/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/1/processed/selected_species/selected_species_", i ,'.rds'))


library(sf)
library(tidyverse)
library(data.table)

all_species<-list.files(path = "/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/1/processed/selected_species", full.names = T)
binded<-rbindlist(lapply(all_species, readRDS))

print("read all rds files")

binded <- as.data.table(binded)

mylist <- split (binded, by='GBIF_country_name')

print("created mylist")

i=1
for(i in 1:length(mylist)){
  y=names(mylist)[i]
  saveRDS(mylist[[i]], file=paste0('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/1/processed/per_country/',y,'.rds'))
  print(paste("loop i: ", i, " done"))
}


# libraries

library(tidyverse)
library(countrycode)
library(rworldmap)
library(spatialEco)
library(CoordinateCleaner)

# Calling the files organized per country

file_names<-list.files('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/1/processed/per_country/',pattern = ".rds")
setwd('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/1/processed/per_country/')
i=as.integer(Sys.getenv('SGE_TASK_ID'))

# Checking all possible combination of coordinates to save some points

country<-readRDS(file_names[i])
y=as.factor(unique(country$GBIF_country_name))
xy<-data.matrix(country[,c(10,9)])
country_shape<-SpatialPointsDataFrame(coords = xy, data=country, proj4string = CRS("+proj=longlat +datum=WGS84"))
y<-countrycode(y, origin='country.name', destination='iso2c')
countries<-countriesCoarse
shape<-countries[countries@data$ISO_A2==y,]
out<- point.in.poly(country_shape, shape)
first<-out@data
matching <- subset(first, ISO_A2==y)

# 1st loop (+lat/+log)
first_loop<-subset(first, is.na(ISO_A2))
if (nrow(first_loop)>0){
  first_loop$decimalLatitude<-abs(first_loop$decimalLatitude)
  first_loop$decimalLongitude<-abs(first_loop$decimalLongitude)
  xy_first <- data.matrix(first_loop[,c(10,9)])
  first_loop_shape<-SpatialPointsDataFrame(coords = xy_first, data=first_loop[,1:19], proj4string = CRS("+proj=longlat +datum=WGS84"))
  out_first<- point.in.poly(first_loop_shape, shape)
  second_loop<-out_first@data
  matching2<- subset(second_loop, ISO_A2==y)

  # 2nd loop (-lat/-log)
  second_loop<-subset(second_loop, is.na(ISO_A2))
  second_loop$decimalLatitude<-second_loop$decimalLatitude*-1
  second_loop$decimalLongitude<-second_loop$decimalLongitude*-1
  xy_second <- data.matrix(second_loop[,c(10,9)])
  second_loop_shape<-SpatialPointsDataFrame(coords = xy_second, data=second_loop[,1:19], proj4string = CRS("+proj=longlat +datum=WGS84"))
  out_second<- point.in.poly(second_loop_shape, shape)
  third_loop<-out_second@data
  matching3<- subset(third_loop, ISO_A2==y)

  # 3rd loop (+lat/-log)
  third_loop<-subset(third_loop, is.na(ISO_A2))
  third_loop$decimalLatitude<-abs(third_loop$decimalLatitude)
  xy_third <- data.matrix(third_loop[,c(10,9)])
  third_loop_shape<-SpatialPointsDataFrame(coords = xy_third, data=third_loop[,1:19], proj4string = CRS("+proj=longlat +datum=WGS84"))
  out_third<- point.in.poly(third_loop_shape, shape)
  forth_loop<-out_third@data
  matching4<- subset(forth_loop, ISO_A2==y)

  # 4th loop (-lat/+log)
  forth_loop<-subset(forth_loop, is.na(ISO_A2))
  forth_loop$decimalLatitude<-forth_loop$decimalLatitude*-1
  forth_loop$decimalLongitude<-abs(forth_loop$decimalLongitude)
  xy_forth <- data.matrix(forth_loop[,c(10,9)])
  forth_loop_shape<-SpatialPointsDataFrame(coords = xy_forth, data=forth_loop[,1:19], proj4string = CRS("+proj=longlat +datum=WGS84"))
  out_forth<- point.in.poly(forth_loop_shape, shape)
  fifth_loop<-out_forth@data
  matching5<- subset(fifth_loop, ISO_A2==y)

  cleaned<-rbind(matching,matching2,matching3,matching4,matching5)
  cleaned<-cleaned[,1:19]
}else{
  cleaned<-matching [,1:19]
}
setwd('/gpfs1/data/idiv_meyer/01_projects/Caterina/data/1/cleaned_new')
saveRDS(cleaned, file=paste0('/gpfs1/data/idiv_meyer/01_projects/Caterina/data/1/cleaned_new/',y,'_geocleaned.rds'))
print(paste("loop i: ", i, " done"))


library(tidyverse)
library(data.table)

# calling the cleaned GBIF files
GBIF<-list.files(path = "/gpfs1/data/idiv_meyer/01_projects/Caterina/data/1", full.names = T)

GBIF<-rbindlist(lapply(GBIF, readRDS))

print('file complete')

GBIF$unique_ID<-1:nrow(GBIF) #to count the unique GBIF_rows

# calling the ontology
ontology<-read.csv('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/luckinet_ontology_alpha200424.csv')

ontology<-separate_rows(ontology,synonyms_scientific_name, sep = ';')

ontology$luck_ID<-as.character(ontology$luck_ID)

# associating the extracted names to the luck_ID and luck_name in the ontology

names(GBIF)[16]<-'luck_name'

match<-left_join(GBIF, ontology, by='luck_name')

match<-match %>% distinct(unique_ID,.keep_all = TRUE)

names<-match[!is.na(match$luck_ID),]

names<-names[,c(1:15,17:18,20)]

print('associated names')

synonyms<-match[is.na(match$luck_ID),]

synonyms<-synonyms[,1:19]

names(synonyms)[16]<-'synonyms_scientific_name'

synonyms<-left_join(synonyms, ontology, by='synonyms_scientific_name')

synonyms<-synonyms%>% distinct(unique_ID,.keep_all = TRUE)

synonyms<-synonyms[,c(1:15,17:18,20)]

print('associated synonyms')

GBIF<-rbind(synonyms,names)

GBIF$unique_ID<-1:nrow(GBIF)

GBIF<-left_join(GBIF, ontology, by='luck_ID')

GBIF<-GBIF%>% distinct(unique_ID,.keep_all = TRUE)

GBIF<-GBIF[,c(1:18,20:21)]

print('associated all names to GBIF')

# preparing standardized columns for the final database

GBIF$point_ID<-NA

names(GBIF)[1]<-'obs_type'

names(GBIF)[5]<-'NUTS0'

names(GBIF)[6]<-'province'

names(GBIF)[8]<-'locality'

names(GBIF)[9]<-'lat'

names(GBIF)[10]<-'long'

names(GBIF)[12]<-'GPS_prec'

names(GBIF)[17]<-'country_fullname'

drops<-c('municipality','coordinateUncertaintyInMeters','faoID')

GBIF<-GBIF[,!(names(GBIF) %in% drops)]

GBIF$land_use<-NA

print('standardized')


# extracted names from GBIF to be added to the ontology

to_be_added<-GBIF[,c(16,14)]

to_be_added<- to_be_added %>% distinct(luck_ID, real_extracted)

names(to_be_added)[2]<-'data_ID_1'

write.csv(to_be_added,'/gpfs1/data/idiv_meyer/01_projects/Caterina/data/1/to_be_added.csv')

# the file was then moved to the computer
print('to_be_added file extracted')

# removing real extracted from the database, and clean for unique luck_names at the same coordinates
drops<-'real_extracted'

GBIF<-GBIF[,!(names(GBIF) %in% drops)]

GBIF<-GBIF %>% distinct(year, month, lat, long, luck_name,.keep_all = TRUE)

GBIF$generic_name<-NA

rows<-nrow(GBIF)
print(rows)

saveRDS(GBIF, '/gpfs1/data/idiv_meyer/01_projects/Caterina/data/1/GBIF.rds')



library(tidyverse)
library(data.table)
library(ngram)

to_be_added<-read.csv('/gpfs1/data/idiv_meyer/01_projects/Caterina/data/1/to_be_added.csv')

list <- split (to_be_added, to_be_added$luck_ID)

i=1

for (i in 1:length(list))
{
  luck_ID=names(list)[i]
  data_ID_1<-concatenate(list[[i]][["data_ID_1"]], collapse = ";", rm.space = FALSE)
  extracted<-cbind(luck_ID,data_ID_1)
  extracted<-as.data.frame(extracted)
  saveRDS(extracted, file=paste0('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/1/processed/extracted_names/',i,'.rds'))
}


library(tidyverse)
library(data.table)
library(ngram)

ontology<-read.csv('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/luckinet_ontology_alpha200424.csv')

extracted<-list.files('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/1/processed/extracted_names/', pattern = ".rds", full.names = T) %>%
  map(readRDS) %>%
  bind_rows()

print('full file')

ontology<-full_join(x = ontology, y = extracted, by = "luck_ID")
print('match with ontology')

ontology<-write.csv(ontology,'/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/luckinet_ontology_GBIF.csv')

print('saved ontology')

