# script arguments ----
#
thisDataset <- "Szantoi2020"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "dataset914261.bib")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "Threats to biodiversity pose an enormous challenge for Africa. Mounting social and economic demands on natural resources increasingly threaten key areas for conservation. Effective protection of sites of strategic conservation importance requires timely and highly detailed geospatial monitoring. Larger ecological zones and wildlife corridors warrant monitoring as well, as these areas have an even higher degree of pressure and habitat loss. To address this, a satellite imagery based15 monitoring workflow to cover at-risk areas at various details was developed. During the program’s first phase, a total of 560,442km2 area in Sub-Saharan Africa was covered, from which 153,665km2 were mapped with 8 land cover classes while 406,776km2 were mapped with up to 32 classes. Satellite imagery was used to generate dense time series data from which thematic land cover maps were derived. Each map and change map were fully verified and validated by an independent team to achieve our strict data quality requirements. The independent validation datasets for each KLCs are also described and 20 presented here (The complete dataset available at Szantoi et al., 2020A https://doi.pangaea.de/10.1594/PANGAEA.914261, and a demonstration dataset at Szantoi et al., 2020B https://doi.pangaea.de/10.1594/PANGAEA.915849).",
           url = "https://doi.pangaea.de/10.1594/PANGAEA.914261, https://doi.org/10.5194/essd-2020-77",
           download_date = "", # YYYY-MM-DD
           type = "static",
           licence = "CC BY 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
caf01 <- read_sf(paste0(thisPath, "/ALL_DATA/validationData_Sub-Sahara_Africa/caf01.dbf"))
caf02 <- read.dbf(paste0(thisPath, "/ALL_DATA/validationData_Sub-Sahara_Africa/caf02.dbf"))
caf06 <- read.dbf(paste0(thisPath, "/ALL_DATA/validationData_Sub-Sahara_Africa/caf06.dbf"))
caf07 <- read.dbf(paste0(thisPath, "/ALL_DATA/validationData_Sub-Sahara_Africa/caf07.dbf"))
caf11 <- read.dbf(paste0(thisPath, "/ALL_DATA/validationData_Sub-Sahara_Africa/caf11.dbf"))
caf15 <- read.dbf(paste0(thisPath, "/ALL_DATA/validationData_Sub-Sahara_Africa/caf15.dbf"))
caf16 <- read.dbf(paste0(thisPath, "/ALL_DATA/validationData_Sub-Sahara_Africa/caf16.dbf"))
caf99 <- read.dbf(paste0(thisPath, "/ALL_DATA/validationData_Sub-Sahara_Africa/caf99.dbf"))
saf1415 <- read.dbf(paste0(thisPath, "/ALL_DATA/validationData_Sub-Sahara_Africa/saf1415.dbf"))
waf05 <- read.dbf(paste0(thisPath, "/ALL_DATA/validationData_Sub-Sahara_Africa/waf05.dbf"))
waf10 <- read.dbf(paste0(thisPath, "/ALL_DATA/validationData_Sub-Sahara_Africa/waf10.dbf"))

LC_Class <- read_csv2(paste0(thisPath, "LC_class.csv"))

join <- bind_rows(caf01, caf02, caf06, caf07, caf11, caf15, caf16, caf99, saf1415, waf05, waf10)

# one df for 2000 and one for 2015
j2000 <- join %>%
  select(y, x, Mapcode = plaus2000) %>% mutate(year = 2000)

j2015 <- join %>%
  select(y, x, Mapcode = plaus2015) %>% mutate(year = 2015)

j2016 <- join %>%
  select(y, x, Mapcode = plaus2016) %>% mutate(year = 2016)

j2017 <- join %>%
  select(y, x, Mapcode = plaus2017) %>% mutate(year = 2017)

join <- bind_rows(j2000, j2015, j2016, j2017) %>% left_join(., LC_Class, by = "Mapcode")


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
    externalValue = LandCover,
    LC1_orig = LandCover,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = , # "field", "visual interpretation", "experience", "meta study" or "modelled"
    collector = "expert", # "expert", "citizen scientist" or "student"
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
# ref = st_read('C:/Users/rr70wedu/Documents/example_data/admin/gadm36_0-simple.shp')
# l = read.csv('./szantoi_etlal/szantoi_etal_legend.csv', stringsAsFactors=F)
# s = st_read('./szantoi_etlal/szantoi_etal_merge.sqlite')
# st_crs(s) = st_crs(ref)
#
# #-------------------------------------------------------------------------------------------------------------#
# #
# #-------------------------------------------------------------------------------------------------------------#
#
# s1 = s
# s1$label = s1$plaus2000
# s1$year = 2000
# s1$month = NA
# s1$day = NA
#
# s2 = s
# s2$label = s2$plaus2015
# s2$year = 2015
# s2$month = NA
# s2$day = NA
#
# s3 = s
# s3$label = s3$plaus2016
# s3$year = 2016
# s3$month = NA
# s3$day = NA
#
# s4 = s
# s4$label = s4$plaus2017
# s4$year = 2017
# s4$month = NA
# s4$day = NA
#
# s0 = rbind(s1, s2, s3, s4)
# s0 = s0[!is.na(s0$label),]
#
# #-------------------------------------------------------------------------------------------------------------#
# #
# #-------------------------------------------------------------------------------------------------------------#
#
# s0$land_use = l$land_use[match(s0$label,l$code)]
# s0$land_cover = l$land_cover[match(s0$label,l$code)]
# s0$dataset_name = 'szantoi_etal'
# s0$origin_id = s0$sample_id
# s0$origin_name = "Pangea"
# s0$origin_url = 'https://doi.pangaea.de/10.1594/PANGAEA.914261'
# s$use_intensity = NA
# s0$water_source = NA
# #st_write(s0, './szantoi_etlal/szantoi_etal_tmp.sqlite')
# #a = st_read('./szantoi_etlal/szantoi_etal_tmp_join.sqlite')
# a = st_intersection(s0, ref)
# a$country_name = a$name_0
# a$country_iso3 = a$gid_0
# a$source = 'Visual interpretation'
# a$priority = 1
# a$use_intensity = NA
#
# pts = a[,c('dataset_name','origin_id','origin_name','origin_url','source','country_name',
#            'country_iso3','year','month','day','land_cover','land_use','priority',
#            'use_intensity','water_source','GEOMETRY')]
#
# st_write(pts, './szantoi_etlal/szantoi_etal_point_processed.sqlite', append=FALSE)
#
# #-------------------------------------------------------------------------------------------------------------#
# #
# #-------------------------------------------------------------------------------------------------------------#
