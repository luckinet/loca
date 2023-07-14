# script arguments ----
#
thisDataset <- "CaWa"
description <- "Land cover is a key variable in the context of climate change. In particular, crop type information is essential to understand the spatial distribution of water usage and anticipate the risk of water scarcity and the consequent danger of food insecurity. This applies to arid regions such as the Aral Sea Basin (ASB), Central Asia, where agriculture relies heavily on irrigation. Here, remote sensing is valuable to map crop types, but its quality depends on consistent ground-truth data. Yet, in the ASB, such data are missing. Addressing this issue, we collected thousands of polygons on crop types, 97.7% of which in Uzbekistan and the remaining in Tajikistan. We collected 8,196 samples between 2015 and 2018, 213 in 2011 and 26 in 2008. Our data compile samples for 40 crop types and is dominated by “cotton” (40%) and “wheat”, (25%). These data were meticulously validated using expert knowledge and remote sensing data and relied on transferable, open-source workflows that will assure the consistency of future sampling campaigns."
url <- "https://doi.org/10.1038/s41597-020-00591-2 https://doi.org/10.6084/m9.figshare.12047478"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_s41597-020-00591-2-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-09-14"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- st_read(paste0(thisPath, "CAWa_CropType_samples.shp")) %>%
  separate_rows(label_1, sep = "-")


# pre-process data ----
#
sf_use_s2(FALSE)
temp <- data %>%
  st_make_valid(data) %>%
  st_centroid() %>%
  mutate(
    x = st_coordinates(.)[,1],
    y = st_coordinates(.)[,2]
  ) %>%
  select(x,y,sampler) %>%
  as.tibble()
sf_use_s2(TRUE)

data <- bind_cols(data, temp)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = country,
    x = x,
    y = y,
    geometry = geometry...9,
    epsg = 4326,
    area = area...8,
    date = ymd(date),
    externalID = NA_character_,
    externalValue = label_1,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "validation") %>%
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

# newConcepts <- tibble(target = c("cotton", "wheat", NA,
#                                  "Tree orchards", "rice", "VEGETABLES",
#                                  "maize", "alfalfa", "melon",
#                                  "Grapes", "Fallow", "sorghum",
#                                  NA, "soybean", "barley",
#                                  "carrot", "potato", "carrot",
#                                  "cabbage", "onion", "bean",
#                                  "sunflower", "tomato", "oat",
#                                  "potato", "pumpkin"),
#                       new = unique(data$label_1),
#                       class = c("commodity", "commodity", NA,
#                                 "land-use", "commodity", "group",
#                                 "commodity", "commodity", "commodity",
#                                 "group", "land-use", "commodity",
#                                 NA, "commodity", "commodity",
#                                 "commodity", "commodity", "commodity",
#                                 "commodity", "commodity", "commodity",
#                                 "commodity", "commodity", "commodity",
#                                 "commodity", "commodity"
#                       ),
#                       description = "",
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
