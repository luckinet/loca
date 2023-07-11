# script arguments ----
#
thisDataset <- "Krause2021"
description <- "Peatlands play an important role in carbon (C) storage and are estimated to contain 30% of global soil C, despite occupying only 3% of global land area. Historic management of peatlands has led to widespread degradation and loss of important ecosystem services including C sequestration. Legacy drainage features in the peatlands of northern Minnesota were studied to assess the volume of peat and the amount of C that has been lost in the ~100 years since drainage. Using high-resolution Light Detection and Ranging (LiDAR) data, we measured elevation changes adjacent to legacy ditches to model pre-ditch surface elevation, which were used to calculate peat volume loss. We established relationships between volume loss and site characteristics from existing geographic information systems (GIS) datasets and used those relationships to scale volume loss to all mapped peatland ditches in northern Minnesota (USA). This data publication includes a geodatabase containing a feature class describing peatland distribution in two of Minnesota’s ecological provinces (Laurentian Mixed Forest and Tallgrass Prairie Parklands), study sites used in Krause et al. (2021), and a feature class classifying ditches that coincide with peatlands in the study area by predicted volume loss per meter of ditch length based on statistical relationships between volume loss and site characteristics. Also included are the model outputs for the elevation profiles used to estimate total peat volume loss for a given ditch transect and the associated site characteristics. This information was compiled between October 2019 and November 2020 using publicly available datasets."
url <- "https://doi.org/10.2737/RDS-2021-0009 https://" # doi, in case this exists and download url separated by empty space
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(thisPath, "krause_cit.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("09-05-2022"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data_sf <- st_read(dsn = paste0(thisPath, "Data/MN_Peat_Volume.gdb"))
data <- read_excel(path = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", ""))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = NA_character_,
    country = NA_character_,
    x = NA_real_,
    y = NA_real_,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = NA_character_,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = NA,
    sample_type = NA_character_,
    collector = NA_character_,
    purpose = NA_character_) %>%
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
