# script arguments ----
#
thisDataset <- "See2016c"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "Control_3.ris"))

regDataset(name = thisDataset,
           description = "Global land cover is an essential climate variable and a key biophysical driver for earth system models. While remote sensing technology, particularly satellites, have played a key role in providing land cover datasets, large discrepancies have been noted among the available products. Global land use is typically more difficult to map and in many cases cannot be remotely sensed. In-situ or ground-based data and high resolution imagery are thus an important requirement for producing accurate land cover and land use datasets and this is precisely what is lacking. Here we describe the global land cover and land use reference data derived from the Geo-Wiki crowdsourcing platform via four campaigns.",
           url = "https://doi.org/10.1594/PANGAEA.869662",
           download_date = "2021-09-13",
           type = "static",
           licence = "CC-BY-3.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_tsv(file = paste0(thisPath, "Control_3.tab"), skip = 28)


# harmonise data ----
#
temp <- data %>%
  ... %>%
  select(fid, x, y, precision, country, year, month, day, irrigated, datasetID, luckinetID,
         externalID, externalValue, externalLC, sample_type, everything())

# before preparing data for storage, test that all variables are available
assertNames(x = names(temp),
            must.include = c("fid", "x", "y", "precision", "country", "year", "month",
                             "day", "irrigated", "datasetID", "luckinetID", "externalID",
                             "externalValue", "externalLC", "sample_type"))

# make points and attributes table
points <- temp %>%
  select(fid, x, y)

attributes <- temp %>%
  select(-x, -y)

# make a point geom and set the attribute table
geom <- points %>%
  gs_point() %>%
  setFeatures(table = attributes)

# extract column names to harmonise them
meta <- tibble(datasetID = thisDataset,
               region = "",
               column = colnames(data),
               harmonised = rep(NA, length(colnames(data))), # replace with harmonised names in 'temp'
               records = nrow(data)) %>%
  bind_rows(meta) %>%
  distinct()


# write output ----
#
write_csv(meta, paste0(dataDir, "availability_point_data.csv"), na = "")
saveDataset(object = geom, dataset = thisDataset)
