# script arguments ----
#
thisDataset <- "caci"
description <- "Beginning with the 2011 grow season, the Earth Observation Team of the Science and Technology Branch (STB) at Agriculture and Agri-Food Canada (AAFC) started collecting ground truth data via windshield surveys. This observation data is collected in support of the generation of an annual crop inventory digital map. These windshield surveys take place in provinces where AAFC does not have access to crop insurance data. The collection routes driven attempt to maximize not only the geographical distribution of observations but also to target unique or specialty crop types within a given region. Windshield surveys are mainly collected by the AAFC Earth Observation team (Ottawa) with the support of regional AAFC Research Centres (St John’s NL; Kentville NS; Charlottetown PE; Moncton NB; Guelph ON; Summerland BC). Support is also provided by provincial agencies in British Columbia, Ontario, and Prince Edward Island, and by contractors when needed."
url <- "https://doi.org/ https://open.canada.ca/data/en/dataset/503a3113-e435-49f4-850c-d70056788632"
licence <- "Open Government Licence - Canada"


# reference ----
#
bib <- bibentry(bibtype = "Misc",
                title = "Annual Crop Inventory Ground Truth Data",
                publisher = "Agriculture and Agri-Food Canada",
                year = 2020)

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-05-16"),
           type = "dynamic",
           licence = licence,
           contact = "agri-geomatics-agrog@agr.gc.ca",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
dataNames <- list.dirs(path = thisPath)[-1]
data <- lapply(dataNames, st_read)
data <- bind_rows(data)


# harmonise data ----
#
temp <- data %>%
  mutate(x = st_coordinates(.)[,1],
         y = st_coordinates(.)[,2]) %>%
  as.data.frame() %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Canda",
    x = NA_real_,
    y = NA_real_,
    geometry = geometry,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = year(DATE_COLL),
    # month = month(DATE_COLL),
    # day = day(DATE_COLL),
    externalID = NA_character_,
    externalValue = NOMTERRE,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "validation") %>%
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

# matches <- read_csv(paste0(thisPath, "caci_onotology.csv"))
# newConcept(new = c("beetroot", "celery",
#                    "goji berry", "haskap",
#                    "flax", "elderberry"),
#            broader = c("Root or Bulb vegetables", "Leafy or stem vegetables",
#                        "Berries", "Berries",
#                        "Fibre crops", "Berries"),
#            class = "commodity",
#            source = thisDataset)
#
# getConcept(label_en = matches$old) %>%
#   pull(label_en) %>%
#   newMapping(concept = .,
#              external = matches$new,
#              match = "close",
#              source = thisDataset,
#              certainty = 3)

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
