thisDataset <- "Fritz2017"
description <- "Global land cover is an essential climate variable and a key biophysical driver for earth system models. While remote sensing technology, particularly satellites, have played a key role in providing land cover datasets, large discrepancies have been noted among the available products. Global land use is typically more difficult to map and in many cases cannot be remotely sensed. In-situ or ground-based data and high resolution imagery are thus an important requirement for producing accurate land cover and land use datasets and this is precisely what is lacking. Here we describe the global land cover and land use reference data derived from the Geo-Wiki crowdsourcing platform via four campaigns."
doi <- "https://doi.org/10.1594/PANGAEA.869680"
licence <- "https://creativecommons.org/licenses/by/3.0/"

message("\n---- ", thisDataset, " ----")


message(" --> reading in data")
input_dir <- paste0(occurr_dir, "input/", thisDataset, "/")

bib <- read.bib(file = paste0(input_dir, "10.1038_sdata.2017.75-citation.bib"))

data_path <- paste0(input_dir, "GlobalCrowd.tab")

data <- read_tsv(file = data_path,
                 col_names = FALSE,
                 col_types = cols(.default = "c"),
                 skip = 33)


message(" --> normalizing data")
# temp <- data %>%
#   mutate(
#     # datasetID = thisDataset,
#     fid = row_number(),
#     type = "point",
#     country = NA_character_,
#     x = Longitude,
#     y = Latitude,
#     geometry = NA,
#     epsg = 4326,
#     area = NA_real_,
#     date = `Date/Time (The image date used, entered ...)`,
#     externalID = NA_character_,
#     externalValue = as.character(`LCC (Land Cover 1, 1 = tree cover,...)`),
#     attr_1 = as.character(`LCC (Land Cover 1, 1 = tree cover,...)`),
#     attr_1_typ = "landcover",
#     attr_2 = as.character(`LCC (Land Cover 2, 1 = tree cover,...)`),
#     attr_2_typ = "landcover",
#     attr_3 = as.character(`LCC (Land Cover 1, 1 = tree cover,...)`),
#     attr_3_typ = "landcover",
#     irrigated = NA,
#     presence = TRUE,
#     sample_type = "visual interpretation",
#     collector = "citizen scientist",
#     purpose = "map development") %>%
#   select(datasetID, fid, type, country, x, y, geometry, epsg, area, date,
#          externalID, externalValue, irrigated, presence,
#          sample_type, collector, purpose, everything())
data <- data %>%
  mutate(obsID = row_number(), .before = 1)                                     # define observation ID on raw data to be able to join harmonised data with the rest

schema_INSERT <-
  setFormat(decimal = INSERT, thousand = INSERT, na_values = INSERT) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%                         # the dataset ID
  setIDVar(name = "obsID", type = "i", columns = 1) %>%                         # the observation ID
  setIDVar(name = "externalID", columns = INSERT) %>%                           # the verbatim observation-specific ID as used in the external dataset
  setIDVar(name = "open", type = "l", value = INSERT) %>%                       # whether the dataset is freely available (TRUE) or restricted (FALSE)
  setIDVar(name = "type", value = INSERT) %>%                                   # whether the data are "point" or "areal" (when its from a plot, region, nation, etc)
  setIDVar(name = "x", type = "n", columns = INSERT) %>%                        # the x-value of the coordinate (or centroid if type = "areal")
  setIDVar(name = "y", type = "n", columns = INSERT) %>%                        # the y-value of the coordinate (or centroid if type = "areal")
  setIDVar(name = "epsg", value = INSERT) %>%                                   # the EPSG code of the coordinates or geometry
  setIDVar(name = "geometry", columns = INSERT) %>%                             # the geometries if type = "areal"
  setIDVar(name = "date", columns = INSERT) %>%                                 # the date (as character) of the observation
  setIDVar(name = "irrigated", type = "l", columns = INSERT) %>%                # whether the observation receives irrigation (TRUE) or not (FALSE)
  setIDVar(name = "present", type = "l", columns = INSERT) %>%                  # whether the observation describes a presence (TRUE) or an absence (FALSE)
  setIDVar(name = "sample_type", value = INSERT) %>%                            # from what space the data were collected, either "field/ground", "visual interpretation", "experience", "meta study" or "modelled"
  setIDVar(name = "collector", value = INSERT) %>%                              # who the collector was, either "expert", "citizen scientist" or "student"
  setIDVar(name = "purpose", value = INSERT) %>%                                # what the data were collected for, either "monitoring", "validation", "study" or "map development"
  setObsVar(name = "concept", type = "c", columns = INSERT) %>%                 # the value of the observation

  temp <- reorganise(schema = schema_INSERT, input = data)

other <- data %>%
  slice(-INSERT) %>%                                                            # slice off the rows that contain the header
  select(INSERT)                                                                # remove all columns that are recorded in 'out'


message(" --> harmonizing with ontology")
new_source(name = thisDataset,
           description = description,
           homepage = doi,
           date = ymd("2021-09-13"),
           license = license,
           ontology = odb_onto_path)

# matches <- tibble(new = as.character(sort(unique(c(data$`LCC (Land Cover 1, 1 = tree cover,...)`,
#                                                    data$`LCC (Land Cover 2, 1 = tree cover,...)`,
#                                                    data$`LCC (Land Cover 1, 1 = tree cover,...)`)))),
#                   old = c("Forests", "Shrubland", "Herbaceous associations", "AGRICULTURAL AREAS", "Mosaic of agriculture and natural vegetation", "WETLANDS",
#                           "ARTIFICIAL SURFACES", "Open spaces with little or no vegetation", "Open spaces with little or no vegetation", "WATER BODIES"))

out <- matchOntology(table = temp,
                     columns = "concept",
                     colsAsClass = FALSE,
                     dataseries = thisDataset,
                     ontology = odb_onto_path)


message(" --> writing output")
saveRDS(object = out, file = paste0(occurr_dir, "output/", thisDataset, ".rds"))
saveRDS(object = other, file = paste0(occurr_dir, "output/", thisDataset, "_other.rds"))
saveBIB(object = bib, file = paste0(occurr_dir, "references.bib"))

beep(sound = 10)
message("\n     ... done")
