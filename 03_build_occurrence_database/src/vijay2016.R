# script arguments ----
#
thisDataset <- "Vijay2016"
description <- "Palm oil is the most widely traded vegetable oil globally, with demand projected to increase substantially in the future. Almost all oil palm grows in areas that were once tropical moist forests, some of them quite recently. The conversion to date, and future expansion, threatens biodiversity and increases greenhouse gas emissions. Today, consumer pressure is pushing companies toward deforestation-free sources of palm oil. To guide interventions aimed at reducing tropical deforestation due to oil palm, we analysed recent expansions and modelled likely future ones. We assessed sample areas to find where oil palm plantations have recently replaced forests in 20 countries, using a combination of high-resolution imagery from Google Earth and Landsat. We then compared these trends to countrywide trends in FAO data for oil palm planted area. Finally, we assessed which forests have high agricultural suitability for future oil palm development, which we refer to as vulnerable forests, and identified critical areas for biodiversity that oil palm expansion threatens. Our analysis reveals regional trends in deforestation associated with oil palm agriculture. In Southeast Asia, 45% of sampled oil palm plantations came from areas that were forests in 1989. For South America, the percentage was 31%. By contrast, in Mesoamerica and Africa, we observed only 2% and 7% of oil palm plantations coming from areas that were forest in 1989. The largest areas of vulnerable forest are in Africa and South America. Vulnerable forests in all four regions of production contain globally high concentrations of mammal and bird species at risk of extinction. However, priority areas for biodiversity conservation differ based on taxa and criteria used. Government regulation and voluntary market interventions can help incentivize the expansion of oil palm plantations in ways that protect biodiversity-rich ecosystems."
url <- "https://doi.org/10.5061/dryad.2v77j https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1371_journal.pone.0159668.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-06-07"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- st_read(dsn = paste0(thisPath, "/Vijay_et_al_2016_oilpalm_GISdata"))


# pre-process data ----
#
temp1 <- data %>%
  st_transform(., crs = "EPSG:4326") %>%
  st_make_valid() %>%
  st_cast(., "POLYGON") %>%
  dplyr::mutate(FID = row_number()) %>%
  as.data.frame()

data <- temp1 %>%
  mutate(area = st_area(.)) %>%
  st_centroid() %>%
  dplyr::mutate(FID = row_number(),
                x = st_coordinates(.)[,1],
                y = st_coordinates(.)[,2]) %>%
  as.data.frame() %>%
  left_join(.,temp1, by = "FID")


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = NA_character_,
    x = x,
    y = y,
    geometry = geometry.y,
    epsg = 4326,
    area = as.numeric(area),
    date = NA,
    # year = 2013,
    # month = NA_real_,
    # day = NA_integer_,
    externalID = NA_character_,
    externalValue = "Palm plantations",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "visual interpretation",
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

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
