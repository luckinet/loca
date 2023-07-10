# script arguments ----
#
thisDataset <- "Li2018"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_sdata.2018.169-citation.ris")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "Reliable data on biomass produced by lignocellulosic bioenergy crops are essential to identify sustainable bioenergy sources. Field studies have been performed for decades on bioenergy crops, but only a small proportion of the available data is used to explore future land use scenarios including bioenergy crops. A global dataset of biomass production for key lignocellulosic bioenergy crops is thus needed to disentangle the factors impacting biomass production in different regions. Such dataset will be also useful to develop and assess bioenergy crop modelling in integrated assessment socio-economic models and global vegetation models. Here, we compiled and described a global biomass yield dataset based on field measurements. We extracted 5,088 entries of data from 257 published studies for five main lingocellulosic bioenergy crops: eucalypt, Miscanthus, poplar, switchgrass, and willow. Data are from 355 geographic sites in 31 countries around the world. We also documented the species, plantation practices, climate conditions, soil property, and managements. Our dataset can be used to identify productive bioenergy species over a large range of environments.",
           url = "https://doi.org/10.6084/m9.figshare.c.3951967",
           download_date = "2022-01-19",
           type = "static",
           licence = "CC BY 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Li_etal_2018_SciData_Data.xlsx"))


# manage ontology ---
#
matches <- tibble(new = unique(data$Crop_type),
                  old = c(""))
# getConcept(label_en = matches$old, missing = TRUE)

newConcept(new = c(),
           broader = c(), # the labels 'new' should be nested into
           class = , # try to keep that as conservative as possible and only come up with new classes, if really needed
           source = thisDataset)

getConcept(label_en = matches$old) %>%
  # ... %>% apply some additional filters (optional)
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = , # in most cases that should be "close", see ?newMapping
             source = thisDataset,
             certainty = )

# harmonise data ----
#
data1 <- data %>%
  separate(Planting_date, into = c("Startyear", "month")) %>%
  separate(Harvest_year, into = c("Endyear", "year_rest"))
data1 <- data %>%
  select(-Planting_date) %>%
  rename(year = Harvest_year)
data2 <- data %>%
  select(-Harvest_year) %>%
  rename(year = Planting_date)
data <- bind_rows(data1, data2)

temp <- data %>%
  mutate(
    fid = row_number(),
    x = Longitude,
    y = Latitude,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    country = Country,
    irrigated = if_else(!is.na(Irrigation), TRUE, FALSE),
    area = NA_real_,
    presence = TRUE,
    externalID = NA_character_,
    externalValue = Crop_type,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, year, month, day, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())

# before preparing data for storage, test that all required variables are available
assertNames(x = names(temp),
            must.include = c("datasetID", "fid", "country", "x", "y", "epsg",
                             "year", "month", "day", "irrigated",
                             "externalID", "externalValue", "LC1_orig", "LC2_orig", "LC3_orig",
                             "sample_type", "collector", "purpose"))


# write output ----
#
saveDataset(object = temp, dataset = thisDataset)
