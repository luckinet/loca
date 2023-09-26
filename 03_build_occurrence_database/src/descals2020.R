# script arguments ----
#
thisDataset <- "Descals2020"
description <- "Oil seed crops, especially oil palm, are among the most rapidly expanding agricultural land uses, and their expansion is known to cause significant environmental damage. Accordingly, these crops often feature in public and policy debates which are hampered or biased by a lack of accurate information on environmental impacts. In particular, the lack of accurate global crop maps remains a concern. Recent advances in deep-learning and remotely sensed data access make it possible to address this gap. We present a map of closed-canopy oil palm (Elaeis guineensis) plantations by typology (industrial versus smallholder plantations) at the global scale and with unprecedented detail (10m resolution) for the year 2019. The DeepLabv3+ model, a convolutional neural network (CNN) for semantic segmentation, was trained to classify Sentinel-1 and Sentinel-2 images onto an oil palm land cover map. The characteristic backscatter response of closed-canopy oil palm stands in Sentinel-1 and the ability of CNN to learn spatial patterns, such as the harvest road networks, allowed the distinction between industrial and smallholder plantations globally (overall accuracy=98.52±0.20%), outperforming the accuracy of existing regional oil palm datasets that used conventional machine-learning algorithms. The user's accuracy, reflecting commission error, in industrial and smallholders was 88.22±2.73% and 76.56±4.53%, and the producer's accuracy, reflecting omission error, was 75.78±3.55% and 86.92±5.12%, respectively. The global oil palm layer reveals that closed-canopy oil palm plantations are found in 49 countries, covering a mapped area of 19.60Mha; the area estimate was 21.00±0.42Mha (72.7% industrial and 27.3% smallholder plantations). Southeast Asia ranks as the main producing region with an oil palm area estimate of 18.69±0.33Mha or 89% of global closed-canopy plantations. Our analysis confirms significant regional variation in the ratio of industrial versus smallholder growers, but it also confirms that, from a typical land development perspective, large areas of legally defined smallholder oil palm resemble industrial-scale plantings. Since our study identified only closed-canopy oil palm stands, our area estimate was lower than the harvested area reported by the Food and Agriculture Organization (FAO), particularly in West Africa, due to the omission of young and sparse oil palm stands, oil palm in nonhomogeneous settings, and semi-wild oil palm plantations. An accurate global map of planted oil palm can help to shape the ongoing debate about the environmental impacts of oil seed crop expansion, especially if other crops can be mapped to the same level of accuracy. As our model can be regularly rerun as new images become available, it can be used to monitor the expansion of the crop in monocultural settings. The global oil palm layer for the second half of 2019 at a spatial resolution of 10 m can be found at https://doi.org/10.5281/zenodo.4473715 (Descals et al., 2021)."
url <- "https://doi.org/10.5194/essd-13-1211-2021 https://zenodo.org/record/4473715#.YfPn9abMI2w"
licence <- "CC BY 4.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "essd-13-1211-2021.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("16-12-2021"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- st_read(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Validation_points_GlobalOilPalmLayer_2019/Validation_points_GlobalOilPalmLayer_2019.shp"))


# harmonise data ----
#
coords <- data %>%
  st_coordinates() %>%
  as_tibble()

temp <- data %>%
  st_drop_geometry() %>%
  as_tibble() %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = coords$X,
    y = coords$Y,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = dmy("01-01-2019"),
    externalID = NA_character_,
    externalValue = as.character(Class),
    irrigated = NA,
    presence = if_else(condition = Class == 2, FALSE, TRUE),
    sample_type = "visual interpretation",
    collector = "expert",
    purpose = "map development") %>%
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

# matches <- tibble(new = as.character(sort(unique(data$Class))),
#                   old = c("Industrial closed-canopy oil palm plantation",
#                           "Smallholder closed-canopy oil palm plantation",
#                           "Other land covers/uses that are not closed canopy oil palm"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)

# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
