# script arguments ----
#
thisDataset <- "Truckenbrodt2017"
description <- "Ground reference data are a prerequisite for the calibration, update, and validation of retrieval models facilitating the monitoring of land parameters based on Earth Observation data. Here, we describe the acquisition of a comprehensive ground reference database which was created to test and validate the recently developed Earth Observation Land Data Assimilation System (EO-LDAS) and products derived from remote sensing observations in the visible and infrared range. In situ data were collected for seven crop types (winter barley, winter wheat, spring wheat, durum, winter rape, potato, and sugar beet) cultivated on the agricultural Gebesee test site, central Germany, in 2013 and 2014. The database contains information on hyperspectral surface reflectance factors, the evolution of biophysical and biochemical plant parameters, phenology, surface conditions, atmospheric states, and a set of ground control points. Ground reference data were gathered at an approximately weekly resolution and on different spatial scales to investigate variations within and between acreages. In situ data collected less than 1 day apart from satellite acquisitions (RapidEye, SPOT 5, Landsat-7 and -8) with a cloud coverage ≤25% are available for 10 and 15 days in 2013 and 2014, respectively. The measurements show that the investigated growing seasons were characterized by distinct meteorological conditions causing interannual variations in the parameter evolution. Here, the experimental design of the field campaigns, and methods employed in the determination of all parameters, are described in detail. Insights into the database are provided and potential fields of application are discussed. The data will contribute to a further development of crop monitoring methods based on remote sensing techniques. The database is freely available at PANGAEA (https://doi.org/10.1594/PANGAEA.874251)."
url <- "https://doi.org/10.1594/PANGAEA.874144 https://"
licence <- "CC-BY-3.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Truckenbrodt_classi_error_FVC.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-05-11"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_tsv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Truckenbrodt_classi_error_FVC.tab"), skip = 49)


# harmonise data ----
#
temp <- data %>%
  distinct(`Latitude (ESU, Transformed differential...)`, `Longitude (ESU, Transformed differential...)`,
           `Date/Time (Image Acquisition date)`, `Species (Species cultivated in growing...)`, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Germany",
    x = `Longitude (ESU, Transformed differential...)`,
    y = `Latitude (ESU, Transformed differential...)`,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(`Date/Time (Image Acquisition date)`),
    externalID = NA_character_,
    externalValue = `Species (Species cultivated in growing...)`,
    irrigated = FALSE,
    presence = TRUE,
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

# matches <- tibble(new = c(unique(data$`Species (Species cultivated in growing...)`)),
#                   old = c("rapeseed", "wheat", "potato", "barley", "sugarbeet",
#                           "wheat", "wheat"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
