# script arguments ----
#
thisDataset <- "Meddens2017"
description <- "We established a Landsat-derived geospatial database of unburned islands within 2,298 fires across the Inland Northwestern US (including eastern Washington, eastern Oregon, and Idaho) from 1984-2014. The detection of unburned areas within these fires is based upon a classification tree approach that uses two pre- and post-fire Landsat image pairs (see Meddens et al 2016 for details). The data set consist of unburned patches within each fire that are two pixels or larger. This database will be useful for identifying fire refugia, seed sources, and can be used as an overall metric of fire impacts across the northwestern US. (Meddens, A.J., Kolden, C.A., & Lutz, J.A. (2016). Detecting unburned areas within wildfire perimeters using Landsat and ancillary data across the northwestern United States. Remote Sensing of Environment, 186, 275-285)."
url <- "https://www.sciencebase.gov/catalog/item/59a7452ce4b0fd9b77cf6ca0, https://doi.org/10.1016/j.rse.2016.08.023"
license <- ""


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "S0034425716303261.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-10-18"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- st_read(dsn = paste0(thisPath, "Meddens_Unburned_areas_Database_170830")) %>%
  rename(Fire_ID = fire_id) %>%
  left_join(., read_csv(file = paste0(thisPath, "Meddens_Unburned_areas_Database_170830/Meddens_Unburned_areas_Database_170830_additional_info.csv")), by = "Fire_ID")


# harmonise data ----
#
data <- st_cast(data, "POLYGON")

data <- data %>%
  st_make_valid() %>%
  mutate(area = st_area(.)) %>%
  st_centroid(.) %>%
  mutate(
    x = st_coordinates(.)[,1],
    y = st_coordinates(.)[,2])

temp <- data %>%
  separate(Fire_DOY, into = c("year", "DOY"), sep = 4) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "USA",
    x = x,
    y = y,
    geometry = geometry,
    epsg = 4326,
    area = as.numeric(area),
    date = as.Date(as.numeric(DOY), origin = paste0(year, "-01-01")),
    externalID = as.character(ID),
    externalValue = "FOREST AND SEMI-NATURAL AREAS",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "modelled",
    collector = "expert",
    purpose = "monitoring") %>%
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
