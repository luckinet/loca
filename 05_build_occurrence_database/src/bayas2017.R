# script arguments ----
#
thisDataset <- "Bayas2017"
description <- "A global reference dataset on cropland was collected through a crowdsourcing campaign implemented using Geo-Wiki. This reference dataset is based on a systematic sample at latitude and longitude intersections, enhanced in locations where the cropland probability varies between 25-75% for a better representation of cropland globally. Over a three week period, around 36K samples of cropland were collected. For the purpose of quality assessment, additional datasets are provided. One is a control dataset of 1793 sample locations that have been validated by students trained in image interpretation. This dataset was used to assess the quality of the crowd validations as the campaign progressed. Another set of data contains 60 expert or gold standard validations for additional evaluation of the quality of the participants. These three datasets have two parts, one showing cropland only and one where it is compiled per location and user. This reference dataset will be used to validate and compare medium and high resolution cropland maps that have been generated using remote sensing. The dataset can also be used to train classification algorithms in developing new maps of land cover and cropland extent"
doi <- "https://doi.org/10.1594/PANGAEA.873912"
licence <- "https://creativecommons.org/licenses/by/3.0/"

message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(occurr_dir, "input/", thisDataset, "/", "Crowdsource_cropland.bib"))


# read dataset ----
#
data_path <- paste0(occurr_dir, "input/", thisDataset, "/", "loc_all.txt")

data <- read_tsv(file = data_path,
                 col_names = FALSE,
                 col_types = cols(.default = "c"))


# data management ----
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


# harmonise data ----
#
data <- data %>%
  mutate(obsID = row_number(), .before = 1)                                     # define observation ID on raw data to be able to join harmonised data with the rest

schema_INSERT <-
  setFormat(decimal = INSERT, thousand = INSERT, na_values = INSERT) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%                         # the dataset ID
  setIDVar(name = "obsID", columns = 1) %>%                                     # the observation ID
  setIDVar(name = "externalID", columns = INSERT) %>%                           # the verbatim observation-specific ID as used in the external dataset
  setIDVar(name = "open", value = INSERT) %>%                                   # whether the dataset is freely available (TRUE) or restricted (FALSE)
  setIDVar(name = "type", value = INSERT) %>%                                   # whether the data are "point" or "areal" (when its from a plot, region, nation, etc)
  setIDVar(name = "x", columns = INSERT) %>%                                    # the x-value of the coordinate (or centroid if type = "areal")
  setIDVar(name = "y", columns = INSERT) %>%                                    # the y-value of the coordinate (or centroid if type = "areal")
  setIDVar(name = "epsg", value = INSERT) %>%                                   # the EPSG code of the coordinates or geometry
  setIDVar(name = "geometry", columns = INSERT) %>%                             # the geometries if type = "areal"
  setIDVar(name = "date", columns = INSERT) %>%                                 # the date of the observation
  setIDVar(name = "sample_type", value = INSERT) %>%                            # from what space the data were collected, either "field/ground", "visual interpretation", "experience", "meta study" or "modelled"
  setIDVar(name = "collector", value = INSERT) %>%                              # who the collector was, either "expert", "citizen scientist" or "student"
  setIDVar(name = "purpose", value = INSERT) %>%                                # what the data were collected for, either "monitoring", "validation", "study" or "map development"
  setObsVar(name = "value", columns = INSERT) %>%                               # the value of the observation
  setObsVar(name = "irrigated", columns = INSERT) %>%                           # whether the observation receives irrigation (TRUE) or not (FALSE)
  setObsVar(name = "present", columns = INSERT) %>%                             # whether the observation describes a presence (TRUE) or an absence (FALSE)
  setObsVar(name = "area", columns = INSERT)                                    # the area covered by the observation (if type = "areal")

temp <- reorganise(schema = schema_INSERT, input = data)

otherData <- data %>%
  select(INSERT)                                                                # remove all columns that are recorded in 'out'


# harmonize with ontology ----
#
new_source(name = thisDataset,
           description = description,
           homepage = doi,
           date = ymd("2021-09-13"),
           license = licence,
           ontology = onto_path)

out <- matchOntology(table = temp,
                     columns = "value",
                     dataseries = thisDataset,
                     ontology = onto_path)


# write output ----
#
validateFormat(object = out) %>%
  saveRDS(file = paste0(occurr_dir, thisDataset, ".rds"))

saveRDS(object = otherData, file = paste0(occurr_dir, thisDataset, "_other.rds"))

read_lines(file = paste0(occurr_dir, "references.bib")) %>%
  c(bibtex_writer(z = bib, key = thisDataset)) %>%
  write_lines(file = paste0(occurr_dir, "references.bib"))


# beep(sound = 10)
message("\n     ... done")

