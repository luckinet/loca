# script arguments ----
#
thisDataset <- "OFSA"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibentry(bibtype = "Misc",
                title = "Organic Farming Scheme Agreements",
                institution = "Natural England",
                author = "Natural England",
                year = 2020,
                url = "http://naturalengland-defra.opendata.arcgis.com/datasets/organic-farming-scheme-agreements")

regDataset(name = thisDataset,
           description = "The aim of the OFS is to encourage the expansion of organic production. Under the scheme, farmers moving from conventional to organic farming methods receive financial help during the conversion process. The scheme is now closed to new applications but has been replaced by Organic ",
           url = "http://naturalengland-defra.opendata.arcgis.com/datasets/organic-farming-scheme-agreements", # ideally the doi, but if it doesn't have one, the main source of the database
           download_date = "2022-06-04",
           type = "static",
           licence = "Open Government Licence",
           contact = "data.services@naturalengland.org.uk",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#

data <- st_read(paste0(thisPath, "Organic_Farming_Scheme_Agreements"))


# harmonise data ----
#
temp <- data %>%
  st_centroid() %>%
  st_transform(., crs = "EPSG:4326")%>%
  dplyr::mutate(Start = year(ymd_hms(AGREEMEN_1)),
                End = year(ymd_hms(AGREEMEN_2)),
                lon = st_coordinates(.)[,1],
                lat = st_coordinates(.)[,2]) %>%
  as.data.frame() %>%
  bind_cols(., data$geometry)


temp1 <- temp %>%
  transmute(FID, year = map2(Start, End, `:`)) %>%
  unnest %>%
  left_join(., data, by = "FID") %>% left_join(., temp, by = "FID")

temp <- temp1 %>%
  dplyr::mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = lon,
    y = lat,
    geometry = `...21`,
    year = as.numeric(year),
    month = NA_real_,
    day = NA_integer_,
    country = "United Kingdom",
    irrigated = F,
    area = SHAPE_Area.x,
    presence = F,
    externalID = as.character(FID),
    externalValue = "Permanent cropland",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
