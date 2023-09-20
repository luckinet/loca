# script arguments ----
#
thisDataset <- "Kebede2019"
description <- "Lepidopteran stemborers are a serious pest of maize in Africa. While farmers have adopted cultural control practices at the field scale, it is not clear how these practices affect stemborer infestation levels and how their efficacy is influenced by landscape context. The aim of this 3-year study was to assess the effect of field and landscape factors on maize stemborer infestation levels and maize productivity. Maize infestation levels, yield and biomass production were assessed in 33 farmer fields managed according to local practices. When considering field level factors only, plant density was positively related to stemborer infestation level. During high infestation events, length of tunnelling was positively associated with planting date and negatively with the botanical diversity of hedges. However, the proportion of maize crop in the surrounding landscape was strongly and positively associated with length of tunnelling at 100, 500, 1000 and 1500m radius, and overrode field level management factors when considered together. Maize grain yield was positively associated with plant density and soil phosphorus content, and not negatively associated with the length of tunnelling. Our findings highlight the need to consider a landscape approach for stemborer pest management, but also indicate that maize is tolerant to low and medium infestation levels of stemborers. "
url <- "https://doi.org/10.7910/DVN/C9Z4I4 https://" # doi, in case this exists and download url separated by empty space
license <- "CC0 1.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "doi 10.7910_DVN_C9Z4I4.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("29-07-2020"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(path = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Kebede et al. 2019a.xlsx"), sheet = 3)


# harmonise data ----
#
temp <- data %>%
  mutate(externalValue = case_when(CroppingSystem == "MaizeSol" ~ "maize",
                                   CroppingSystem == "BeanIntercrop" ~ "maize_bean")) %>%
  separate_rows(externalValue, sep = "_") %>%
  st_as_sf(., coords = c("Lon", "Lat"), crs = 32637) %>%
  st_transform(., crs = 4326) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Ethiopia",
    x = st_coordinates(.)[,1],
    y = st_coordinates(.)[,2],
    geometry = geometry,
    epsg = 4326,
    area = PlotArea * 10000,
    date = as.Date(paste(Year, data$PlantingDate, 1, sep="-"), "%Y-%U-%u"),
    externalID = as.character(PlotID),
    externalValue = externalValue,
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

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
