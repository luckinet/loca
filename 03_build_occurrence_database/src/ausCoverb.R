# script arguments ----
#
thisDataset <- "ausCoverb"
description <- "The SLATS star transect field dataset has been compiled as a record of vegetative and non-vegetative fractional cover as recorded in situ according to the method described in Muir et al (2011). The datasets are a combination of vegetation fractions collected in three strata - non-woody vegetation including vegetative litter near the soil surface, woody vegetation less than 2 metres, and woody vegetation greater than 2 metres - at homogeneous areas of approximately 1 hectare. This dataset is compiled from a variety of sources, including available sites from the ABARES ground cover reference sites database."
url <- "https://doi.org/ https://portal.tern.org.au/slats-star-transects-field-sites/23207" # doi, in case this exists and download url separated by empty space
licence <- "CC BY 4.0"


# reference ----
#
bib <- bibentry(bibtype =  "Misc",
                author = person("Department of Environment and Science"),
                year = 2022,
                title = "SLATS Star Transects - Australian field sites. Version 1.0.0. Terrestrial Ecosystem Research Network",
                organization = "Queensland Government",
                url = "https://portal.tern.org.au/slats-star-transects-field-sites/23207")

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("13-05-2022"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(thisPath, "star_transects.csv"))


# harmonise data ----
#
data <- data %>%
  mutate(ontology = paste(data$landuse, data$commod, sep="_"))

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = NA_character_,
    x = ref_x,
    y = ref_y,
    geometry = geom,
    epsg = 4326,
    area = 10000,
    date = obs_time,
    externalID = NA_character_,
    externalValue = ontology,
    irrigated = grepl("irrigated", site_desc),
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
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
