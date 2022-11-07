# script arguments ----
#
thisDataset <- "Fritz2017"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "GlobalCrowd.ris"))

regDataset(name = thisDataset,
           description = "Global land cover is an essential climate variable and a key biophysical driver for earth system models. While remote sensing technology, particularly satellites, have played a key role in providing land cover datasets, large discrepancies have been noted among the available products. Global land use is typically more difficult to map and in many cases cannot be remotely sensed. In-situ or ground-based data and high resolution imagery are thus an important requirement for producing accurate land cover and land use datasets and this is precisely what is lacking. Here we describe the global land cover and land use reference data derived from the Geo-Wiki crowdsourcing platform via four campaigns.",
           url = "https://doi.org/10.1594/PANGAEA.869680",
           download_date = "2021-09-13",
           type = "static",
           licence = "CC-BY-3.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_tsv(file = paste0(thisPath, "GlobalCrowd.tab"), col_types = "iiidddiddiddidiiii?Didi", skip = 33)


# manage ontology ---
#
matches <- tibble(new = as.character(sort(unique(c(data$`LCC (Land Cover 1, 1 = tree cover,...)`,
                                 data$`LCC (Land Cover 2, 1 = tree cover,...)`,
                                 data$`LCC (Land Cover 1, 1 = tree cover,...)`)))),
                  old = c("Forests", "Shrubland", "Herbaceous associations", "AGRICULTURAL AREAS", "Mosaic of agriculture and natural vegetation", "WETLANDS",
                          "ARTIFICIAL SURFACES", "Open spaces with little or no vegetation", "Open spaces with little or no vegetation", "WATER BODIES"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = ., external = matches$new, match = "close",
             source = thisDataset, certainty = 3)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    date = `Date/Time (The image date used, entered ...)`,
    country = NA_character_, # this is a necessary information now, so we discard this?
    irrigated = NA,
    area = NA_real_,
    presence = TRUE,
    externalID = NA_character_,
    externalValue = as.character(`LCC (Land Cover 1, 1 = tree cover,...)`),
    LC1_orig = as.character(`LCC (Land Cover 1, 1 = tree cover,...)`),
    LC2_orig = as.character(`LCC (Land Cover 2, 1 = tree cover,...)`),
    LC3_orig = as.character(`LCC (Land Cover 1, 1 = tree cover,...)`),
    sample_type = "visual interpretation",
    collector = "citizen scientist",
    purpose = "map development",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, date, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
