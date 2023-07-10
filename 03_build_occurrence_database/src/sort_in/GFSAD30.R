# script arguments ----
#
thisDataset <- "GFSAD30"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "The GFSAD30 is a NASA funded project to provide high resolution global cropland data and their water use that contributes towards global food security in the twenty-first century. The GFSAD30 products are derived through multi-sensor remote sensing data (e.g., Landsat, MODIS, AVHRR), secondary data, and field-plot data and aims at documenting cropland dynamics from 2000 to 2025."
url <- "https://croplands.org/app/data/search?page=1&page_size=200"
license <- ""

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "GFSAD30.bib"))

regDataset(name = thisDataset,
           description = ,
           url = url,
           download_date = "2021-09-14",
           type = "static",
           licence = licence,
           contact = "see GFSAD homepage",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "GFSAD30_2000-2010.csv"), col_types = "iiiddciiiiicccl") %>%
  bind_rows(read_csv(paste0(thisPath, "GFSAD30_2011-2021.csv"), col_types = "iiiddciiiiicccl"))


# preprocess for ontology
#

temp <- data %>%
  filter(!land_use_type == 0 | !crop_primary == 0) %>%
  mutate(jointCol = paste(land_use_type, crop_primary, sep = "-"))


# manage ontology ---
#
newConcepts <- tibble(target = c("Temporary cropland", "Open spaces with little or no vegetation", "Herbaceous associations",
                                 "Forests", "WATER BODIES", "Shrubland",
                                 "Permanent cropland", "rice", "Urban fabric",
                                 "Temporary cropland", "sugarcane", "Fallow",
                                 "potato", "rice", "wheat",
                                 "maize", "barley", "alfalfa",
                                 "cotton", "oil palm", "soybean",
                                 "cassava", "peanut", "millet",
                                 "sunflower", "LEGUMINOUS CROPS", "Temporary cropland",
                                 "Temporary grazing", "rapeseed"),
                      new = unique(temp$jointCol),
                      class = c("landcover", "landcover", "landcover",
                                "landcover", "landcover group", "landcover",
                                "landcover", "commodity", "landcover",
                                "landcover", "commodity", "land-use",
                                "commodity", "commodity", "commodity",
                                "commodity", "commodity", "commodity",
                                "commodity", "commodity", "commodity",
                                "commodity", "commodity", "commodity",
                                "commodity", "group", "landcover",
                                "land-use", "commodity"),
                      description = NA,
                      match = "close",
                      certainty = 3)

luckiOnto <- new_source(name = thisDataset,
                        description = description,
                        date = Sys.Date(),
                        homepage = url,
                        license = license,
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = newConcepts$new,
                         target = get_concept(x = newConcepts %>% select(label = target), ontology = luckiOnto),
                         source = thisDataset,
                         description = newConcepts$description,
                         match = newConcepts$match,
                         certainty = newConcepts$certainty,
                         ontology = luckiOnto, matchDir = paste0(occurrenceDBDir, "01_concepts/"))




# harmonise data ----
#

temp <- temp %>%
  mutate(month = gsub(0, "01", month)) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = lon,
    y = lat,
    geometry = NA,
    date = ymd(paste(year, month, "01", sep = "-")),
    country = country,
    irrigated = case_when(water == 0 ~ NA,
                          water == 1 ~ F,
                          water == 2 ~ T),
    area = NA_real_,
    presence = T,
    externalID = NA_character_,
    externalValue = paste(land_use_type, crop_primary, sep = "-"),
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose =  "map development",
    epsg = 4326) %>%
  drop_na(date, x, y, externalValue) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
