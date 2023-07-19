# script arguments ----
#
thisDataset <- "GFSAD30"
description <- "The GFSAD30 is a NASA funded project to provide high resolution global cropland data and their water use that contributes towards global food security in the twenty-first century. The GFSAD30 products are derived through multi-sensor remote sensing data (e.g., Landsat, MODIS, AVHRR), secondary data, and field-plot data and aims at documenting cropland dynamics from 2000 to 2025."
url <- "https://croplands.org/app/data/search?page=1&page_size=200"
license <- ""


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "GFSAD30.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-09-14"),
           type = "static",
           licence = licence,
           contact = "see GFSAD homepage",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "GFSAD30_2000-2010.csv"), col_types = "iiiddciiiiicccl") %>%
  bind_rows(read_csv(paste0(thisPath, "GFSAD30_2011-2021.csv"), col_types = "iiiddciiiiicccl"))


# pre-process data ----
#
data <- data %>%
  filter(!land_use_type == 0 | !crop_primary == 0) %>%
  mutate(jointCol = paste(land_use_type, crop_primary, sep = "-"))


# harmonise data ----
#
temp <- data %>%
  mutate(month = gsub(0, "01", month)) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = country,
    x = lon,
    y = lat,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(paste(year, month, "01", sep = "-")),
    externalID = NA_character_,
    externalValue = paste(land_use_type, crop_primary, sep = "-"),
    irrigated = case_when(water == 0 ~ NA,
                          water == 1 ~ F,
                          water == 2 ~ T),
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose =  "map development") %>%
  drop_na(date, x, y, externalValue) %>%
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

# newConcepts <- tibble(target = c("Temporary cropland", "Open spaces with little or no vegetation", "Herbaceous associations",
#                                  "Forests", "WATER BODIES", "Shrubland",
#                                  "Permanent cropland", "rice", "Urban fabric",
#                                  "Temporary cropland", "sugarcane", "Fallow",
#                                  "potato", "rice", "wheat",
#                                  "maize", "barley", "alfalfa",
#                                  "cotton", "oil palm", "soybean",
#                                  "cassava", "peanut", "millet",
#                                  "sunflower", "LEGUMINOUS CROPS", "Temporary cropland",
#                                  "Temporary grazing", "rapeseed"),
#                       new = unique(temp$jointCol),
#                       class = c("landcover", "landcover", "landcover",
#                                 "landcover", "landcover group", "landcover",
#                                 "landcover", "commodity", "landcover",
#                                 "landcover", "commodity", "land-use",
#                                 "commodity", "commodity", "commodity",
#                                 "commodity", "commodity", "commodity",
#                                 "commodity", "commodity", "commodity",
#                                 "commodity", "commodity", "commodity",
#                                 "commodity", "group", "landcover",
#                                 "land-use", "commodity"),
#                       description = NA,
#                       match = "close",
#                       certainty = 3)

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
