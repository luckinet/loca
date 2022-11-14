# script arguments ----
#
thisDataset <- "ausCoverb"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibentry(bibtype =  "Misc",
                author = person("Department of Environment and Science"),
                year = 2022,
                title = "SLATS Star Transects - Australian field sites. Version 1.0.0. Terrestrial Ecosystem Research Network",
                organization = "Queensland Government",
                url = "https://portal.tern.org.au/slats-star-transects-field-sites/23207")


regDataset(name = thisDataset,
           description = "The SLATS star transect field dataset has been compiled as a record of vegetative and non-vegetative fractional cover as recorded in situ according to the method described in Muir et al (2011). The datasets are a combination of vegetation fractions collected in three strata - non-woody vegetation including vegetative litter near the soil surface, woody vegetation less than 2 metres, and woody vegetation greater than 2 metres - at homogeneous areas of approximately 1 hectare. This dataset is compiled from a variety of sources, including available sites from the ABARES ground cover reference sites database.",
           url = "https://portal.tern.org.au/slats-star-transects-field-sites/23207",
           download_date = "2022-05-13",
           type = "static",
           licence = "CC BY 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# pre-process data ----
#

# read dataset ----
#
data <- read_csv(file = paste0(thisPath, "star_transects.csv"))

# manage ontology ---
#
data <- data %>% mutate(ontology = paste(data$landuse, data$commod, sep="_"))

matches <- read_csv(file = paste0(thisPath, "star_transects_ontology.csv"))


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
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = ref_x,
    y = ref_y,
    geometry = geom,
    date = obs_time,
    country = NA_character_,
    irrigated = grepl("irrigated", site_desc),
    area = 10000,
    presence = T,
    externalID = NA_character_,
    externalValue = ontology,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
