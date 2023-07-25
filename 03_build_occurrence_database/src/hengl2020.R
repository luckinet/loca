# script arguments ----
#
thisDataset <- "Hengl2020"
description <- "Potential distribution of land cover classes (Potential Natural Vegetation) at 250 m spatial resolution based on a compilation of data sets (Biome6000k, Geo-Wiki, LandPKS, mangroves soil database, and from various literature sources; total of about 65,000 training points). We used a comparable thematic legend used to produce the Dynamic Land Cover 100m: Version 2. Copernicus Global Land Operations product (Buchhorn et al. 2019), which is based on the UN FAO Land Cover Classification System (LCCS), so that users can compare actual (https://lcviewer.vito.be/) vs potential (this data set) land cover. Two classes not available in the LCCS were added: subtropical/tropical mangrove vegetation and sub-polar or polar barren-lichen-moss, grassland. The map was created using relief and climate variables representing conditions the climate for the last 20+ years and predicted at 250 m globally using an Ensemble Machine Learning approach as implemented in the mlr package for R. Processing steps are described in detail here. Maps with _sd_ contain estimated model errors per class. Antarctica is not included."
url <- "https://doi.org/10.5281/zenodo.3631254 https://"
license <- "Attribution-ShareAlike 4.0 International"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "cit_Hengl2020.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2020-10-15"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- readRDS(file = paste0(thisPath, "lcv_nat.landcover.pnts_sites.rds"))


# pre-process data ----
#
data <- data %>% drop_na(map_code_pnv)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = longitude_decimal_degrees,
    y = latitude_decimal_degrees,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = dmy("01-01-2009"),
    externalID = as.character(point_id),
    externalValue = map_code_pnv,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
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

# newConcepts <- tibble(target = c("Forests", "Forests", "Forests",
#                                  "Herbaceous associations", "Shrubland", "Forests",
#                                  "Forests", "Forests", "Forests",
#                                  "Herbaceous associations", "Forests", "Forests",
#                                  "Forests", "open spaces", "moss",
#                                  "Shrubland", "Forests"),
#                       new = unique(data$map_code_pnv),
#                       class = "landcover",
#                       description = NA,
#                       match = "close",
#                       certainty = 3)

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
