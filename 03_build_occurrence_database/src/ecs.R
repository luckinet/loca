# script arguments ----
#
thisDataset <- "ECS"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibentry(bibtype = "Misc",
                title = "Energy Crops Scheme (ECS) Agreements",
                institution = "Natural England",
                author = "Natural England",
                year = 2020,
                url = "http://naturalengland-defra.opendata.arcgis.com/datasets/energy-crops-scheme-ecs-agreements")

regDataset(name = thisDataset,
           description = "Energy Crops Scheme Agreements - based on Probis extract. The Energy Crops Scheme provides establishment grants for approved energy crops. Approved crops are Short Rotation Coppice (Willow, Poplar, Ash, Alder, Hazel, Silver Birch, Sycamore, Sweet Chestnut and Lime) and Miscanthus (a tall, woody grass). The ECS grant scheme supports the cost of establishment of Miscanthus or Short Rotation Coppice (SRC). Both elements of the Energy Crops Scheme, (which formed part of the England Rural Development Programme), Establishment Grants and Producer Groups, have now closed to new applications.  For details on the Energy Crops Scheme 2007-13 visit Natural England's website (archived).Full metadata can be viewed on data.gov.uk.",
           url = "https://naturalengland-defra.opendata.arcgis.com/datasets/Defra::energy-crops-scheme-ecs-agreements/about",
           download_date = "2022-06-04",
           type = "static",
           licence = "Open Government Licence",
           contact = "data.services@naturalengland.org.uk",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(file = paste0(thisPath, "Energy_Crops_Scheme_(ECS)_Agreements.csv"))



# manage ontology ---
#
matches <- tibble(new = c(unique(data$CROPTYPE)),
                  old = c("Bioenergy woody", "miscanthus"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)


# harmonise data ----
#
temp <- data %>%
  st_as_sf(., coords = c("XCOORD", "YCOORD"), crs = CRS("EPSG:27700")) %>%
  st_transform(., crs ="EPSG:4326") %>%
  mutate(lon = st_coordinates(.)[,1],
         lat = st_coordinates(.)[,2]) %>%
  as.data.frame()

temp <- temp %>%
  mutate(
    datasetID = thisDataset,
    type = "areal",
    x = lon,
    y = lat,
    geometry = NA,
    year = "2007_2008_2009_2010_2011_2012_2013",
    month = NA_real_,
    day = NA_integer_,
    country = "United Kingdom",
    irrigated = F,
    area = SHAPE_Area,
    presence = T,
    externalID = NA_character_,
    externalValue = CROPTYPE,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  dplyr::mutate( year = as.numeric(year),
          fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
