# script arguments ----
#
thisDataset <- "Anderson2003"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibentry(
  bibtype = "misc",
  title = "SMEX02 Watershed Vegetation Sampling Data, Walnut Creek, Iowa, Version 1",
  author = as.person("M. Anderson [aut]"),
  year = "2003",
  organization = "NASA National Snow and Ice Data Center Distributed Active Archive Center",
  address = "Boulder, Colorado USA",
  doi = "https://doi.org/10.5067/XCGVUPGKER17",
  url = "https://nsidc.org/data/NSIDC-0187/versions/1",
  type = "data set"
)

regDataset(name = thisDataset,
           description = "This data set contains vegetation parameters as part of the Soil Moisture Experiment 2002 (SMEX02).",
           url = "https://doi.org/10.5067/XCGVUPGKER17",
           download_date = "2022-01-13",
           type = "static",
           licence = "",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
coord <- read_xls(paste0(thisPath, "smex02_wc_vegdata.xls"), skip = 1, sheet = 1)
data <- read_xls(paste0(thisPath, "smex02_wc_vegdata.xls"), sheet = 2) %>%
  na.omit()


# manage ontology ---
#
# define labels in the new dataset and their matching already harmonised labels
matches <- tibble(new = c(unique(data$Crop)),
                  old = c("maize", "soybean"))
# getConcept(label_en = matches$old, missing = TRUE)

getConcept(label_en = matches$old) %>%
  # ... %>% apply some additional filters (optional)
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close", # in most cases that should be "close", see ?newMapping
             source = thisDataset,
             certainty = 3) # value from 1:3

a <- coord %>%
  st_as_sf(coords = c("Easting", "Northing"), crs = 26915) %>% st_transform(4326) %>%
  st_coordinates() %>%
  as_tibble()
coord <- cbind(coord, a) %>% select(X,Y,Site,Location,Crop)

temp <- inner_join(data, coord, by = c("Site" = "Site", "Loc" = "Location")) %>%
  separate(Date, c("year","month","day"), sep="-") %>%
  mutate_if(is.character, ~na_if(., -999)) %>%
  mutate(
    fid = row_number(),
    x = X,
    y = Y,
    year = as.numeric(year),
    month = as.numeric(month),
    day = as.integer(day),
    type = "point",
    area = NA_real_,
    geometry = NA,
    datasetID = thisDataset,
    country = "United States",
    irrigated = F,
    externalID = NA_character_,
    externalValue = Crop.x,
    presence = TRUE,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
