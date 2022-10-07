# script arguments ----
#
thisDataset <- "Wenden2016"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_sdata.2016.108-citation.ris")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "Professional and scientific networks built around the production of sweet cherry (Prunus avium L.) led to the collection of phenology data for a wide range of cultivars grown in experimental sites characterized by highly contrasted climatic conditions. We present a dataset of flowering and maturity dates, recorded each year for one tree when available, or the average of several trees for each cultivar, over a period of 37 years (1978–2015). Such a dataset is extremely valuable for characterizing the phenological response to climate change, and the plasticity of the different cultivars’ behaviour under different environmental conditions. In addition, this dataset will support the development of predictive models for sweet cherry phenology exploitable at the continental scale, and will help anticipate breeding strategies in order to maintain and improve sweet cherry production in Europe.",
           url = "https://doi.org/10.1038/sdata.2016.108",
           type = "static",
           licence = "",
           bibliography = bib,
           download_date = "2021-12-17",
           contact = "see corresponding author",
           disclosed = "yes",
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Sweet_cherry_phenology_data_1978-2015.xlsx"))


# manage ontology ---
#


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = as.numeric(Longitude),
    y = as.numeric(Latitude),
    geometry = NA,
    year = as.numeric(Year),
    month = NA_real_,
    day = NA_integer_,
    country = Country,
    irrigated = FALSE,
    area = NA_real_,
    presence = TRUE,
    externalID = NA_character_,
    externalValue = "cherry",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
