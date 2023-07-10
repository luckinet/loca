# script arguments ----
#
thisDataset <- "gyga"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- ris_reader(paste0(thisPath, "")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "",
           url = "", # ideally the doi, but if it doesn't have one, the main source of the database
           download_date = "", # YYYY-MM-DD
           type = "static",
           licence = "CC BY-NC-SA 3.0",
           contact = "", # optional, if it's a paper that should be "see corresponding author"
           disclosed = "", # whether the data are freely available "yes"/"no"
           bibliography = bib,
           update = TRUE)

# preprocess data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)
if(!"full_dataset.rds" %in% list.files(thisPath)){
  gygaFiles <- list.files(thisPath, pattern = "xlsx", full.names = TRUE)
  map(.x = seq_along(gygaFiles), .f = function(ix){
    read_excel(path = gygaFiles[ix], sheet = 2)
  }) %>%
    bind_rows() %>%
    saveRDS(file = paste0(thisPath, "/full_dataset.rds"))
}


# read dataset ----
#
data <- read_rds(paste0(thisPath, "full_dataset.rds"))


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)


# harmonise data ----
#

temp <- data %>%
  separate(CROP,sep = " ", into = c("irrigated", "crop"), extra = "merge") %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    x = LONGITUDE,
    y = LATITUDE,
    year = NA_real_,
    month = NA_real_,
    day = NA_integer_,
    country = COUNTRY,
    irrigated = case_when(irrigated == "Irrigated" ~ T,
                          irrigated == "Rainfed" ~ F),
    externalID = NA_character_,
    externalValue = crop,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = , # "field", "visual interpretation", "experience", "meta study" or "modelled"
    collector = , # "expert", "citizen scientist" or "student"
    purpose = , # "monitoring", "validation", "study" or "map development"
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

