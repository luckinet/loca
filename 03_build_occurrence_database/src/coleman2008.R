# script arguments ----
#
thisDataset <- "Coleman2008"
description <- "This data set includes vegetation data collected over the Soil Moisture Experiment 2003 (SMEX03) area of northern Alabama, USA."
url <- "https://doi.org/10.5067/YVQTPSF4VZ9N https://nsidc.org/data/NSIDC-0348/versions/1"
licence <- ""


# reference ----
#
bib <- bibentry(
  bibtype = "misc",
  title = "SMEX03 Vegetation Data: Alabama, Version 1",
  author = as.person("T. Coleman, T. Tsegaye, R. Metzl, M. Schamschula"),
  year = "2008",
  organization = "NASA National Snow and Ice Data Center Distributed Active Archive Center",
  address = "Boulder, Colorado USA",
  doi = "https://doi.org/10.5067/YVQTPSF4VZ9N",
  url = "https://nsidc.org/data/NSIDC-0348/versions/1",
  type = "data set"
)

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd(),
           type = "study",
           licence = licence,
           contact = NA_character_,
           disclosed = NA,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
cnames <- read_excel(paste0(thisPath, "AL_SMEX03_vegetation.xls"),n_max = 2,col_names= FALSE)
cnames <- sapply(cnames, paste, collapse = " ")
data <- read_xls(paste0(thisPath, "AL_SMEX03_vegetation.xls"), skip = 2, col_names = cnames)


# harmonise data ----
#
data <- data %>%
  mutate_if(is.numeric,~na_if(.,-99)) %>%
  filter(!is.na(`Latitude WGS84`) | !is.na(`Longitude WGS84`)) %>%
  filter(!is.na(year)) %>%
  distinct(`NA Crop`,`Latitude WGS84`,`Longitude WGS84`,.keep_all = TRUE)

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "United States",
    x = `Longitude WGS84`,
    y = `Latitude WGS84`,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = mdy(`Date (mm/dd/yyyy)`),
    externalID = as.character(row_number()),
    externalValue = `NA Crop`,
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

# matches <- tibble(new = c(unique(data$`NA Crop`)),
#                   old = c("maize", "Permanent grazing", "Permanent grazing", "Temporary grazing", "soybean",
#                           "wheat", "wheat", "Permanent grazing", "cotton", "soybean", "Temporary grazing", "Permanent cropland",
#                           "Permanent grazing","Permanent grazing", NA))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
