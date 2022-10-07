# script arguments ----
#
thisDataset <- "Adina2017"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1600058741.bib")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "Quantifying relationships between plant functional traits and abiotic gradients is valuable for evaluating potential responses of forest communities to climate change. However, the trajectories of change expected to occur in tropical forest functional characteristics as a function of future climate variation are largely unknown. We modeled community level trait values of Costa Rican rain forests as a function of current and future climate, and quantified potential changes in functional composition.",
           url = "https://doi.org/10.1111/ecog.02637",
           download_date = "2021-08-10",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE,
           notes = "time period imprecise")


# read dataset ----
#
data <- read_delim(paste0(thisPath, "observed CWM traits.csv"), delim = ";", n_max = 127)


# manage ontology ---
#
# define labels in the new dataset and their matching already harmonised labels
#matches <- tibble(new = c(...),
#                  old = c(...))
# getConcept(label_en = matches$old, missing = TRUE)

#newConcept(new = c(),
#           broader = c(), # the labels 'new' should be nested into
#           class = , # try to keep that as conservative as possible and only come up with new classes, if really needed
#           source = thisDataset)

#getConcept(label_en = matches$old) %>%
  # ... %>% apply some additional filters (optional)
#  pull(label_en) %>%
#  newMapping(concept = .,
#             external = matches$new,
#             match = , # in most cases that should be "close", see ?newMapping
#             source = thisDataset,
#             certainty = ) # value from 1:3


# harmonise data ----
#
# carry out optional corrections and validations ...


# ... and then reshape the input data into the harmonised format
temp <- data %>%
  distinct(lat, long, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point", # "point" or "areal" (such as plot, region, nation, etc)
    x = long, # x-value of centroid
    y = lat, # y-value of centroid
    year = NA, # dates are missing
    month = NA_real_, # must be NA_real_ if it's not given
    day = NA_integer_, # must be NA_integer_ if it's not given
    country = NA_character_,
    irrigated = NA, # in case the irrigation status is provided
    area = NA, # in case the features are from plots and the table gives areas but no spatial object is available
    presence = FALSE, # whether the data are 'presence' data (TRUE), or whether they are 'absence' data (i.e., that the data point indicates the value in externalValue is not present) (FALSE)
    externalID = PLOT,
    externalValue = "Undisturbed Forest",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field", # "field", "visual interpretation", "experience", "meta study" or "modelled"
    collector = "expert", # "expert", "citizen scientist" or "student"
    purpose = "study", # "monitoring", "validation", "study" or "map development"
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())

# In case we are dealing with areal data, build object that contains polygons
# temp_sf <- temp %>%
#   mutate(geom = ) %>% # select the geometry object
#   select(datasetID, fid, geom)


# write output ----
#
validateFormat(object = temp, type = "in-situ point") %>%
  saveDataset(dataset = thisDataset)

# validateFormat(object = temp_sf, type = "in-situ areal") %>%
#   write_sf(dsn = paste0(thisDataset, "_sf.gpkg"), delete_layer = TRUE)

message("\n---- done ----")
