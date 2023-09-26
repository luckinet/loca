# script arguments ----
#
thisDataset <- "Ledo2019"
description <- "A global, unified dataset on Soil Organic Carbon (SOC) changes under perennial crops has not existed till now. We present a global, harmonised database on SOC change resulting from perennial crop cultivation. It contains information about 1605 paired-comparison empirical values (some of which are aggregated data) from 180 different peer-reviewed studies, 709 sites, on 58 different perennial crop types, from 32 countries in temperate, tropical and boreal areas; including species used for food, bioenergy and bio-products. The database also contains information on climate, soil characteristics, management and topography. This is the first such global compilation and will act as a baseline for SOC changes in perennial crops. It will be key to supporting global modelling of land use and carbon cycle feedbacks, and supporting agricultural policy development."
url <- "https://doi.org/10.6084/m9.figshare.7637210.v2, https://doi.org/10.1038/s41597-019-0062-1"
license <- "CC BY 4.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "7637210.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-19"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xls(path = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "SOC perennials DATABASE.xls"), sheet = 5, skip = 1)


# harmonise data ----
#
temp <- data %>%
  distinct(Longitud, Latitud, CROP_current, year_measure, .keep_all = T) %>%
  separate_rows(CROP_current, sep = "-") %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = country,
    x = Longitud,
    y = Latitud,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(paste(year_measure, "-01-01")),
    externalID = as.character(ID),
    externalValue = CROP_current,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = TRUE,
    sample_type = "meta study",
    collector = "expert",
    purpose = "study") %>%
  drop_na(date) %>%
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

# onto <- read_csv2(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "ontology_ledo2019.csv"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
