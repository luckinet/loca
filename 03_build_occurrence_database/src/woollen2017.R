# script arguments ----
#
thisDataset <- "Woollen2017"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "citation.ris"))

regDataset(name = thisDataset,
           description = "This dataset comprises 259 smallholder agricultural field surveys collected from twenty-six villages across three Districts in Mozambique, Africa. Surveys were conducted in ten fields in each of six villages in Mabalane District, Gaza Province, ten villages in Marrupa District, Niassa Province, and ten villages in Gurue District, Zambezia Province. Data were collected in Mabalane between May-Sep 2014, Marrupa between May-Aug 2015, and Gurue between Sep-Dec 2015. Fields were selected based on their age, location, and status as an active field at the time of the survey (i.e. no fallow fields were sampled). Structured interviews using questionnaires were conducted with each farmer to obtain information about current management practices (e.g. use of inputs, tilling, fire and residue management), age of the field, crops planted, crop yields, fallow cycles, floods, erosion and other problems such as crop pests and wild animals. The survey also includes qualitative observations about the fields at the time of the interview, including standing live trees and cropping systems. This dataset was collected as part of the Ecosystem Services for Poverty Alleviation (ESPA) funded ACES project , which aims to understand how changing land use impacts on ecosystem services and human wellbeing of the rural poor in Mozambique.",
           url = "https://doi.org/10.5285/78c5dcee-61c1-44be-9c47-8e9e2d03cb63",
           download_date = "2022-05-31",
           type = "static",
           licence = "OGL v3",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#
data <- read_csv(file = paste0(thisPath, "field_main_survey.csv")) %>%
  left_join(.,  read_csv(file = paste0(thisPath, "crops_planted.csv")), by = "field_id")



# manage ontology ---
#
matches <- read_csv(paste0(thisPath, "Woollen_ontology.csv"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)


# harmonise data ----
#
temp <- st_as_sf(data, coords = c("origin_local_x", "origin_local_y"), crs = CRS("EPSG:32736")) %>%
  st_transform(., crs = "EPSG:4326") %>%
  mutate(lon = st_coordinates(.)[,1],
         lat = st_coordinates(.)[,2]) %>%
  as.data.frame()


temp <- temp %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = lon,
    y = lat,
    geometry = NA,
    year = year(dmy(date_sampled)),
    month = month(dmy(date_sampled)),
    day = day(dmy(date_sampled)),
    country = "Mozambique",
    irrigated = F,
    area = area_ha * 10000,
    presence = T,
    externalID = field_id,
    externalValue = crops_planted,
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
