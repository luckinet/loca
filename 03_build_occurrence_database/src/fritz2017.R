# script arguments ----
#
thisDataset <- "Fritz2017"
description <- "Global land cover is an essential climate variable and a key biophysical driver for earth system models. While remote sensing technology, particularly satellites, have played a key role in providing land cover datasets, large discrepancies have been noted among the available products. Global land use is typically more difficult to map and in many cases cannot be remotely sensed. In-situ or ground-based data and high resolution imagery are thus an important requirement for producing accurate land cover and land use datasets and this is precisely what is lacking. Here we describe the global land cover and land use reference data derived from the Geo-Wiki crowdsourcing platform via four campaigns."
url <- "https://doi.org/10.1594/PANGAEA.869680 https://"
licence <- "CC-BY-3.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "GlobalCrowd.ris"))

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
data <- read_tsv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "GlobalCrowd.tab"), col_types = "iiidddiddiddidiiii?Didi", skip = 33)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = `Date/Time (The image date used, entered ...)`,
    externalID = NA_character_,
    externalValue = as.character(`LCC (Land Cover 1, 1 = tree cover,...)`),
    attr_1 = as.character(`LCC (Land Cover 1, 1 = tree cover,...)`),
    attr_1_typ = "landcover",
    attr_2 = as.character(`LCC (Land Cover 2, 1 = tree cover,...)`),
    attr_2_typ = "landcover",
    attr_3 = as.character(`LCC (Land Cover 1, 1 = tree cover,...)`),
    attr_3_typ = "landcover",
    irrigated = NA,
    presence = TRUE,
    sample_type = "visual interpretation",
    collector = "citizen scientist",
    purpose = "map development") %>%
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

# matches <- tibble(new = as.character(sort(unique(c(data$`LCC (Land Cover 1, 1 = tree cover,...)`,
#                                                    data$`LCC (Land Cover 2, 1 = tree cover,...)`,
#                                                    data$`LCC (Land Cover 1, 1 = tree cover,...)`)))),
#                   old = c("Forests", "Shrubland", "Herbaceous associations", "AGRICULTURAL AREAS", "Mosaic of agriculture and natural vegetation", "WETLANDS",
#                           "ARTIFICIAL SURFACES", "Open spaces with little or no vegetation", "Open spaces with little or no vegetation", "WATER BODIES"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)

# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
