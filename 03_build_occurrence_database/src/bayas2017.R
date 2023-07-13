# script arguments ----
#
thisDataset <- "Bayas2017"
description <- "A global reference dataset on cropland was collected through a crowdsourcing campaign implemented using Geo-Wiki. This reference dataset is based on a systematic sample at latitude and longitude intersections, enhanced in locations where the cropland probability varies between 25-75% for a better representation of cropland globally. Over a three week period, around 36K samples of cropland were collected. For the purpose of quality assessment, additional datasets are provided. One is a control dataset of 1793 sample locations that have been validated by students trained in image interpretation. This dataset was used to assess the quality of the crowd validations as the campaign progressed. Another set of data contains 60 expert or gold standard validations for additional evaluation of the quality of the participants. These three datasets have two parts, one showing cropland only and one where it is compiled per location and user. This reference dataset will be used to validate and compare medium and high resolution cropland maps that have been generated using remote sensing. The dataset can also be used to train classification algorithms in developing new maps of land cover and cropland extent"
url <- "https://doi.org/10.1594/PANGAEA.873912 https://"
licence <- "CC-BY-3.0"


# reference ----
#
bib <- bibtex_reader(x = paste0(thisPath, "Crowdsource_cropland.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("13-09-2021"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_tsv(file = paste0(thisPath, "loc_all.txt"))


# harmonise data ----
#
uniqueDat <- data %>%
  mutate(year = paste0("20", str_split(str_split(string = timestamp, pattern = " ")[[1]][[1]], pattern = "-")[[1]][3])) %>%
  distinct(locationid, year) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    country = NA_character_,
    epsg = 4326,
    area = NA_real_,
    date = ymd(paste0(as.numeric(year), "-01-01")),
    externalID = as.character(locationid),
    externalValue = matches$new,
    attr_1 = mean(sumcrop),
    attr_1_typ = "cover",
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "visual interpretation",
    collector = "citizen scientist",
    purpose = "validation")

temp <- data %>%
  rename(date = "timestamp") %>%
  group_by(locationid) %>%
  summarise(x = unique(centroid_X),
            y = unique(centroid_Y),
            geometry = NA) %>%
  left_join(uniqueDat, by = "locationid") %>%
  mutate(fid = row_number(),
         type = "point") %>%
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

