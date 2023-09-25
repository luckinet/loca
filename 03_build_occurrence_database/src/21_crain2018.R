# script arguments ----
#
thisDataset <- "Crain2018"
description <- "Genomics and phenomics have promised to revolutionize the field of plant breeding. The integration of these two fields has just begun and is being driven through big data by advances in next-generation sequencing and developments of field-based high-throughput phenotyping (HTP) platforms. Each year the International Maize and Wheat Improvement Center (CIMMYT) evaluates tens-of-thousands of advanced lines for grain yield across multiple environments. To evaluate how CIMMYT may utilize dynamic HTP data for genomic selection (GS), we evaluated 1170 of these advanced lines in two environments, drought (2014, 2015) and heat (2015). A portable phenotyping system called ‘Phenocart’ was used to measure normalized difference vegetation index and canopy temperature simultaneously while tagging each data point with precise GPS coordinates. For genomic profiling, genotyping-by-sequencing (GBS) was used for marker discovery and genotyping. Several GS models were evaluated utilizing the 2254 GBS markers along with over 1.1 million phenotypic observations. The physiological measurements collected by HTP, whether used as a response in multivariate models or as a covariate in univariate models, resulted in a range of 33% below to 7% above the standard univariate model. Continued advances in yield prediction models as well as increasing data generating capabilities for both genomic and phenomic data will make these selection strategies tractable for plant breeders to implement increasing the rate of genetic gain."
url <- "https://doi.org/10.3835/plantgenome2017.05.0043 https://"
licence <- ""


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "pericles_1940337211.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-04-13"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "EYT_HTP_GS_Final/OriginalData/", "EYT_Plots.csv"))


# pre-process data ----
#
lon1 <- data %>% select(Plot_id, lon = C2_1_x)
lon2 <- data %>% select(Plot_id, lon = C2_2_x)
lon3 <- data %>% select(Plot_id, lon = C1_1_x)
lon4 <- data %>% select(Plot_id, lon = C1_2_x)

lat1 <- data %>% select(lat = C2_1_y)
lat2 <- data %>% select(lat = C2_2_y)
lat3 <- data %>% select(lat = C1_1_y)
lat4 <- data %>% select(lat = C1_2_y)

temp <- bind_cols(bind_rows(lon1,lon2, lon3, lon4), bind_rows(lat1,lat2, lat3, lat4))

sf_use_s2(FALSE)
tempsf <- temp %>%
  st_as_sf(coords = c("lon", "lat"), crs = "EPSG:4485") %>%
  group_by(Plot_id) %>%
  summarise(geometry = st_combine(geometry)) %>%
  st_cast("POLYGON") %>%
  st_transform(., crs = "EPSG:4326") %>%
  st_make_valid()
sf_use_s2(TRUE)

cen <- st_centroid(tempsf) %>%
  mutate(x = st_coordinates(.)[,1],
         y = st_coordinates(.)[,2]) %>%
  as.data.frame()

temp <- left_join(tempsf, cen, by = "Plot_id") %>%
  left_join(., data, by = "Plot_id")


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Mexico",
    x = x,
    y = y,
    geometry = geometry.x,
    epsg = 4326,
    area = as.numeric(st_area(.)),
    date = ymd(planting_date),
    externalID = NA_character_,
    externalValue = "wheat",
    irrigated = FALSE,
    presence = FALSE,
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
