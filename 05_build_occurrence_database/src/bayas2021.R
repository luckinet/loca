# script arguments ----
#
thisDataset <- "Bayas2021"
description <- "The data set is the result of the Drivers of Tropical Forest Loss crowdsourcing campaign. The campaign took place in December 2020. A total of 58 participants contributed validations of almost 120k locations worldwide. The locations were selected randomly from the Global Forest Watch tree loss layer (Hansen et al 2013), version 1.7. At each location the participants were asked to look at satellite imagery time series using a customized Geo-Wiki user interface and identify drivers of tropical forest loss during the years 2008 to 2019 following 3 steps: Step 1) Select the predominant driver of forest loss visible on a 1 km square (delimited by a blue bounding box); Step 2) Select any additional driver(s) of forest loss and; Step 3) Select if any roads, trails or buildings were visible in the 1 km bounding box. The Geo-Wiki campaign aims, rules and prizes offered to the participants in return for their work can be seen here: https://application.geo-wiki.org/Application/modules/drivers_forest_change/drivers_forest_change.html . The record contains 3 files: One “.csv” file with all the data collected by the participants during the crowdsourcing campaign (1158021 records); a second “.csv” file with the controls prepared by the experts at IIASA, used for scoring the participants (2001 unique locations, 6157 records) and a ”.docx” file describing all variables included in the two other files. A data descriptor paper explaining the mechanics of the campaign and describing in detail how the data was generated will be made available soon."
url <- "https://doi.org/10.22022/NODES/06-2021.122"
licence <- "https://creativecommons.org/licenses/by-sa/4.0/"

message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(occurr_dir, "input/", thisDataset, "/", INSERT))       # in case of ris format
bib <- bibtex_reader(paste0(occurr_dir, "input/", thisDataset, "/", INSERT))    # in case of bib format


# read dataset ----
#
data_path <- paste0(occurr_dir, "input/", thisDataset, "/", "ILUC_DARE_x_y/ILUC_DARE_campaign_x_y.csv")

data <- read_csv(file = data_path,
                 col_names = FALSE,
                 col_types = cols(.default = "c"))


# data management ----
#
# temp <- data %>%
#   mutate(
#     datasetID = thisDataset,
#     fid = row_number(),
#     type = "point",
#     country = NA_character_,
#     x = x,
#     y = y,
#     geometry = NA,
#     epsg = 4326,
#     area = NA_real_,
#     date = dmy("01-01-2008"),
#     externalID = NA_character_,
#     externalValue = "Forests",
#     irrigated = FALSE,
#     presence = FALSE,
#     sample_type = "visual interpretation",
#     collector = "citizen scientist",
#     purpose = "study") %>%
#   select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
#          externalID, externalValue, irrigated, presence,
#          sample_type, collector, purpose, everything())


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
           date = ymd("2022-04-14"),
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

