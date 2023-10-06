# script arguments ----
#
thisDataset <- "OFSA"
description <- "The aim of the OFS is to encourage the expansion of organic production. Under the scheme, farmers moving from conventional to organic farming methods receive financial help during the conversion process. The scheme is now closed to new applications but has been replaced by Organic "
url <- "https://doi.org/ http://naturalengland-defra.opendata.arcgis.com/datasets/organic-farming-scheme-agreements"
licence <- "Open Government Licence"


# reference ----
#
bib <- bibentry(bibtype = "Misc",
                title = "Organic Farming Scheme Agreements",
                institution = "Natural England",
                author = "Natural England",
                year = 2020,
                url = "http://naturalengland-defra.opendata.arcgis.com/datasets/organic-farming-scheme-agreements")

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-06-04"),
           type = "static",
           licence = licence,
           contact = "data.services@naturalengland.org.uk",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- st_read(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Organic_Farming_Scheme_Agreements"))


# pre-process data ----
#
temp <- data %>%
  st_centroid() %>%
  st_transform(., crs = "EPSG:4326")%>%
  mutate(Start = year(ymd_hms(AGREEMEN_1)),
                End = year(ymd_hms(AGREEMEN_2)),
                lon = st_coordinates(.)[,1],
                lat = st_coordinates(.)[,2]) %>%
  as.data.frame() %>%
  bind_cols(., data$geometry)

temp1 <- temp %>%
  transmute(FID, year = map2(Start, End, `:`)) %>%
  unnest %>%
  left_join(., data, by = "FID") %>%
  left_join(., temp, by = "FID")


# harmonise data ----
#
temp <- temp1 %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "United Kingdom",
    x = lon,
    y = lat,
    geometry = `...21`,
    epsg = 4326,
    area = SHAPE_Area.x,
    date = NA,
    # year = as.numeric(year),
    # month = NA_real_,
    # day = NA_integer_,
    externalID = as.character(FID),
    externalValue = "Permanent cropland",
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
