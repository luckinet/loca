# script arguments ----
#
thisDataset <- "Liangyun2019"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "liangyun.bib"))

regDataset(name = thisDataset,
           description = "A dataset of global land cover validation samples in 2015. In order to guarantee the confidence and objective of the validation samples, several existing reference datasets such as GLCNMO2008 training dataset, VIIRS reference dataset, STEP reference dataset, Global cropland reference data and so on, high resolution imagery in the Google earth and time-series NDVI,NDSI values of each related point are integrated to derive the global validation datasets. The dataset is provided in .shp format.",
           url = "https://doi.org/10.5281/zenodo.3551994",
           download_date = "2022-01-19",
           type = "static",
           licence = "Attribution 4.0 International",
           contact = NA_character_,
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
lc_label <- read_csv2(paste0(thisPath, "LC_Label.csv"))
data <- st_read(paste0(thisPath, "GLC_ValidationSampleSet_v1/GLC_ValidationSampleSet.shp")) %>%
  left_join(., lc_label, by = "sample_lab")


# manage ontology ---
#
matches <- tibble(new = c(...),
                  old = c(...))

newConcept(new = c(),
           broader = c(), # the labels 'new' should be nested into
           class = , # try to keep that as conservative as possible and only come up with new classes, if really needed
           source = thisDataset)

getConcept(label_en = matches$old) %>%
  # ... %>% apply some additional filters (optional)
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = , # in most cases that should be "close", see ?newMapping
             source = thisDataset,
             certainty = )


# harmonise data ----
#
temp <- data %>%
  mutate(
    fid = row_number(),
    type = "point",
    x = lon,
    y = lat,
    year = 2015,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    country = NA_character_,
    irrigated = NA_character_,
    presence = TRUE,
    externalID = NA_character_,
    externalValue = `LCCS Classification system`,
    LC1_orig = `LCCS Classification system`,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "visual interpretation",
    collector = "expert",
    purpose = "validation",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp, type = "in-situ point") %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
