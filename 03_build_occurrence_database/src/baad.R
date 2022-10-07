# script arguments ----
#
thisDataset <- "BAAD"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1939917096.bib"))

regDataset(name = thisDataset,
           description = "Understanding how plants are constructed; i.e., how key size dimensions and the amount of mass invested in different tissues varies among individuals; is essential for modeling plant growth, estimating carbon stocks, and mapping energy fluxes in the terrestrial biosphere.",
           url = "https://dx.doi.org/10.1890/14-1889.1",
           download_date = "2019-09-10",
           type = "static",
           licence = "CC BY 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "baad_data/baad_data.csv"))


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
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = , # "point" or "areal" (such as plot, region, nation, etc)
    x = , # x-value of centroid
    y = , # y-value of centroid
    year = ,
    month = , # must be NA_real_ if it's not given
    day = , # must be NA_integer_ if it's not given
    country = NA_character_,
    irrigated = , # in case the irrigation status is provided
    area = , # in case the features are from plots and the table gives areas but no spatial object is available
    presence = , # whether the data are 'presence' data (TRUE), or whether they are 'absence' data (i.e., that the data point indicates the value in externalValue is not present) (FALSE)
    externalID = NA_character_,
    externalValue = ,
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

message("\n---- done ----")
