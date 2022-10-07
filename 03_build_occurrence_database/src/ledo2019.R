# script arguments ----
#
thisDataset <- "Ledo2019"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "7637210.bib"))

regDataset(name = thisDataset,
           description = "A global, unified dataset on Soil Organic Carbon (SOC) changes under perennial crops has not existed till now. We present a global, harmonised database on SOC change resulting from perennial crop cultivation. It contains information about 1605 paired-comparison empirical values (some of which are aggregated data) from 180 different peer-reviewed studies, 709 sites, on 58 different perennial crop types, from 32 countries in temperate, tropical and boreal areas; including species used for food, bioenergy and bio-products. The database also contains information on climate, soil characteristics, management and topography. This is the first such global compilation and will act as a baseline for SOC changes in perennial crops. It will be key to supporting global modelling of land use and carbon cycle feedbacks, and supporting agricultural policy development.",
           url = "https://doi.org/10.6084/m9.figshare.7637210.v2, https://doi.org/10.1038/s41597-019-0062-1",
           download_date = "2022-01-19",
           type = "static",
           licence = "CC BY 4.0",
           contact = "alicialedo@gmail.com",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xls(path = paste0(thisPath, "SOC perennials DATABASE.xls"), sheet = 5, skip = 1)


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
    fid = row_number(),
    x = Longitud,
    y = Latitud,
    year = year_measure,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = CROP_current,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, year, month, day, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")

# comm <- commodities %>%
#   select(faoID, faoName, CROP_current = ledo_CName) %>%
#   unite(col = CROP_current, faoName, CROP_current, sep = " | ") %>%
#   mutate(CROP_current = str_split(CROP_current, " \\| ")) %>%
#   unnest(col = CROP_current) %>%
#   mutate(CROP_current = str_replace(string = CROP_current, pattern = "NA", replacement = NA_character_)) %>%
#   drop_na()
# )
#
#
# # load the dataset
# theData <- read_csv(file = paste0(input_path, "/point data/ledo_etal/SOC perennials DATABASE.csv")) %>%
#   filter(!is.na(Longitud) & !is.na(Latitud)) %>%
#   mutate(fid = seq_along(ID))
#
# # seperate into coordinates and attributes, and modify attributes
# theCoords <- theData %>%
#   select(x = Longitud, y = Latitud, fid)
#
# outData <- theData %>%
#   left_join(comm) %>%
#   mutate(date = as.Date(paste0(year_measure, "-01-01")),
#          lcID = 2L,
#          irrigated = NA_integer_,
#          dataset = "ledo_etal") %>%
#   select(fid, date, country, lcID, faoID, irrigated, source_type = Original_source, dataset)
#
# # make geom
# theGeom <- theCoords %>%
#   gs_point() %>%
#   setFeatures(outData)
#
# outFeats <- getFeatures(x = theGeom)
# outCoords <- getPoints(x = theGeom)
# out_ledo <- left_join(x = outFeats, y = outCoords, by = "fid")
