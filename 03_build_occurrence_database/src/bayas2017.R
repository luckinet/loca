# script arguments ----
#
thisDataset <- "Bayas2017"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(x = paste0(thisPath, "Crowdsource_cropland.bib"))

regDataset(name = thisDataset,
           description = "A global reference dataset on cropland was collected through a crowdsourcing campaign implemented using Geo-Wiki. This reference dataset is based on a systematic sample at latitude and longitude intersections, enhanced in locations where the cropland probability varies between 25-75% for a better representation of cropland globally. Over a three week period, around 36K samples of cropland were collected. For the purpose of quality assessment, additional datasets are provided. One is a control dataset of 1793 sample locations that have been validated by students trained in image interpretation. This dataset was used to assess the quality of the crowd validations as the campaign progressed. Another set of data contains 60 expert or gold standard validations for additional evaluation of the quality of the participants. These three datasets have two parts, one showing cropland only and one where it is compiled per location and user. This reference dataset will be used to validate and compare medium and high resolution cropland maps that have been generated using remote sensing. The dataset can also be used to train classification algorithms in developing new maps of land cover and cropland extent.",
           url = "https://doi.org/10.1594/PANGAEA.873912",
           type = "static",
           licence = "CC-BY-3.0",
           bibliography = bib,
           download_date = "2021-09-13",
           contact = "see corresponding author",
           disclosed = "yes",
           update = TRUE)


# read dataset ----
#
data <- read_tsv(file = paste0(thisPath, "loc_all.txt"))


# manage ontology ---
#
matches <- tibble(new = "cropland",
                  old = "Temporary cropland")

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)


# harmonise data ----
#
uniqueDat <- data %>%
  mutate(year = paste0("20", str_split(str_split(string = timestamp, pattern = " ")[[1]][[1]], pattern = "-")[[1]][3])) %>%
  distinct(locationid, year) %>%
  mutate(country = NA_character_,
         year = as.numeric(year),
         month = NA_real_,
         day = NA_integer_,
         datasetID = thisDataset,
         irrigated = FALSE,
         area = NA_real_,
         presence = TRUE,
         externalID = as.character(locationid),
         externalValue = matches$new,
         LC1_orig = NA_character_,
         LC2_orig = NA_character_,
         LC3_orig = NA_character_,
         sample_type = "visual interpretation",
         collector = "citizen scientist",
         purpose = "validation",
         epsg = 4326)

temp <- data %>%
  rename(sampledate = "timestamp") %>%
  group_by(locationid) %>%
  summarise(cover = mean(sumcrop),
            x = unique(centroid_X),
            y = unique(centroid_Y),
            geometry = NA) %>%
  left_join(uniqueDat, by = "locationid") %>%
  mutate(fid = row_number(),
         type = "point") %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
