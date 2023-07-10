# script arguments ----
#
thisDataset <- "Anderson2003"
description <- "This data set contains vegetation parameters as part of the Soil Moisture Experiment 2002 (SMEX02)."
url <- "https://doi.org/10.5067/XCGVUPGKER17 https://"
licence <- ""


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
           description = description,
           url = url,
           download_date = dmy("13-01-2022"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
coord <- read_xls(paste0(thisPath, "smex02_wc_vegdata.xls"), skip = 1, sheet = 1)
data <- read_xls(paste0(thisPath, "smex02_wc_vegdata.xls"), sheet = 2) %>%
  na.omit()


# harmonise data ----
#
a <- coord %>%
  st_as_sf(coords = c("Easting", "Northing"), crs = 26915) %>% st_transform(4326) %>%
  st_coordinates() %>%
  as_tibble()
coord <- cbind(coord, a) %>% select(X,Y,Site,Location,Crop)

temp <- inner_join(data, coord, by = c("Site" = "Site", "Loc" = "Location")) %>%
  separate(Date, c("year","month","day"), sep="-") %>%
  mutate_if(is.character, ~na_if(., -999)) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "United States",
    x = X,
    y = Y,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = as.numeric(year),
    # month = as.numeric(month),
    # day = as.integer(day),
    externalID = NA_character_,
    externalValue = Crop.x,
    irrigated = FALSE,
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
