# script arguments ----
#
thisDataset <- "Vijay2016"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1371_journal.pone.0159668.ris"))

regDataset(name = thisDataset,
           description = "Palm oil is the most widely traded vegetable oil globally, with demand projected to increase substantially in the future. Almost all oil palm grows in areas that were once tropical moist forests, some of them quite recently. The conversion to date, and future expansion, threatens biodiversity and increases greenhouse gas emissions. Today, consumer pressure is pushing companies toward deforestation-free sources of palm oil. To guide interventions aimed at reducing tropical deforestation due to oil palm, we analysed recent expansions and modelled likely future ones. We assessed sample areas to find where oil palm plantations have recently replaced forests in 20 countries, using a combination of high-resolution imagery from Google Earth and Landsat. We then compared these trends to countrywide trends in FAO data for oil palm planted area. Finally, we assessed which forests have high agricultural suitability for future oil palm development, which we refer to as vulnerable forests, and identified critical areas for biodiversity that oil palm expansion threatens. Our analysis reveals regional trends in deforestation associated with oil palm agriculture. In Southeast Asia, 45% of sampled oil palm plantations came from areas that were forests in 1989. For South America, the percentage was 31%. By contrast, in Mesoamerica and Africa, we observed only 2% and 7% of oil palm plantations coming from areas that were forest in 1989. The largest areas of vulnerable forest are in Africa and South America. Vulnerable forests in all four regions of production contain globally high concentrations of mammal and bird species at risk of extinction. However, priority areas for biodiversity conservation differ based on taxa and criteria used. Government regulation and voluntary market interventions can help incentivize the expansion of oil palm plantations in ways that protect biodiversity-rich ecosystems.",
           url = "https://doi.org/10.5061/dryad.2v77j",
           download_date = "2022-06-07",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yees",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#

data <- st_read(dsn = paste0(thisPath, "/Vijay_et_al_2016_oilpalm_GISdata"))


# harmonise data ----
#

# transform and split MULTIPOLYGON
temp1 <- data %>%
  st_transform(., crs = "EPSG:4326") %>%
  st_make_valid() %>%
  st_cast(., "POLYGON") %>%
  dplyr::mutate(FID = row_number()) %>%
  as.data.frame()

# calculate area, extract coordinates and left_join for POLY geometry
temp <- temp1 %>%
  mutate(area = st_area(.)) %>%
  st_centroid() %>%
  dplyr::mutate(FID = row_number(),
                x = st_coordinates(.)[,1],
                y = st_coordinates(.)[,2]) %>%
  as.data.frame() %>%
  left_join(.,temp1, by = "FID")


temp <- temp %>%
  dplyr::mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = x,
    y = y,
    geometry = geometry.y,
    year = 2013,
    month = NA_real_,
    day = NA_integer_,
    country = NA_character_,
    irrigated = F,
    area = as.numeric(area),
    presence = F,
    externalID = NA_character_,
    externalValue = "Palm plantations",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "visual interpretation",
    collector = "expert",
    purpose = "study" ,
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
