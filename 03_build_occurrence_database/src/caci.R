# script arguments ----
#
thisDataset <- "caci"
thisPath <- paste0(DBDir, thisDataset, "")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibentry(bibtype = "Misc",
                title = "Annual Crop Inventory Ground Truth Data",
                publisher = "Agriculture and Agri-Food Canada",
                year = 2020)

regDataset(name = thisDataset,
           description = "Beginning with the 2011 grow season, the Earth Observation Team of the Science and Technology Branch (STB) at Agriculture and Agri-Food Canada (AAFC) started collecting ground truth data via windshield surveys. This observation data is collected in support of the generation of an annual crop inventory digital map. These windshield surveys take place in provinces where AAFC does not have access to crop insurance data. The collection routes driven attempt to maximize not only the geographical distribution of observations but also to target unique or specialty crop types within a given region. Windshield surveys are mainly collected by the AAFC Earth Observation team (Ottawa) with the support of regional AAFC Research Centres (St John’s NL; Kentville NS; Charlottetown PE; Moncton NB; Guelph ON; Summerland BC). Support is also provided by provincial agencies in British Columbia, Ontario, and Prince Edward Island, and by contractors when needed.",
           url = "https://open.canada.ca/data/en/dataset/503a3113-e435-49f4-850c-d70056788632",
           download_date = "2022-05-16",
           type = "dynamic",
           licence = "Open Government Licence - Canada",
           contact = "agri-geomatics-agrog@agr.gc.ca",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# pre-process data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#

dataNames <- list.dirs(path = thisPath)[-1]
data <- lapply(dataNames, st_read)

# pre-process data ----
data <- bind_rows(data)

# manage ontology ---
#
matches <- read_csv(paste0(thisPath, "caci_onotology.csv"))

newConcept(new = c("beetroot", "celery",
                   "goji berry", "haskap",
                   "flax", "elderberry"),
           broader = c("Root or Bulb vegetables", "Leafy or stem vegetables",
                       "Berries", "Berries",
                       "Fibre crops", "Berries"),
           class = "commodity",
           source = thisDataset)

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
  mutate(x = st_coordinates(.)[,1],
         y = st_coordinates(.)[,2]) %>%
  as.data.frame() %>%
  dplyr::mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    geometry = geometry,
    year = year(DATE_COLL),
    month = month(DATE_COLL),
    day = day(DATE_COLL),
    country = "Canda",
    irrigated = F,
    area = NA_real_,
    presence = T,
    externalID = NA_character_,
    externalValue = NOMTERRE,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "validation",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
