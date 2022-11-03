# script arguments ----
#
thisDataset <- "Krause2021"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "Peatlands play an important role in carbon (C) storage and are estimated to contain 30% of global soil C, despite occupying only 3% of global land area. Historic management of peatlands has led to widespread degradation and loss of important ecosystem services including C sequestration. Legacy drainage features in the peatlands of northern Minnesota were studied to assess the volume of peat and the amount of C that has been lost in the ~100 years since drainage. Using high-resolution Light Detection and Ranging (LiDAR) data, we measured elevation changes adjacent to legacy ditches to model pre-ditch surface elevation, which were used to calculate peat volume loss. We established relationships between volume loss and site characteristics from existing geographic information systems (GIS) datasets and used those relationships to scale volume loss to all mapped peatland ditches in northern Minnesota (USA). This data publication includes a geodatabase containing a feature class describing peatland distribution in two of Minnesota’s ecological provinces (Laurentian Mixed Forest and Tallgrass Prairie Parklands), study sites used in Krause et al. (2021), and a feature class classifying ditches that coincide with peatlands in the study area by predicted volume loss per meter of ditch length based on statistical relationships between volume loss and site characteristics. Also included are the model outputs for the elevation profiles used to estimate total peat volume loss for a given ditch transect and the associated site characteristics. This information was compiled between October 2019 and November 2020 using publicly available datasets."
url <- "https://doi.org/10.2737/RDS-2021-0009"
license <- ""


# reference ----
#
bib <- ris_reader(paste0(thisPath, "krause_cit.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2022-05-09",
           type = "static",
           licence = license,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           path = occurrenceDBDir)

# read dataset ----
#

data <- st_read(dsn = paste0(thisPath, "Data/MN_Peat_Volume.gdb"))
data <- data1

# manage ontology ---
#
newConcepts <- tibble(target = ,
                      new = ,
                      class = ,
                      description = ,
                      match = ,
                      certainty = )

luckiOnto <- new_source(name = thisDataset,
                        description = description,
                        date = Sys.Date(),
                        homepage = url,
                        license = license,
                        ontology = luckiOnto)

# in case new harmonised concepts appear here (avoid if possible)
# luckiOnto <- new_concept(new = , broader = , class = , description = ,
#                          ontology = luckiOnto)

luckiOnto <- new_mapping(new = newConcepts$new,
                         target = get_concept(x = newConcepts %>% select(label = target), ontology = luckiOnto),
                         source = thisDataset,
                         description = newConcepts$description,
                         match = newConcepts$match,
                         certainty = newConcepts$certainty,
                         ontology = luckiOnto, matchDir = paste0(occurrenceDBDir, "01_concepts/"))


# harmonise data ----
#
# carry out optional corrections and validations ...


# ... and then reshape the input data into the harmonised format
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = , # "point" or "areal" (such as plot, region, nation, etc)
    x = , # x-value of centroid
    y = , # y-value of centroid
    geometry = NA,
    date = , # must be 'POSIXct' object, see lubridate-package. These can be very easily created for instance with dmy(SURV_DATE), if its in day/month/year format
    country = NA_character_, # the country of each observation/row
    irrigated = , # in case the irrigation status is provided
    area = , # in case the features are from plots and the table gives areas but no spatial object is available
    presence = , # whether the data are 'presence' data (TRUE), or whether they are 'absence' data (i.e., that the data point indicates the value in externalValue is not present) (FALSE)
    externalID = NA_character_, # the external ID of the input data
    externalValue = , # the column of the land use classification
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = , # "field", "visual interpretation", "experience", "meta study" or "modelled"
    collector = , # "expert", "citizen scientist" or "student"
    purpose = , # "monitoring", "validation", "study" or "map development"
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
