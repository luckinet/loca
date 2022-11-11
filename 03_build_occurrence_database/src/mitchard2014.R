# script arguments ----
#
thisDataset <- "Mitchard2014"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1466823823.bib"))

regDataset(name = thisDataset,
           description = "Aim: The accurate mapping of forest carbon stocks is essential for understanding the global carbon cycle, for assessing emissions from deforestation, and for rational land-use planning. Remote sensing (RS) is currently the key tool for this purpose, but RS does not estimate vegetation biomass directly, and thus may miss significant spatial variations in forest structure. We test the stated accuracy of pantropical carbon maps using a large independent field dataset. Location: Tropical forests of the Amazon basin. The permanent archive of the field plot data can be accessed at: http://dx.doi.org/10.5521/FORESTPLOTS.NET/2014_1 Methods: Two recent pantropical RS maps of vegetation carbon are compared to a unique ground-plot dataset, involving tree measurements in 413 large inventory plots located in nine countries. The RS maps were compared directly to field plots, and kriging of the field data was used to allow area-based comparisons.Results: The two RS carbon maps fail to capture the main gradient in Amazon forest carbon detected using 413 ground plots, from the densely wooded tall forests of the north-east, to the light-wooded, shorter forests of the south-west. The differences between plots and RS maps far exceed the uncertainties given in these studies, with whole regions over- or under-estimated by > 25%, whereas regional uncertainties for the maps were reported to be < 5%. Main conclusions: Pantropical biomass maps are widely used by governments and by projects aiming to reduce deforestation using carbon offsets, but may have significant regional biases. Carbon-mapping techniques must be revised to account for the known ecological variation in tree wood density and allometry to create maps suitable for carbon accounting. The use of single relationships between tree canopy height and above-ground biomass inevitably yields large, spatially correlated errors. This presents a significant challenge to both the forest conservation and remote sensing communities, because neither wood density nor species assemblages can be reliably mapped from space.",
           url = "https://doi.org/10.1111/geb.12168",
           download_date = "2022-01-11",
           type = "static",
           licence = "CC BY 3.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Amazon_forest_biomass_Dataset_From_Mitchard_et_al_2014.xlsx"))

# harmonise data ----
#
data <- data %>%
  distinct(`First Census Mean Decimal Date`, `Last Census Mean Decimal Date`, .keep_all = TRUE)

data1 <- data %>%
  select(-`First Census Mean Decimal Date`) %>%
  mutate(Date = `Last Census Mean Decimal Date`)
data2 <- data %>%
  select(-`Last Census Mean Decimal Date`) %>%
  rename (Date = `First Census Mean Decimal Date`)
data <- bind_rows(data1, data2)
data <- data %>% separate(Date, into = c("year", "rest"))

temp <- data %>%
  mutate(
    fid = row_number(),
    x = `Longitude Decimal`,
    y = `Latitude Decimal`,
    year = as.numeric(year),
    month = NA_real_,
    day = NA_integer_,
    datasetID = thisDataset,
    country = Country,
    irrigated = F,
    presence = F,
    geometry = NA,
    area = `Plot Area (ha)` * 10000,
    type = "areal",
    externalID = as.character(PlotID),
    externalValue = "Undisturbed Forest",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")w
