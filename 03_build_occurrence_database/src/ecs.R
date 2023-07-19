# script arguments ----
#
thisDataset <- "ECS"
description <- "Energy Crops Scheme Agreements - based on Probis extract. The Energy Crops Scheme provides establishment grants for approved energy crops. Approved crops are Short Rotation Coppice (Willow, Poplar, Ash, Alder, Hazel, Silver Birch, Sycamore, Sweet Chestnut and Lime) and Miscanthus (a tall, woody grass). The ECS grant scheme supports the cost of establishment of Miscanthus or Short Rotation Coppice (SRC). Both elements of the Energy Crops Scheme, (which formed part of the England Rural Development Programme), Establishment Grants and Producer Groups, have now closed to new applications.  For details on the Energy Crops Scheme 2007-13 visit Natural England's website (archived).Full metadata can be viewed on data.gov.uk."
url <- "https://doi.org/ https://naturalengland-defra.opendata.arcgis.com/datasets/Defra::energy-crops-scheme-ecs-agreements/about"
licence <- "Open Government Licence"


# reference ----
#
bib <- bibentry(bibtype = "Misc",
                title = "Energy Crops Scheme (ECS) Agreements",
                institution = "Natural England",
                author = "Natural England",
                year = 2020,
                url = "http://naturalengland-defra.opendata.arcgis.com/datasets/energy-crops-scheme-ecs-agreements")

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
data <- read_csv(file = paste0(thisPath, "Energy_Crops_Scheme_(ECS)_Agreements.csv"))


# harmonise data ----
#
data <- data %>%
  st_as_sf(., coords = c("XCOORD", "YCOORD"), crs = CRS("EPSG:27700")) %>%
  st_transform(., crs ="EPSG:4326") %>%
  mutate(lon = st_coordinates(.)[,1],
         lat = st_coordinates(.)[,2]) %>%
  as.data.frame()

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "United Kingdom",
    x = lon,
    y = lat,
    geometry = NA,
    epsg = 4326,
    area = SHAPE_Area,
    date = NA,
    # year = "2007_2008_2009_2010_2011_2012_2013",
    # month = NA_real_,
    # day = NA_integer_,
    externalID = NA_character_,
    externalValue = CROPTYPE,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_") %>%
  mutate( year = as.numeric(year),
          fid = row_number()) %>%
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

# matches <- tibble(new = c(unique(data$CROPTYPE)),
#                   old = c("Bioenergy woody", "miscanthus"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
