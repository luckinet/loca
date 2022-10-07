# script arguments ----
#
thisDataset <- "Coleman2008"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

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
           description = "This data set includes vegetation data collected over the Soil Moisture Experiment 2003 (SMEX03) area of northern Alabama, USA.",
           url = "https://nsidc.org/data/NSIDC-0348/versions/1",
           type = "study",
           licence = "",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
cnames <- read_excel(paste0(thisPath, "AL_SMEX03_vegetation.xls"),n_max = 2,col_names= FALSE)
cnames <- sapply(cnames, paste, collapse = " ")
data <- read_xls(paste0(thisPath, "AL_SMEX03_vegetation.xls"), skip = 2, col_names = cnames)



# manage ontology ---
#
matches <- tibble(new = c(unique(data$`NA Crop`)),
                  old = c("maize", "Permanent grazing", "Permanent grazing", "Temporary grazing", "soybean",
                          "wheat", "wheat", "Permanent grazing", "cotton", "soybean", "Temporary grazing", "Permanent cropland",
                          "Permanent grazing","Permanent grazing", NA))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)

# harmonise data ----
#
unique_data <- data %>%
  mutate_if(is.numeric,~na_if(.,-99)) %>%
  filter(!is.na(`Latitude WGS84`) | !is.na(`Longitude WGS84`)) %>%
  filter(!is.na(year)) %>%
  distinct(`NA Crop`,`Latitude WGS84`,`Longitude WGS84`,.keep_all = TRUE)

temp <- unique_data %>%
  mutate(fid = seq_along(`NA Field`),
         x = `Longitude WGS84`,
         y = `Latitude WGS84`,
         country = "United States",
         date = mdy(`Date (mm/dd/yyyy)`),
         irrigated = FALSE,
         datasetID = thisDataset,
         externalID = as.character(row_number()),
         externalValue = `NA Crop`,
         LC1_orig = NA_character_,
         LC2_orig = NA_character_,
         LC3_orig = NA_character_,
         sample_type = "field",
         collector = "expert",
         type = "point",
         area = NA_real_,
         geometry = NA,
         purpose = "study",
         presence = TRUE,
         epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())

# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
