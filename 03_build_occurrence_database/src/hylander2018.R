# script arguments ----
#
thisDataset <- "Hylander2018"
description <- "Aim: Local extinction after habitat modifications is often delayed, leading to an extinction debt. Our first aim was to develop a conceptual model for natural and human-mediated habitat improvements after a disturbance that may waive part of the predicted extinction debt. Second, we wanted to test this model on the distribution of epiphytic plants on trees that had been isolated in the agricultural matrix after forest clearing, around which coffee subsequently had been planted with a possible improvement of the microclimate. Location: Bonga, Southern Nations, Nationalities and Peoples Region (SNNPR), Ethiopia. Methods: We studied 50 trees that had been isolated for periods ranging from a few years to half a century after clearing. The trees were now located in the agricultural landscape at different distances from intact Afromontane forests. Fourteen trees in the forests were used as references. Each tree was inventoried for all vascular epiphytic plants, mosses and liverworts. Results: Time since clearance had a direct negative effect on number of forest specialist species via delayed extinctions and the detected large extinction debt of both bryophytes and vascular plants continued to be paid over several decades. However, time since clearance had an indirect positive effect on number of forest indicator species via the reappearance of shade from coffee planted surrounding the trees, even if the waiving effect on the extinction debt was rather small. Additionally, trees at further distances from the forest edge had fewer forest-associated species. Main conclusions: Our results show that the ability of agroecological landscapes to foster forest biodiversity may be overestimated if meta-community processes over time and space are not taken into account. However, the possibility of initiating counteracting processes that modify the level of expected local extinctions should be evaluated more often to find ways of improving conditions for biodiversity in human-modified landscapes. "
url <- "https://doi.org/10.5061/dryad.8vr04 https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "pericles_1472464223.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-06-01"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_excel(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Data_Hylander_Nemomissa_Diversity_Distributions.xlsx"))


# pre-process data ----
#
data[1,3] <- "29-Oct-08"

temp <- st_as_sf(data, coords = c("EW_coord", "NS_coord"), crs = "EPSG:32637") %>%
  st_transform(., crs = "EPSG:4326") %>%
  mutate(lon = st_coordinates(.)[,1],
         lat = st_coordinates(.)[,2]) %>%
  as.data.frame()


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Ethiopia",
    x = lon,
    y = lat,
    geometry = NA,
    epsg = 4326,
    area = 100,
    date = NA,
    # year = year(dmy(Date)),
    # month = month(dmy(Date)),
    # day = day(dmy(Date)),
    externalID = Together,
    externalValue = `coffee 1 species`,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
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

# matches <- tibble(new = c(unique(data$`coffee 1 species`)),
#                   old = c("coffee", "Naturally Regenerating Forest", "Naturally Regenerating Forest",
#                           "coffee", NA, "Naturally Regenerating Forest",
#                           "Naturally Regenerating Forest", "Naturally Regenerating Forest", "Naturally Regenerating Forest"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
