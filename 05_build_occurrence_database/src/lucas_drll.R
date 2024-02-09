# script arguments ----
#
thisDataset <- "lucas_drll"
description <- ""                                                               # the abstract (if paper available) or project description
doi <- "https://doi.org/10.1016/j.envsoft.2023.105931"
licence <- "https://data.jrc.ec.europa.eu/licence/com_reuse"

message("\n---- ", thisDataset, " ----")
# http://data.europa.eu/89h/c6166c60-5221-437b-87ed-3aaec123801f

# reference ----
#
bib <- bibtex_reader(paste0(occurr_dir, "input/", thisDataset, "/", "S1364815223003171.bib"))


# read dataset ----
#
data_path <- paste0(occurr_dir, "input/", thisDataset, "/", "dataset_lucas_info.csv")

data <- read_csv(file = data_path,
                 col_names = FALSE,
                 col_types = cols(.default = "c"))


# harmonise data ----
#
data <- data %>%
  mutate(obsID = row_number(), .before = 1)                                     # define observation ID on raw data to be able to join harmonised data with the rest

schema_ <-
  setFormat(decimal = , thousand = , na_values = ) %>%
  setIDVar(name = "datasetID", value = thisDataset) %>%                         # the dataset ID
  setIDVar(name = "obsID", columns = 1) %>%                                     # the observation ID
  setIDVar(name = "externalID", columns = ) %>%                                 # the verbatim observation-specific ID as used in the external dataset
  setIDVar(name = "open", value = "") %>%                                       # whether the dataset is freely available (TRUE) or restricted (FALSE)
  setIDVar(name = "type", value = "") %>%                                       # whether the data are "point" or "areal" (when its from a plot, region, nation, etc)
  setIDVar(name = "x", columns = ) %>%                                          # the x-value of the coordinate (or centroid if type = "areal")
  setIDVar(name = "y", columns = ) %>%                                          # the y-value of the coordinate (or centroid if type = "areal")
  setIDVar(name = "epsg", value = "") %>%                                       # the EPSG code of the coordinates or geometry
  setIDVar(name = "geometry", columns = ) %>%                                   # the geometries if type = "areal"
  setIDVar(name = "date", columns = ) %>%                                       # the date of the observation
  setIDVar(name = "sample_type", value = "") %>%                                # from what space the data were collected, either "field/ground", "visual interpretation", "experience", "meta study" or "modelled"
  setIDVar(name = "collector", value = "") %>%                                  # who the collector was, either "expert", "citizen scientist" or "student"
  setIDVar(name = "purpose", value = "") %>%                                    # what the data were collected for, either "monitoring", "validation", "study" or "map development"
  setObsVar(name = "value", columns = ) %>%                                     # the value of the observation
  setObsVar(name = "irrigated", columns = ) %>%                                 # whether the observation receives irrigation (TRUE) or not (FALSE)
  setObsVar(name = "present", columns = ) %>%                                   # whether the observation describes a presence (TRUE) or an absence (FALSE)
  setObsVar(name = "area", columns = )                                          # the area covered by the observation (if type = "areal")

out <- reorganise(schema = schema_, input = data)

otherData <- data %>%
  select()                                                                      # remove all columns that are recorded in 'out'


# harmonize with ontology ----
#
new_source(name = thisDataset,
           description = description,
           homepage = doi,
           date = ymd(),                                                        # the download date
           license = licence,
           ontology = onto_path)

landcover <- temp %>%
  filter(class == "landcover") %>%
  rename(landcover = value) %>%
  matchOntology(columns = "landcover",
                dataseries = thisDataset,
                ontology = onto_path)

landuse <- temp %>%
  filter(class == "landuse") %>%
  rename(landuse = value) %>%
  matchOntology(columns = "landuse",
                dataseries = thisDataset,
                ontology = onto_path)

crop <- temp %>%
  filter(class == "crop") %>%
  rename(crop = value) %>%
  matchOntology(columns = "crop",
                dataseries = thisDataset,
                ontology = onto_path)

animal <- temp %>%
  filter(class == "animal") %>%
  rename(animal = value) %>%
  matchOntology(columns = "animal",
                dataseries = thisDataset,
                ontology = onto_path)

out <- bind_rows(landcover, landuse, crop, animal)


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



