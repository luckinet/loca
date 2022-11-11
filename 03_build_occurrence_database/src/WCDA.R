# script arguments ----
#
thisDataset <- "WCDA"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "",
           url = "",
           type = "",
           licence = "",
           bibliography = bib,
           update = )


# preprocess data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#
data <- read_csv(paste0(thisPath, ""))


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
