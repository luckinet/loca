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




# author and date of creation ----
#
# Caterina Barasso, 2020
# Steffen Ehrmann, 13.09.2021
# Peter Pothmann,
# Konrad Adler,


# script description ----
#
# This document serves as a protocol, documenting the process of building the
# database of point data for LUCKINet. Don't run this script manually, as it is
# sourced from 'build_global_pointDB.R'.


# load packages ----
#


# script arguments ----
#
thisDataset <- ""
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "",
           url = "https://planet.openstreetmap.org/planet/full-history/", # ideally the doi, but if it doesn't have one, the main source of the database
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

data <- read_csv(paste0(thisPath, ""))


# harmonise data ----
#
temp <- data %>%
  ... %>%
  select(fid, x, y, precision, country, year, month, day, irrigated, datasetID, luckinetID,
         externalID, externalValue, externalLC, sample_type, everything())

# before preparing data for storage, test that all variables are available
assertNames(x = names(temp),
            must.include = c("fid", "x", "y", "precision", "country", "year", "month",
                             "day", "irrigated", "datasetID", "luckinetID", "externalID",
                             "externalValue", "externalLC", "sample_type"))

# make points and attributes table
points <- temp %>%
  select(fid, x, y)

attributes <- temp %>%
  select(-x, -y)

# make a point geom and set the attribute table
geom <- points %>%
  gs_point() %>%
  setFeatures(table = attributes)

# extract column names to harmonise them
meta <- tibble(datasetID = thisDataset,
               region = "",
               column = colnames(data),
               harmonised = rep(NA, length(colnames(data))), # replace with harmonised names in 'temp'
               records = nrow(data)) %>%
  bind_rows(meta) %>%
  distinct()


# write output ----
#
write_csv(meta, paste0(dataDir, "availability_point_data.csv"), na = "")
saveDataset(object = geom, dataset = thisDataset)


