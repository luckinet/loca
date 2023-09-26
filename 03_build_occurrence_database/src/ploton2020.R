# script arguments ----
#
thisDataset <- "Ploton2020"
description <- "Forest biomass is key in Earth carbon cycle and climate system, and thus under intense scrutiny in the context of international climate change mitigation initiatives (e.g. REDD+). In tropical forests, the spatial distribution of aboveground biomass (AGB) remains, however, highly uncertain. There is increasing recognition that progress is strongly limited by the lack of field observations over large and remote areas. Here, we introduce the Congo basin Forests AGB (CoFor-AGB) dataset that contains AGB estimations and associated uncertainty for 59,857 1-km pixels aggregated from nearly 100,000ha of in situ forest management inventories for the 2000 – early 2010s period in five central African countries. A comprehensive error propagation scheme suggests that the uncertainty on AGB estimations derived from c. 0.5-ha inventory plots (8.6–15.0%) is only moderately higher than the error obtained from scientific sampling plots (8.3%). CoFor-AGB provides the first large scale view of forest AGB spatial variation from field data in central Africa, the second largest continuous tropical forest domain of the world."
url <- "https://doi.org/10.1038/s41597-020-0561-0"
license <- "CC BY 4.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "10.1038_s41597-020-0561-0-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-08"),
           type = "static",
           licence = licence,
           contact = "p.ploton@gmail.com",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "COFOR_plot_v-01-2020.xlsx"), sheet = 2)


# harmonise data ----
#
temp <- data %>%
  distinct(lon, lat, .keep_all = T) %>%
  st_as_sf(., coords = c("lon", "lat"), crs = 3395) %>%
  st_transform(., crs = 4326) %>%
  mutate(x = st_coordinates(.)[,1],
         y = st_coordinates(.)[,2]) %>%
  as_tibble() %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = Country,
    x = x,
    y = y,
    geometry = NA,
    epsg = 4326,
    area = plot_area,
    date = ymd(paste0("2006-01-01")),
    externalID = NA_character_,
    externalValue = "Naturally Regenerating Forest",
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = FALSE,
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
