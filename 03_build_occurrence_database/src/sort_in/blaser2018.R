# script arguments ----
#
thisDataset <- "Blaser2018"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_s41893-018-0062-8-citation.ris"))

regDataset(name = thisDataset,
           description = "Meeting demands for agricultural production while maintaining ecosystem services, mitigating and adapting to climate change and conserving biodiversity will be a defining challenge of this century. Crop production in agroforests is being widely implemented with the expectation that it can simultaneously meet each of these goals. But trade-offs are inherent to agroforestry and so unless implemented with levels of canopy cover that optimize these trade-offs, this effort in climate-smart, sustainable intensification may simply compromise both production and ecosystem services. By combining simultaneous measurements of production, soil fertility, disease, climate variables, carbon storage and species diversity along a shade-tree cover gradient, here we show that low-to-intermediate shade cocoa agroforests in West Africa do not compromise production, while creating benefits for climate adaptation, climate mitigation and biodiversity. As shade-tree cover increases above approximately 30%, agroforests become increasingly less likely to generate win–win scenarios. Our results demonstrate that agroforests cannot simultaneously maximize production, climate and sustainability goals but might optimise the trade-off between these goals at low-to-intermediate levels of cover.",
           url = "https://doi.org/10.1038/s41893-018-0062-8",
           download_date = "2020-11-02",
           type = "static",
           licence = "",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Blaser_etal_2018_NatureSustainability_GIS_Coordinates.xlsx"))


# harmonise data ----
#
temp <- data %>%
  .[-1] %>%
  na.omit() %>%
  filter(Latitude != "NA") %>%
  mutate(
    fid = row_number(),
    x = as.numeric(Longitude),
    y = as.numeric(Latitude),
    year = "2015_2016_2017",
    month = NA_real_,
    day = NA_integer_,
    datasetID = thisDataset,
    country = "Ghana",
    irrigated = FALSE,
    externalID = paste0(Site,"_", Type),
    externalValue = "cocoa beans",
    geometry = NA,
    presence = FALSE,
    type = "areal",
    area = 900,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = as.numeric(year)) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