# # from Caterina ----
# #
# # SOURCES OF INFORMATION:
# #
# #   https://osmcode.org/osmium-tool/manual.html
# # https://docs.osmcode.org/osmium/latest/
# #   https://wiki.openstreetmap.org/wiki/Elements
# # https://wiki.openstreetmap.org/wiki/Map_Features
#
#
# ```{bash}
#
# ml purge
# ml foss/2018b osmium-tool/1.12.0
#
# cd /gpfs1/data/idiv_meyer/00_data/original/OSM
#
# wget https://planet.openstreetmap.org/pbf/full-history/history-latest.osm.pbf
#
# #  history file divided per year
#
# osmium time-filter history-latest.osm.pbf  2005-01-01T00:00:00Z 2005-12-31T00:00:00Z -o 2005.osh.pbf
#
# osmium time-filter history-latest.osm.pbf  2006-01-01T00:00:00Z 2006-12-31T00:00:00Z -o 2006.osh.pbf
#
# osmium time-filter history-latest.osm.pbf  2007-01-01T00:00:00Z 2007-12-31T00:00:00Z -o 2007.osh.pbf
#
# osmium time-filter history-latest.osm.pbf  2008-01-01T00:00:00Z 2008-12-31T00:00:00Z -o 2008.osh.pbf
#
# osmium time-filter history-latest.osm.pbf  2009-01-01T00:00:00Z 2009-12-31T00:00:00Z -o 2009.osh.pbf
#
# osmium time-filter history-latest.osm.pbf  2010-01-01T00:00:00Z 2010-12-31T00:00:00Z -o 2010.osh.pbf
#
# osmium time-filter history-latest.osm.pbf  2012-01-01T00:00:00Z 2012-12-31T00:00:00Z -o 2012.osh.pbf
#
# osmium time-filter history-latest.osm.pbf  2013-01-01T00:00:00Z 2013-12-31T00:00:00Z -o 2013.osh.pbf
#
# osmium time-filter history-latest.osm.pbf  2014-01-01T00:00:00Z 2014-12-31T00:00:00Z -o 2014.osh.pbf
#
# osmium time-filter history-latest.osm.pbf  2015-01-01T00:00:00Z 2015-12-31T00:00:00Z -o 2015.osh.pbf
#
# osmium time-filter history-latest.osm.pbf  2016-01-01T00:00:00Z 2016-12-31T00:00:00Z -o 2016.osh.pbf
#
# osmium time-filter history-latest.osm.pbf  2017-01-01T00:00:00Z 2017-12-31T00:00:00Z -o 2017.osh.pbf
#
# osmium time-filter history-latest.osm.pbf  2018-01-01T00:00:00Z 2018-12-31T00:00:00Z -o 2018.osh.pbf
#
# osmium time-filter history-latest.osm.pbf  2019-01-01T00:00:00Z 2019-12-31T00:00:00Z -o 2019.osh.pbf
#
# osmium time-filter history-latest.osm.pbf  2020-01-01T00:00:00Z 2020-12-31T00:00:00Z -o 2020.osh.pbf
#
#
# ## tags of interest extracted from the nodes per year
#
# cd /gpfs1/data/idiv_meyer/01_projects/Caterina/raw/3
#
# # extracting farmland points
# for filename in *.osh.pbf
# do
# echo $filename
# osmium tags-filter $filename n/landuse=farmland -o farmland.$filename.osm.pbf
# done
#
# # extracting forest points
# for filename in *.osh.pbf
# do
# echo $filename
# osmium tags-filter $filename n/landuse=forest -o forest.$filename.osm.pbf
# done
#
# # extracting meadow points
# for filename in *.osh.pbf
# do
# echo $filename
# osmium tags-filter $filename n/landuse=meadow -o meadow.$filename.osm.pbf
# done
#
# # extracting orchard points
# for filename in *.osh.pbf
# do
# echo $filename
# osmium tags-filter $filename n/landuse=orchard -o orchard.$filename.osm.pbf
# done
#
# # extracting vineyard points
# for filename in *.osh.pbf
# do
# echo $filename
# osmium tags-filter $filename n/landuse=vineyard -o vineyard.$filename.osm.pbf
# done
#
# ## converting from pbf to xml format
#
# for filename in *.osm.pbf
# do
# echo $filename
# osmium cat $filename -o $filename.osm.xml
# done
#
# ```
#
#
# ## files moved from cluster to MAS
#
# library(data.table)
#
# library(osmar)
#
# library(tidyverse)
#
# library(plyr)
#
# setwd('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3')
#
# ############################################
# ################farmland####################
# ############################################
#
# files<-list.files(pattern = "farmland.*.xml", full.names = T)
#
# # reading the files
#
# farmland_2008<-as_osmar(xmlParse("./farmland.2008.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2009<-as_osmar(xmlParse("./farmland.2009.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2010<-as_osmar(xmlParse("./farmland.2010.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2011<-as_osmar(xmlParse("./farmland.2011.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2012<-as_osmar(xmlParse("./farmland.2012.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2013<-as_osmar(xmlParse("./farmland.2013.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2014<-as_osmar(xmlParse("./farmland.2014.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2015<-as_osmar(xmlParse("./farmland.2015.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2016<-as_osmar(xmlParse("./farmland.2016.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2017<-as_osmar(xmlParse("./farmland.2017.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2018<-as_osmar(xmlParse("./farmland.2018.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2019<-as_osmar(xmlParse("./farmland.2019.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2020<-as_osmar(xmlParse("./farmland.2020.osh.pbf.osm.pbf.osm.xml"))
#
# # extracing the important information from all files
#
# ##2008
# farmland_2008<-farmland_2008[["nodes"]]
# tags_2008<-farmland_2008[["tags"]]
# ids_2008<-unique(tags_2008$id)
# #write.csv(ids_2008, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/farmland_2008.csv')
#
# ##2009
# farmland_2009<-farmland_2009[["nodes"]]
# tags_2009<-farmland_2009[["tags"]]
# ids_2009<-unique(tags_2009$id)
# #write.csv(ids_2009, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/farmland_2009.csv')
#
# ##2010
# farmland_2010<-farmland_2010[["nodes"]]
# tags_2010<-farmland_2010[["tags"]]
# ids_2010<-unique(tags_2010$id)
# #write.csv(ids_2010, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/farmland_2010.csv')
#
# ##2011
# farmland_2011<-farmland_2011[["nodes"]]
# tags_2011<-farmland_2011[["tags"]]
# ids_2011<-unique(tags_2011$id)
# #write.csv(ids_2011, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/farmland_2011.csv')
#
# ##2012
# farmland_2012<-farmland_2012[["nodes"]]
# tags_2012<-farmland_2012[["tags"]]
# ids_2012<-unique(tags_2012$id)
# #write.csv(ids_2012, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/farmland_2012.csv')
#
# ##2013
# farmland_2013<-farmland_2013[["nodes"]]
# tags_2013<-farmland_2013[["tags"]]
# ids_2013<-unique(tags_2013$id)
# ids_2013<-as.data.frame(ids_2013)
# names(ids_2013)[1] <- "id"
# crop_2013<-tags_2013[tags_2013$k=='crop',] # it is the first year where actually a crop is recorded
# class_2013<-crop_2013[,c(1,3)]
# ids_2013<-join(ids_2013,class_2013,by='id', type = "left")
# names(ids_2013)[2] <- "class"
# #write.csv(ids_2013, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/farmland_2013.csv')
#
# ##2014
# farmland_2014<-farmland_2014[["nodes"]]
# tags_2014<-farmland_2014[["tags"]]
# ids_2014<-unique(tags_2014$id)
# ids_2014<-as.data.frame(ids_2014)
# names(ids_2014)[1] <- "id"
# crop_2014<-tags_2014[tags_2014$k=='crop',]
# class_2014<-crop_2014[,c(1,3)]
# ids_2014<-join(ids_2014,class_2014,by='id', type = "left")
# names(ids_2014)[2] <- "class"
# #write.csv(ids_2014, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/farmland_2014.csv')
#
# ##2015
# farmland_2015<-farmland_2015[["nodes"]]
# tags_2015<-farmland_2015[["tags"]]
# ids_2015<-unique(tags_2015$id)
# ids_2015<-as.data.frame(ids_2015)
# names(ids_2015)[1] <- "id"
# crop_2015<-tags_2015[tags_2015$k=='crop',]
# crop_2015<-crop_2015[,c(1,3)]
# produce_2015<-tags_2015[tags_2015$k=='produce',]
# produce_2015<-produce_2015[,c(1,3)]
# trees_2015<-tags_2015[tags_2015$k=='trees',]
# trees_2015<-trees_2015[,c(1,3)]
# livestock_2015<-tags_2015[tags_2015$k=='livestock',]
# livestock_2015<-livestock_2015[,c(1,3)]
# class_2015<-rbind(crop_2015,produce_2015,trees_2015,livestock_2015)
# ids_2015<-join(ids_2015,class_2015,by='id', type = "left")
# names(ids_2015)[2] <- "class"
# #write.csv(ids_2015, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/farmland_2015.csv')
#
# ##2016
# farmland_2016<-farmland_2016[["nodes"]]
# tags_2016<-farmland_2016[["tags"]]
# ids_2016<-unique(tags_2016$id)
# ids_2016<-as.data.frame(ids_2016)
# names(ids_2016)[1] <- "id"
# crop_2016<-tags_2016[tags_2016$k=='crop',]
# crop_2016<-crop_2016[,c(1,3)]
# produce_2016<-tags_2016[tags_2016$k=='produce',]
# produce_2016<-produce_2016[,c(1,3)]
# genus_2016<-tags_2016[tags_2016$k=='genus',]
# genus_2016<-genus_2016[,c(1,3)]
# livestock_2016<-tags_2016[tags_2016$k=='livestock',]
# livestock_2016<-livestock_2016[,c(1,3)]
# class_2016<-rbind(crop_2016,produce_2016,genus_2016,livestock_2016)
# ids_2016<-join(ids_2016,class_2016,by='id', type = "left")
# names(ids_2016)[2] <- "class"
# #write.csv(ids_2016, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/farmland_2016.csv')
#
# ##2017
# farmland_2017<-farmland_2017[["nodes"]]
# tags_2017<-farmland_2017[["tags"]]
# ids_2017<-unique(tags_2017$id)
# ids_2017<-as.data.frame(ids_2017)
# names(ids_2017)[1] <- "id"
# crop_2017<-tags_2017[tags_2017$k=='crop',]
# crop_2017<-crop_2017[,c(1,3)]
# crops_2017<-tags_2017[tags_2017$k=='crops',]
# crops_2017<-crops_2017[,c(1,3)]
# produce_2017<-tags_2017[tags_2017$k=='produce',]
# produce_2017<-produce_2017[,c(1,3)]
# genus_2017<-tags_2017[tags_2017$k=='genus',]
# genus_2017<-genus_2017[,c(1,3)]
# livestock_2017<-tags_2017[tags_2017$k=='livestock',]
# livestock_2017<-livestock_2017[,c(1,3)]
# tree_2017<-tags_2017[tags_2017$k=='trees',]
# tree_2017<-tree_2017[,c(1,3)]
# class_2017<-rbind(crop_2017,crops_2017,produce_2017,genus_2017,livestock_2017,tree_2017)
# ids_2017<-join(ids_2017,class_2017,by='id', type = "left")
# names(ids_2017)[2] <- "class"
# #write.csv(ids_2017, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/farmland_2017.csv')
#
# ##2018
# farmland_2018<-farmland_2018[["nodes"]]
# tags_2018<-farmland_2018[["tags"]]
# ids_2018<-unique(tags_2018$id)
# ids_2018<-as.data.frame(ids_2018)
# names(ids_2018)[1] <- "id"
# crop_2018<-tags_2018[tags_2018$k=='crop',]
# crop_2018<-crop_2018[,c(1,3)]
# produce_2018<-tags_2018[tags_2018$k=='produce',]
# produce_2018<-produce_2018[,c(1,3)]
# genus_2018<-tags_2018[tags_2018$k=='genus',]
# genus_2018<-genus_2018[,c(1,3)]
# livestock_2018<-tags_2018[tags_2018$k=='livestock',]
# livestock_2018<-livestock_2018[,c(1,3)]
# tree_2018<-tags_2018[tags_2018$k=='trees',]
# tree_2018<-tree_2018[,c(1,3)]
# class_2018<-rbind(crop_2018,produce_2018,genus_2018,livestock_2018,tree_2018)
# ids_2018<-join(ids_2018,class_2018,by='id', type = "left")
# names(ids_2018)[2] <- "class"
# #write.csv(ids_2018, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/farmland_2018.csv')
#
# ##2019
# farmland_2019<-farmland_2019[["nodes"]]
# tags_2019<-farmland_2019[["tags"]]
# ids_2019<-unique(tags_2019$id)
# ids_2019<-as.data.frame(ids_2019)
# names(ids_2019)[1] <- "id"
# crop_2019<-tags_2019[tags_2019$k=='crop',]
# crop_2019<-crop_2019[,c(1,3)]
# produce_2019<-tags_2019[tags_2019$k=='produce',]
# produce_2019<-produce_2019[,c(1,3)]
# livestock_2019<-tags_2019[tags_2019$k=='livestock',]
# livestock_2019<-livestock_2019[,c(1,3)]
# tree_2019<-tags_2019[tags_2019$k=='trees',]
# tree_2019<-tree_2019[,c(1,3)]
# class_2019<-rbind(crop_2019,produce_2019,livestock_2019,tree_2019)
# ids_2019<-join(ids_2019,class_2019,by='id', type = "left")
# names(ids_2019)[2] <- "class"
# #write.csv(ids_2019, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/farmland_2019.csv')
#
# ##2020
# farmland_2020<-farmland_2020[["nodes"]]
# tags_2020<-farmland_2020[["tags"]]
# ids_2020<-unique(tags_2020$id)
# ids_2020<-as.data.frame(ids_2020)
# names(ids_2020)[1] <- "id"
# crop_2020<-tags_2020[tags_2020$k=='crop',]
# crop_2020<-crop_2020[,c(1,3)]
# produce_2020<-tags_2020[tags_2020$k=='produce',]
# produce_2020<-produce_2020[,c(1,3)]
# tree_2020<-tags_2020[tags_2020$k=='trees',]
# tree_2020<-tree_2020[,c(1,3)]
# class_2020<-rbind(crop_2020,produce_2020,tree_2020)
# ids_2020<-join(ids_2020,class_2020,by='id', type = "left")
# names(ids_2020)[2] <- "class"
# #write.csv(ids_2020, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/farmland_2020.csv')
#
# ## assembling farmland file together
#
# setwd('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3')
#
# files<-list.files(pattern = "farmland.*.xml", full.names = T)
#
# # reading the files
#
# farmland_2008<-as_osmar(xmlParse("./farmland.2008.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2009<-as_osmar(xmlParse("./farmland.2009.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2010<-as_osmar(xmlParse("./farmland.2010.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2011<-as_osmar(xmlParse("./farmland.2011.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2012<-as_osmar(xmlParse("./farmland.2012.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2013<-as_osmar(xmlParse("./farmland.2013.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2014<-as_osmar(xmlParse("./farmland.2014.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2015<-as_osmar(xmlParse("./farmland.2015.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2016<-as_osmar(xmlParse("./farmland.2016.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2017<-as_osmar(xmlParse("./farmland.2017.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2018<-as_osmar(xmlParse("./farmland.2018.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2019<-as_osmar(xmlParse("./farmland.2019.osh.pbf.osm.pbf.osm.xml"))
#
# farmland_2020<-as_osmar(xmlParse("./farmland.2020.osh.pbf.osm.pbf.osm.xml"))
#
# # reading the matching
#
# setwd ('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed')
#
# matching_2008<-read.csv('farmland_2008.csv')
# matching_2009<-read.csv('farmland_2009.csv')
# matching_2010<-read.csv('farmland_2010.csv')
# matching_2011<-read.csv('farmland_2011.csv')
# matching_2012<-read.csv('farmland_2012.csv')
# matching_2013<-read.csv('farmland_2013.csv')
# matching_2014<-read.csv('farmland_2014.csv')
# matching_2015<-read.csv('farmland_2015.csv')
# matching_2016<-read.csv('farmland_2016.csv')
# matching_2017<-read.csv('farmland_2017.csv')
# matching_2018<-read.csv('farmland_2018.csv')
# matching_2019<-read.csv('farmland_2019.csv')
# matching_2020<-read.csv('farmland_2020.csv')
#
#
# # giving the class tag to the attribute table
#
# # 2008
# farmland_2008<-farmland_2008[["nodes"]]
# attrs_2008<-farmland_2008[["attrs"]]
# farmland_2008<-merge(x=attrs_2008,y=matching_2008,by="id",all=TRUE)
# drops<-c('visible','version','changeset','user','uid')
# farmland_2008<-farmland_2008[,!(names(farmland_2008) %in% drops)]
#
# # 2009
# farmland_2009<-farmland_2009[["nodes"]]
# attrs_2009<-farmland_2009[["attrs"]]
# farmland_2009<-merge(x=attrs_2009,y=matching_2009,by="id",all=TRUE)
# farmland_2009<-farmland_2009[,!(names(farmland_2009) %in% drops)]
#
# # 2010
# farmland_2010<-farmland_2010[["nodes"]]
# attrs_2010<-farmland_2010[["attrs"]]
# farmland_2010<-merge(x=attrs_2010,y=matching_2010,by="id",all=TRUE)
# farmland_2010<-farmland_2010[,!(names(farmland_2010) %in% drops)]
#
# # 2011
# farmland_2011<-farmland_2011[["nodes"]]
# attrs_2011<-farmland_2011[["attrs"]]
# farmland_2011<-merge(x=attrs_2011,y=matching_2011,by="id",all=TRUE)
# farmland_2011<-farmland_2011[,!(names(farmland_2011) %in% drops)]
#
# # 2012
# farmland_2012<-farmland_2012[["nodes"]]
# attrs_2012<-farmland_2012[["attrs"]]
# farmland_2012<-merge(x=attrs_2012,y=matching_2012,by="id",all=TRUE)
# farmland_2012<-farmland_2012[,!(names(farmland_2012) %in% drops)]
#
# # 2013
# farmland_2013<-farmland_2013[["nodes"]]
# attrs_2013<-farmland_2013[["attrs"]]
# farmland_2013<-merge(x=attrs_2013,y=matching_2013,by="id",all=TRUE)
# farmland_2013<-farmland_2013[,!(names(farmland_2013) %in% drops)]
#
# # 2014
# farmland_2014<-farmland_2014[["nodes"]]
# attrs_2014<-farmland_2014[["attrs"]]
# farmland_2014<-merge(x=attrs_2014,y=matching_2014,by="id",all=TRUE)
# farmland_2014<-farmland_2014[,!(names(farmland_2014) %in% drops)]
#
# # 2015
# farmland_2015<-farmland_2015[["nodes"]]
# attrs_2015<-farmland_2015[["attrs"]]
# farmland_2015<-merge(x=attrs_2015,y=matching_2015,by="id",all=TRUE)
# farmland_2015<-farmland_2015[,!(names(farmland_2015) %in% drops)]
#
# # 2016
# farmland_2016<-farmland_2016[["nodes"]]
# attrs_2016<-farmland_2016[["attrs"]]
# farmland_2016<-merge(x=attrs_2016,y=matching_2016,by="id",all=TRUE)
# farmland_2016<-farmland_2016[,!(names(farmland_2016) %in% drops)]
#
# # 2017
# farmland_2017<-farmland_2017[["nodes"]]
# attrs_2017<-farmland_2017[["attrs"]]
# farmland_2017<-merge(x=attrs_2017,y=matching_2017,by="id",all=TRUE)
# farmland_2017<-farmland_2017[,!(names(farmland_2017) %in% drops)]
#
# # 2018
# farmland_2018<-farmland_2018[["nodes"]]
# attrs_2018<-farmland_2018[["attrs"]]
# farmland_2018<-merge(x=attrs_2018,y=matching_2018,by="id",all=TRUE)
# farmland_2018<-farmland_2018[,!(names(farmland_2018) %in% drops)]
#
# # 2019
# farmland_2019<-farmland_2019[["nodes"]]
# attrs_2019<-farmland_2019[["attrs"]]
# farmland_2019<-merge(x=attrs_2019,y=matching_2019,by="id",all=TRUE)
# farmland_2019<-farmland_2019[,!(names(farmland_2019) %in% drops)]
#
# # 2020
# farmland_2020<-farmland_2020[["nodes"]]
# attrs_2020<-farmland_2020[["attrs"]]
# farmland_2020<-merge(x=attrs_2020,y=matching_2020,by="id",all=TRUE)
# farmland_2020<-farmland_2020[,!(names(farmland_2020) %in% drops)]
#
# # compiling the file
#
# farmland<-rbind(farmland_2008,farmland_2009,farmland_2010,farmland_2011,farmland_2012,farmland_2013,farmland_2014,farmland_2015,farmland_2016,farmland_2017,farmland_2018,farmland_2019,farmland_2020)
#
# # write.csv(farmland,'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/farmland.csv') file moved in the cluster because to difficult to process the forest part on my computer
#
#
# setwd('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3')
#
# ############################################
# ###############orchard######################
# ############################################
#
# files<-list.files(pattern = "farmland.*.xml", full.names = T)
#
# orchard_2009<-as_osmar(xmlParse("./orchard.2009.osh.pbf.osm.pbf.osm.xml"))
# orchard_2010<-as_osmar(xmlParse("./orchard.2010.osh.pbf.osm.pbf.osm.xml"))
# orchard_2011<-as_osmar(xmlParse("./orchard.2011.osh.pbf.osm.pbf.osm.xml"))
# orchard_2012<-as_osmar(xmlParse("./orchard.2012.osh.pbf.osm.pbf.osm.xml"))
# orchard_2013<-as_osmar(xmlParse("./orchard.2013.osh.pbf.osm.pbf.osm.xml"))
# orchard_2014<-as_osmar(xmlParse("./orchard.2014.osh.pbf.osm.pbf.osm.xml"))
# orchard_2015<-as_osmar(xmlParse("./orchard.2015.osh.pbf.osm.pbf.osm.xml"))
# orchard_2016<-as_osmar(xmlParse("./orchard.2016.osh.pbf.osm.pbf.osm.xml"))
# orchard_2017<-as_osmar(xmlParse("./orchard.2017.osh.pbf.osm.pbf.osm.xml"))
# orchard_2018<-as_osmar(xmlParse("./orchard.2018.osh.pbf.osm.pbf.osm.xml"))
# orchard_2019<-as_osmar(xmlParse("./orchard.2019.osh.pbf.osm.pbf.osm.xml"))
# orchard_2020<-as_osmar(xmlParse("./orchard.2020.osh.pbf.osm.pbf.osm.xml"))
#
# ## 2009
# orchard_2009<-orchard_2009[["nodes"]]
# tags_2009<-orchard_2009[["tags"]]
# ids_2009<-unique(tags_2009$id)
# #write.csv(ids_2009, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/orchard_2009.csv')
#
# ## 2010
# orchard_2010<-orchard_2010[["nodes"]]
# tags_2010<-orchard_2010[["tags"]]
# ids_2010<-unique(tags_2010$id)
# ids_2010<-as.data.frame(ids_2010)
# names(ids_2010)[1] <- "id"
# trees_2010<-tags_2010[tags_2010$k=='trees',]
# class_2010<-trees_2010[,c(1,3)]
# ids_2010<-join(ids_2010,class_2010,by='id', type = "left")
# names(ids_2010)[2] <- "class"
# #write.csv(ids_2010, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/orchard_2010.csv')
#
# ## 2011
# orchard_2011<-orchard_2011[["nodes"]]
# tags_2011<-orchard_2011[["tags"]]
# ids_2011<-unique(tags_2011$id)
# ids_2011<-as.data.frame(ids_2011)
# names(ids_2011)[1] <- "id"
# trees_2011<-tags_2011[tags_2011$k=='trees',]
# trees_2011<-trees_2011[,c(1,3)]
# produce_2011<-tags_2011[tags_2011$k=='produce',]
# produce_2011<-produce_2011[,c(1,3)]
# class_2011<-rbind(trees_2011,produce_2011)
# ids_2011<-join(ids_2011,class_2011,by='id', type = "left")
# names(ids_2011)[2] <- "class"
# #write.csv(ids_2011, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/orchard_2011.csv')
#
# ## 2012
# orchard_2012<-orchard_2012[["nodes"]]
# tags_2012<-orchard_2012[["tags"]]
# ids_2012<-unique(tags_2012$id)
# ids_2012<-as.data.frame(ids_2012)
# names(ids_2012)[1] <- "id"
# trees_2012<-tags_2012[tags_2012$k=='trees',]
# trees_2012<-trees_2012[,c(1,3)]
# produce_2012<-tags_2012[tags_2012$k=='produce',]
# produce_2012<-produce_2012[,c(1,3)]
# produces_2012<-tags_2012[tags_2012$k=='produces',]
# produces_2012<-produces_2012[,c(1,3)]
# class_2012<-rbind(trees_2012,produce_2012,produces_2012)
# ids_2012<-join(ids_2012,class_2012,by='id', type = "left")
# names(ids_2012)[2] <- "class"
# #write.csv(ids_2012, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/orchard_2012.csv')
#
# ## 2013
# orchard_2013<-orchard_2013[["nodes"]]
# tags_2013<-orchard_2013[["tags"]]
# ids_2013<-unique(tags_2013$id)
# ids_2013<-as.data.frame(ids_2013)
# names(ids_2013)[1] <- "id"
# trees_2013<-tags_2013[tags_2013$k=='trees',]
# trees_2013<-trees_2013[,c(1,3)]
# produce_2013<-tags_2013[tags_2013$k=='produce',]
# produce_2013<-produce_2013[,c(1,3)]
# fruit_2013<-tags_2013[tags_2013$k=='fruits',]
# fruit_2013<-fruit_2013[,c(1,3)]
# class_2013<-rbind(trees_2013,produce_2013,fruit_2013)
# ids_2013<-join(ids_2013,class_2013,by='id', type = "left")
# names(ids_2013)[2] <- "class"
# #write.csv(ids_2013, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/orchard_2013.csv')
#
# ## 2014
# orchard_2014<-orchard_2014[["nodes"]]
# tags_2014<-orchard_2014[["tags"]]
# ids_2014<-unique(tags_2014$id)
# ids_2014<-as.data.frame(ids_2014)
# names(ids_2014)[1] <- "id"
# trees_2014<-tags_2014[tags_2014$k=='trees',]
# trees_2014<-trees_2014[,c(1,3)]
# produce_2014<-tags_2014[tags_2014$k=='produce',]
# produce_2014<-produce_2014[,c(1,3)]
# fruit_2014<-tags_2014[tags_2014$k=='fruits',]
# fruit_2014<-fruit_2014[,c(1,3)]
# class_2014<-rbind(trees_2014,produce_2014,fruit_2014)
# ids_2014<-join(ids_2014,class_2014,by='id', type = "left")
# names(ids_2014)[2] <- "class"
# #write.csv(ids_2014, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/orchard_2014.csv')
#
# ## 2015
# orchard_2015<-orchard_2015[["nodes"]]
# tags_2015<-orchard_2015[["tags"]]
# ids_2015<-unique(tags_2015$id)
# ids_2015<-as.data.frame(ids_2015)
# names(ids_2015)[1] <- "id"
# trees_2015<-tags_2015[tags_2015$k=='trees',]
# trees_2015<-trees_2015[,c(1,3)]
# produce_2015<-tags_2015[tags_2015$k=='produce',]
# produce_2015<-produce_2015[,c(1,3)]
# fruit_2015<-tags_2015[tags_2015$k=='fruits',]
# fruit_2015<-fruit_2015[,c(1,3)]
# class_2015<-rbind(trees_2015,produce_2015,fruit_2015)
# ids_2015<-join(ids_2015,class_2015,by='id', type = "left")
# names(ids_2015)[2] <- "class"
# #write.csv(ids_2015, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/orchard_2015.csv')
#
# ## 2016
# orchard_2016<-orchard_2016[["nodes"]]
# tags_2016<-orchard_2016[["tags"]]
# ids_2016<-unique(tags_2016$id)
# ids_2016<-as.data.frame(ids_2016)
# names(ids_2016)[1] <- "id"
# trees_2016<-tags_2016[tags_2016$k=='trees',]
# trees_2016<-trees_2016[,c(1,3)]
# produce_2016<-tags_2016[tags_2016$k=='produce',]
# produce_2016<-produce_2016[,c(1,3)]
# fruit_2016<-tags_2016[tags_2016$k=='fruits',]
# fruit_2016<-fruit_2016[,c(1,3)]
# genus_2016<-tags_2016[tags_2016$k=='genus',]
# genus_2016<-genus_2016[,c(1,3)]
# class_2016<-rbind(trees_2016,produce_2016,fruit_2016,genus_2016)
# ids_2016<-join(ids_2016,class_2016,by='id', type = "left")
# names(ids_2016)[2] <- "class"
# #write.csv(ids_2016, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/orchard_2016.csv')
#
# ## 2017
# orchard_2017<-orchard_2017[["nodes"]]
# tags_2017<-orchard_2017[["tags"]]
# ids_2017<-unique(tags_2017$id)
# ids_2017<-as.data.frame(ids_2017)
# names(ids_2017)[1] <- "id"
# trees_2017<-tags_2017[tags_2017$k=='trees',]
# trees_2017<-trees_2017[,c(1,3)]
# produce_2017<-tags_2017[tags_2017$k=='produce',]
# produce_2017<-produce_2017[,c(1,3)]
# fruit_2017<-tags_2017[tags_2017$k=='fruits',]
# fruit_2017<-fruit_2017[,c(1,3)]
# genus_2017<-tags_2017[tags_2017$k=='genus',]
# genus_2017<-genus_2017[,c(1,3)]
# class_2017<-rbind(trees_2017,produce_2017,fruit_2017,genus_2017)
# ids_2017<-join(ids_2017,class_2017,by='id', type = "left")
# names(ids_2017)[2] <- "class"
# #write.csv(ids_2017, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/orchard_2017.csv')
#
# ## 2018
# orchard_2018<-orchard_2018[["nodes"]]
# tags_2018<-orchard_2018[["tags"]]
# ids_2018<-unique(tags_2018$id)
# ids_2018<-as.data.frame(ids_2018)
# names(ids_2018)[1] <- "id"
# trees_2018<-tags_2018[tags_2018$k=='trees',]
# trees_2018<-trees_2018[,c(1,3)]
# produce_2018<-tags_2018[tags_2018$k=='produce',]
# produce_2018<-produce_2018[,c(1,3)]
# fruit_2018<-tags_2018[tags_2018$k=='fruits',]
# fruit_2018<-fruit_2018[,c(1,3)]
# genus_2018<-tags_2018[tags_2018$k=='genus',]
# genus_2018<-genus_2018[,c(1,3)]
# crop_2018<-tags_2018[tags_2018$k=='crop',]
# crop_2018<-crop_2018[,c(1,3)]
# class_2018<-rbind(trees_2018,produce_2018,fruit_2018,genus_2018,crop_2018)
# ids_2018<-join(ids_2018,class_2018,by='id', type = "left")
# names(ids_2018)[2] <- "class"
# #write.csv(ids_2018, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/orchard_2018.csv')
#
# ## 2019
# orchard_2019<-orchard_2019[["nodes"]]
# tags_2019<-orchard_2019[["tags"]]
# ids_2019<-unique(tags_2019$id)
# ids_2019<-as.data.frame(ids_2019)
# names(ids_2019)[1] <- "id"
# trees_2019<-tags_2019[tags_2019$k=='trees',]
# trees_2019<-trees_2019[,c(1,3)]
# produce_2019<-tags_2019[tags_2019$k=='produce',]
# produce_2019<-produce_2019[,c(1,3)]
# fruit_2019<-tags_2019[tags_2019$k=='fruits',]
# fruit_2019<-fruit_2019[,c(1,3)]
# genus_2019<-tags_2019[tags_2019$k=='genus',]
# genus_2019<-genus_2019[,c(1,3)]
# crop_2019<-tags_2019[tags_2019$k=='crop',]
# crop_2019<-crop_2019[,c(1,3)]
# class_2019<-rbind(trees_2019,produce_2019,fruit_2019,genus_2019,crop_2019)
# ids_2019<-join(ids_2019,class_2019,by='id', type = "left")
# names(ids_2019)[2] <- "class"
# #write.csv(ids_2019, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/orchard_2019.csv')
#
# ## 2020
# orchard_2020<-orchard_2020[["nodes"]]
# tags_2020<-orchard_2020[["tags"]]
# ids_2020<-unique(tags_2020$id)
# ids_2020<-as.data.frame(ids_2020)
# names(ids_2020)[1] <- "id"
# trees_2020<-tags_2020[tags_2020$k=='trees',]
# trees_2020<-trees_2020[,c(1,3)]
# produce_2020<-tags_2020[tags_2020$k=='produce',]
# produce_2020<-produce_2020[,c(1,3)]
# fruit_2020<-tags_2020[tags_2020$k=='fruits',]
# fruit_2020<-fruit_2020[,c(1,3)]
# genus_2020<-tags_2020[tags_2020$k=='genus',]
# genus_2020<-genus_2020[,c(1,3)]
# species_2020<-tags_2020[tags_2020$k=='species',]
# species_2020<-species_2020[,c(1,3)]
# speciesfr_2020<-tags_2020[tags_2020$k=='species:fr',]
# speciesfr_2020<-speciesfr_2020[,c(1,3)]
# crop_2020<-tags_2020[tags_2020$k=='crop',]
# crop_2020<-crop_2020[,c(1,3)]
# class_2020<-rbind(trees_2020,produce_2020,fruit_2020,genus_2020,species_2020,speciesfr_2020,crop_2020)
# ids_2020<-join(ids_2020,class_2020,by='id', type = "left")
# names(ids_2020)[2] <- "class"
# #write.csv(ids_2020, 'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/orchard_2020.csv')
#
# ## assembling orhard file together
#
# setwd('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3')
#
# files<-list.files(pattern = "orchard.*.xml", full.names = T)
#
# # reading the files
#
# orchard_2009<-as_osmar(xmlParse("./orchard.2009.osh.pbf.osm.pbf.osm.xml"))
#
# orchard_2010<-as_osmar(xmlParse("./orchard.2010.osh.pbf.osm.pbf.osm.xml"))
#
# orchard_2011<-as_osmar(xmlParse("./orchard.2011.osh.pbf.osm.pbf.osm.xml"))
#
# orchard_2012<-as_osmar(xmlParse("./orchard.2012.osh.pbf.osm.pbf.osm.xml"))
#
# orchard_2013<-as_osmar(xmlParse("./orchard.2013.osh.pbf.osm.pbf.osm.xml"))
#
# orchard_2014<-as_osmar(xmlParse("./orchard.2014.osh.pbf.osm.pbf.osm.xml"))
#
# orchard_2015<-as_osmar(xmlParse("./orchard.2015.osh.pbf.osm.pbf.osm.xml"))
#
# orchard_2016<-as_osmar(xmlParse("./orchard.2016.osh.pbf.osm.pbf.osm.xml"))
#
# orchard_2017<-as_osmar(xmlParse("./orchard.2017.osh.pbf.osm.pbf.osm.xml"))
#
# orchard_2018<-as_osmar(xmlParse("./orchard.2018.osh.pbf.osm.pbf.osm.xml"))
#
# orchard_2019<-as_osmar(xmlParse("./orchard.2019.osh.pbf.osm.pbf.osm.xml"))
#
# orchard_2020<-as_osmar(xmlParse("./orchard.2020.osh.pbf.osm.pbf.osm.xml"))
#
# # reading the matching
#
# setwd ('I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed')
#
#
# matching_2009<-read.csv('orchard_2009.csv')
#
# matching_2010<-read.csv('orchard_2010.csv')
#
# matching_2011<-read.csv('orchard_2011.csv')
#
# matching_2012<-read.csv('orchard_2012.csv')
# matching_2013<-read.csv('orchard_2013.csv')
# matching_2014<-read.csv('orchard_2014.csv')
# matching_2015<-read.csv('orchard_2015.csv')
# matching_2016<-read.csv('orchard_2016.csv')
# matching_2017<-read.csv('orchard_2017.csv')
# matching_2018<-read.csv('orchard_2018.csv')
# matching_2019<-read.csv('orchard_2019.csv')
# matching_2020<-read.csv('orchard_2020.csv')
#
#
# # giving the class tag to the attribute table
#
#
# # 2009
# orchard_2009<-orchard_2009[["nodes"]]
# attrs_2009<-orchard_2009[["attrs"]]
# orchard_2009<-merge(x=attrs_2009,y=matching_2009,by="id",all=TRUE)
# drops<-c('visible','version','changeset','user','uid')
# orchard_2009<-orchard_2009[,!(names(orchard_2009) %in% drops)]
#
# # 2010
# orchard_2010<-orchard_2010[["nodes"]]
# attrs_2010<-orchard_2010[["attrs"]]
# orchard_2010<-merge(x=attrs_2010,y=matching_2010,by="id",all=TRUE)
# orchard_2010<-orchard_2010[,!(names(orchard_2010) %in% drops)]
#
# # 2011
# orchard_2011<-orchard_2011[["nodes"]]
# attrs_2011<-orchard_2011[["attrs"]]
# orchard_2011<-merge(x=attrs_2011,y=matching_2011,by="id",all=TRUE)
# orchard_2011<-orchard_2011[,!(names(orchard_2011) %in% drops)]
#
# # 2012
# orchard_2012<-orchard_2012[["nodes"]]
# attrs_2012<-orchard_2012[["attrs"]]
# orchard_2012<-merge(x=attrs_2012,y=matching_2012,by="id",all=TRUE)
# orchard_2012<-orchard_2012[,!(names(orchard_2012) %in% drops)]
#
# # 2013
# orchard_2013<-orchard_2013[["nodes"]]
# attrs_2013<-orchard_2013[["attrs"]]
# orchard_2013<-merge(x=attrs_2013,y=matching_2013,by="id",all=TRUE)
# orchard_2013<-orchard_2013[,!(names(orchard_2013) %in% drops)]
#
# # 2014
# orchard_2014<-orchard_2014[["nodes"]]
# attrs_2014<-orchard_2014[["attrs"]]
# orchard_2014<-merge(x=attrs_2014,y=matching_2014,by="id",all=TRUE)
# orchard_2014<-orchard_2014[,!(names(orchard_2014) %in% drops)]
#
# # 2015
# orchard_2015<-orchard_2015[["nodes"]]
# attrs_2015<-orchard_2015[["attrs"]]
# orchard_2015<-merge(x=attrs_2015,y=matching_2015,by="id",all=TRUE)
# orchard_2015<-orchard_2015[,!(names(orchard_2015) %in% drops)]
#
# # 2016
# orchard_2016<-orchard_2016[["nodes"]]
# attrs_2016<-orchard_2016[["attrs"]]
# orchard_2016<-merge(x=attrs_2016,y=matching_2016,by="id",all=TRUE)
# orchard_2016<-orchard_2016[,!(names(orchard_2016) %in% drops)]
#
# # 2017
# orchard_2017<-orchard_2017[["nodes"]]
# attrs_2017<-orchard_2017[["attrs"]]
# orchard_2017<-merge(x=attrs_2017,y=matching_2017,by="id",all=TRUE)
# orchard_2017<-orchard_2017[,!(names(orchard_2017) %in% drops)]
#
# # 2018
# orchard_2018<-orchard_2018[["nodes"]]
# attrs_2018<-orchard_2018[["attrs"]]
# orchard_2018<-merge(x=attrs_2018,y=matching_2018,by="id",all=TRUE)
# orchard_2018<-orchard_2018[,!(names(orchard_2018) %in% drops)]
#
# # 2019
# orchard_2019<-orchard_2019[["nodes"]]
# attrs_2019<-orchard_2019[["attrs"]]
# orchard_2019<-merge(x=attrs_2019,y=matching_2019,by="id",all=TRUE)
# orchard_2019<-orchard_2019[,!(names(orchard_2019) %in% drops)]
#
# # 2020
# orchard_2020<-orchard_2020[["nodes"]]
# attrs_2020<-orchard_2020[["attrs"]]
# orchard_2020<-merge(x=attrs_2020,y=matching_2020,by="id",all=TRUE)
# orchard_2020<-orchard_2020[,!(names(orchard_2020) %in% drops)]
#
# # compiling the file
#
# orchard<-rbind(orchard_2009,orchard_2010,orchard_2011,orchard_2012,orchard_2013,orchard_2014,orchard_2015,orchard_2016,orchard_2017,orchard_2018,orchard_2019,orchard_2020)
#
# #write.csv(orchard,'I:/MAS/01_data/LUCKINet/output/point data/point database/raw/3/processed/orchard.csv') file moved in the cluster because to difficult to process the forest part on my computer
#
#
# library(data.table)
#
# library(osmar)
#
# library(tidyverse)
#
# library(plyr)
#
# setwd('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/3/XML')
#
# files<-list.files(pattern = "forest.*.xml", full.names = T)
#
# # reading the files
#
# forest_2007<-as_osmar(xmlParse("./forest.2007.osh.pbf.osm.pbf.osm.xml"))
#
# forest_2008<-as_osmar(xmlParse("./forest.2008.osh.pbf.osm.pbf.osm.xml"))
#
# forest_2009<-as_osmar(xmlParse("./forest.2009.osh.pbf.osm.pbf.osm.xml"))
#
# forest_2010<-as_osmar(xmlParse("./forest.2010.osh.pbf.osm.pbf.osm.xml"))
#
# forest_2011<-as_osmar(xmlParse("./forest.2011.osh.pbf.osm.pbf.osm.xml"))
#
# forest_2012<-as_osmar(xmlParse("./forest.2012.osh.pbf.osm.pbf.osm.xml"))
#
# forest_2013<-as_osmar(xmlParse("./forest.2013.osh.pbf.osm.pbf.osm.xml"))
#
# forest_2014<-as_osmar(xmlParse("./forest.2014.osh.pbf.osm.pbf.osm.xml"))
#
# forest_2015<-as_osmar(xmlParse("./forest.2015.osh.pbf.osm.pbf.osm.xml"))
#
# forest_2016<-as_osmar(xmlParse("./forest.2016.osh.pbf.osm.pbf.osm.xml"))
#
# forest_2017<-as_osmar(xmlParse("./forest.2017.osh.pbf.osm.pbf.osm.xml"))
#
# forest_2018<-as_osmar(xmlParse("./forest.2018.osh.pbf.osm.pbf.osm.xml"))
#
# forest_2019<-as_osmar(xmlParse("./forest.2019.osh.pbf.osm.pbf.osm.xml"))
#
# forest_2020<-as_osmar(xmlParse("./forest.2020.osh.pbf.osm.pbf.osm.xml"))
#
# # extracing the important information from all files
#
# forest_2007<-forest_2007[["nodes"]]
# tags_2007<-forest_2007[["attrs"]]
#
# forest_2008<-forest_2008[["nodes"]]
# tags_2008<-forest_2008[["attrs"]]
#
# forest_2009<-forest_2009[["nodes"]]
# tags_2009<-forest_2009[["attrs"]]
#
# forest_2010<-forest_2010[["nodes"]]
# tags_2010<-forest_2010[["attrs"]]
#
# forest_2011<-forest_2011[["nodes"]]
# tags_2011<-forest_2011[["attrs"]]
#
# forest_2012<-forest_2012[["nodes"]]
# tags_2012<-forest_2012[["attrs"]]
#
# forest_2013<-forest_2013[["nodes"]]
# tags_2013<-forest_2013[["attrs"]]
#
# forest_2014<-forest_2014[["nodes"]]
# tags_2014<-forest_2014[["attrs"]]
#
# forest_2015<-forest_2015[["nodes"]]
# tags_2015<-forest_2015[["attrs"]]
#
# forest_2016<-forest_2016[["nodes"]]
# tags_2016<-forest_2016[["attrs"]]
#
# forest_2017<-forest_2017[["nodes"]]
# tags_2017<-forest_2017[["attrs"]]
#
# forest_2018<-forest_2018[["nodes"]]
# tags_2018<-forest_2018[["attrs"]]
#
# forest_2019<-forest_2019[["nodes"]]
# tags_2019<-forest_2019[["attrs"]]
#
# forest_2020<-forest_2020[["nodes"]]
# tags_2020<-forest_2020[["attrs"]]
#
#
# forest<-rbind(tags_2007,tags_2008,tags_2009,tags_2010,tags_2011,tags_2012,tags_2013,tags_2014,tags_2015,tags_2016,tags_2017,tags_2018,tags_2019,tags_2020)
#
# drops<-c('visible','version','changeset','user','uid')
# forest<-forest[,!(names(forest) %in% drops)]
# forest$class_original<-'forest'
# forest$class_processed<-'forest'
#
# write.csv(forest,'/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/3/processed/forest.csv')
#
#
# library(data.table)
#
# library(osmar)
#
# library(tidyverse)
#
# library(plyr)
#
# setwd('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/3/XML')
#
# files<-list.files(pattern = "meadow.*.xml", full.names = T)
#
# # reading the files
#
# meadow_2008<-as_osmar(xmlParse("./meadow.2008.osh.pbf.osm.pbf.osm.xml"))
#
# meadow_2009<-as_osmar(xmlParse("./meadow.2009.osh.pbf.osm.pbf.osm.xml"))
#
# meadow_2010<-as_osmar(xmlParse("./meadow.2010.osh.pbf.osm.pbf.osm.xml"))
#
# meadow_2011<-as_osmar(xmlParse("./meadow.2011.osh.pbf.osm.pbf.osm.xml"))
#
# meadow_2012<-as_osmar(xmlParse("./meadow.2012.osh.pbf.osm.pbf.osm.xml"))
#
# meadow_2013<-as_osmar(xmlParse("./meadow.2013.osh.pbf.osm.pbf.osm.xml"))
#
# meadow_2014<-as_osmar(xmlParse("./meadow.2014.osh.pbf.osm.pbf.osm.xml"))
#
# meadow_2015<-as_osmar(xmlParse("./meadow.2015.osh.pbf.osm.pbf.osm.xml"))
#
# meadow_2016<-as_osmar(xmlParse("./meadow.2016.osh.pbf.osm.pbf.osm.xml"))
#
# meadow_2017<-as_osmar(xmlParse("./meadow.2017.osh.pbf.osm.pbf.osm.xml"))
#
# meadow_2018<-as_osmar(xmlParse("./meadow.2018.osh.pbf.osm.pbf.osm.xml"))
#
# meadow_2019<-as_osmar(xmlParse("./meadow.2019.osh.pbf.osm.pbf.osm.xml"))
#
# meadow_2020<-as_osmar(xmlParse("./meadow.2020.osh.pbf.osm.pbf.osm.xml"))
#
# # extracing the important information from all files
#
# meadow_2008<-meadow_2008[["nodes"]]
# tags_2008<-meadow_2008[["attrs"]]
#
# meadow_2009<-meadow_2009[["nodes"]]
# tags_2009<-meadow_2009[["attrs"]]
#
# meadow_2010<-meadow_2010[["nodes"]]
# tags_2010<-meadow_2010[["attrs"]]
#
# meadow_2011<-meadow_2011[["nodes"]]
# tags_2011<-meadow_2011[["attrs"]]
#
# meadow_2012<-meadow_2012[["nodes"]]
# tags_2012<-meadow_2012[["attrs"]]
#
# meadow_2013<-meadow_2013[["nodes"]]
# tags_2013<-meadow_2013[["attrs"]]
#
# meadow_2014<-meadow_2014[["nodes"]]
# tags_2014<-meadow_2014[["attrs"]]
#
# meadow_2015<-meadow_2015[["nodes"]]
# tags_2015<-meadow_2015[["attrs"]]
#
# meadow_2016<-meadow_2016[["nodes"]]
# tags_2016<-meadow_2016[["attrs"]]
#
# meadow_2017<-meadow_2017[["nodes"]]
# tags_2017<-meadow_2017[["attrs"]]
#
# meadow_2018<-meadow_2018[["nodes"]]
# tags_2018<-meadow_2018[["attrs"]]
#
# meadow_2019<-meadow_2019[["nodes"]]
# tags_2019<-meadow_2019[["attrs"]]
#
# meadow_2020<-meadow_2020[["nodes"]]
# tags_2020<-meadow_2020[["attrs"]]
#
#
# meadow<-rbind(tags_2008,tags_2009,tags_2010,tags_2011,tags_2012,tags_2013,tags_2014,tags_2015,tags_2016,tags_2017,tags_2018,tags_2019,tags_2020)
#
# drops<-c('visible','version','changeset','user','uid')
# meadow<-meadow[,!(names(meadow) %in% drops)]
# meadow$class_original<-'meadow'
# meadow$class_processed<-'meadow and pasture'
#
# write.csv(meadow,'/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/3/processed/meadow.csv')
#
#
# library(data.table)
#
# library(osmar)
#
# library(tidyverse)
#
# library(plyr)
#
# setwd('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/3/XML')
#
# files<-list.files(pattern = "vineyard.*.xml", full.names = T)
#
# # reading the files
#
# vineyard_2007<-as_osmar(xmlParse("./vineyard.2007.osh.pbf.osm.pbf.osm.xml"))
#
# vineyard_2008<-as_osmar(xmlParse("./vineyard.2008.osh.pbf.osm.pbf.osm.xml"))
#
# vineyard_2009<-as_osmar(xmlParse("./vineyard.2009.osh.pbf.osm.pbf.osm.xml"))
#
# vineyard_2010<-as_osmar(xmlParse("./vineyard.2010.osh.pbf.osm.pbf.osm.xml"))
#
# vineyard_2011<-as_osmar(xmlParse("./vineyard.2011.osh.pbf.osm.pbf.osm.xml"))
#
# vineyard_2012<-as_osmar(xmlParse("./vineyard.2012.osh.pbf.osm.pbf.osm.xml"))
#
# vineyard_2013<-as_osmar(xmlParse("./vineyard.2013.osh.pbf.osm.pbf.osm.xml"))
#
# vineyard_2014<-as_osmar(xmlParse("./vineyard.2014.osh.pbf.osm.pbf.osm.xml"))
#
# vineyard_2015<-as_osmar(xmlParse("./vineyard.2015.osh.pbf.osm.pbf.osm.xml"))
#
# vineyard_2016<-as_osmar(xmlParse("./vineyard.2016.osh.pbf.osm.pbf.osm.xml"))
#
# vineyard_2017<-as_osmar(xmlParse("./vineyard.2017.osh.pbf.osm.pbf.osm.xml"))
#
# vineyard_2018<-as_osmar(xmlParse("./vineyard.2018.osh.pbf.osm.pbf.osm.xml"))
#
# vineyard_2019<-as_osmar(xmlParse("./vineyard.2019.osh.pbf.osm.pbf.osm.xml"))
#
# vineyard_2020<-as_osmar(xmlParse("./vineyard.2020.osh.pbf.osm.pbf.osm.xml"))
#
# # extracing the important information from all files
#
# vineyard_2007<-vineyard_2007[["nodes"]]
# tags_2007<-vineyard_2007[["attrs"]]
#
# vineyard_2008<-vineyard_2008[["nodes"]]
# tags_2008<-vineyard_2008[["attrs"]]
#
# vineyard_2009<-vineyard_2009[["nodes"]]
# tags_2009<-vineyard_2009[["attrs"]]
#
# vineyard_2010<-vineyard_2010[["nodes"]]
# tags_2010<-vineyard_2010[["attrs"]]
#
# vineyard_2011<-vineyard_2011[["nodes"]]
# tags_2011<-vineyard_2011[["attrs"]]
#
# vineyard_2012<-vineyard_2012[["nodes"]]
# tags_2012<-vineyard_2012[["attrs"]]
#
# vineyard_2013<-vineyard_2013[["nodes"]]
# tags_2013<-vineyard_2013[["attrs"]]
#
# vineyard_2014<-vineyard_2014[["nodes"]]
# tags_2014<-vineyard_2014[["attrs"]]
#
# vineyard_2015<-vineyard_2015[["nodes"]]
# tags_2015<-vineyard_2015[["attrs"]]
#
# vineyard_2016<-vineyard_2016[["nodes"]]
# tags_2016<-vineyard_2016[["attrs"]]
#
# vineyard_2017<-vineyard_2017[["nodes"]]
# tags_2017<-vineyard_2017[["attrs"]]
#
# vineyard_2018<-vineyard_2018[["nodes"]]
# tags_2018<-vineyard_2018[["attrs"]]
#
# vineyard_2019<-vineyard_2019[["nodes"]]
# tags_2019<-vineyard_2019[["attrs"]]
#
# vineyard_2020<-vineyard_2020[["nodes"]]
# tags_2020<-vineyard_2020[["attrs"]]
#
#
# vineyard<-rbind(tags_2007,tags_2008,tags_2009,tags_2010,tags_2011,tags_2012,tags_2013,tags_2014,tags_2015,tags_2016,tags_2017,tags_2018,tags_2019,tags_2020)
#
# drops<-c('visible','version','changeset','user','uid')
# vineyard<-vineyard[,!(names(vineyard) %in% drops)]
# vineyard$class_original<-'vineyard'
# vineyard$class_processed<-'grape'
#
# write.csv(vineyard,'/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/3/processed/vineyard.csv')
#
#
#
#
# # Loading libraries
#
# library(tidyr)
# library(dplyr)
# library(CoordinateCleaner)
# library(maps)
# library(sp)
# library(rworldmap)
# library(rworldxtra)
# library(countrycode)
#
# # reading files
#
# farmland<-read.csv('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/3/processed/farmland.csv')
# orchard<-read.csv('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/3/processed/orchard.csv')
# vineyard<-read.csv('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/3/processed/vineyard.csv')
# OSM1<-rbind(farmland, orchard, vineyard)
# OSM1$land_use<-'agriculture'
#
# meadow<-read.csv('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/3/processed/meadow.csv')
# forest<-read.csv('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/3/processed/forest.csv')
#
# OSM2<-rbind(meadow, forest)
# OSM2$land_use<-NA
#
# # assembling file
# OSM<-rbind(OSM1,OSM2)
#
# print('file compiled')
#
# # standardizing the date of observation
# OSM<-OSM %>%
#   separate(timestamp, c("day", "month", "year"), sep = "/")
#
# OSM$year<- substr(OSM$year, 0, 4)
#
# # adjusting the month
# month_to_adjust<-nchar(OSM$month)
# OSM<-cbind(OSM,month_to_adjust)
# month<-with(OSM, ifelse(OSM$month_to_adjust == 1, paste0("0", month), paste0(month)))
#
# # adjusting the day
# day_to_adjust<- nchar(OSM$day)
# OSM<-cbind(OSM,day_to_adjust)
# day<-with(OSM, ifelse(OSM$day_to_adjust == 1, paste0("0", day), paste0(day)))
#
# OSM<-cbind(OSM,month,day)
# OSM<-OSM[,-c(2:3,10:11)]
#
# # cleaning coordinates in the sea
# sea<-cc_sea(OSM, lon = 'lon', lat = 'lat', verbose=TRUE, value = "flagged")
# OSM<-cbind(OSM, sea)
# OSM<-OSM[OSM$sea=='TRUE',]
# OSM<-OSM[,-(10)]
#
# # removing points without coordinates
# OSM %>% drop_na(lat, lon)
#
# # extracting country name from coordinates
# coords<-data.matrix(OSM[,c(3,4)])
# points <- SpatialPointsDataFrame(coords,OSM)
# data(countriesHigh)
# countries<-countriesHigh
# points <- SpatialPoints(points, proj4string = sp::CRS(proj4string(countries)))
# indices <- over(points, countries)
# OSM$country_fullname<-indices$ADMIN
# OSM$NUTS0<-countrycode(OSM$country_fullname, origin='country.name', destination='iso2c')
#
# # standardization of the columns
# names(OSM)[1] <- "point_ID"
# names(OSM)[4] <- "long"
# names(OSM)[6] <- "luck_name"
# OSM$GPS_prec<-NA
# OSM$province<-NA
# OSM$locality<-NA
# OSM$obs_type<-NA
# OSM$scientificName<-NA
# OSM$genus<-NA
# OSM$species<-NA
# OSM$generic_name<-NA
# OSM$land_use <-NA
# OSM$country_derivation <-'yes'
#
# # match OSM to ontology
#
# ontology<-read.csv('/gpfs1/data/idiv_meyer/01_projects/Caterina/raw/luckinet_ontology_alpha200424.csv')
# OSM<-inner_join(x = OSM, y = ontology, by = "luck_name")
# OSM<-OSM[,-c(5,22:30)]
#
#
# #removing duplicates from the database
# OSM<-OSM %>% distinct(year, month, lat, long, luck_name,.keep_all = TRUE)
# saveRDS(OSM,'/gpfs1/data/idiv_meyer/01_projects/Caterina/data/3/OSM.rds')

