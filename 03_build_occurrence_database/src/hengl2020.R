# script arguments ----
#
thisDataset <- "Hengl2020"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "Potential distribution of land cover classes (Potential Natural Vegetation) at 250 m spatial resolution based on a compilation of data sets (Biome6000k, Geo-Wiki, LandPKS, mangroves soil database, and from various literature sources; total of about 65,000 training points). We used a comparable thematic legend used to produce the Dynamic Land Cover 100m: Version 2. Copernicus Global Land Operations product (Buchhorn et al. 2019), which is based on the UN FAO Land Cover Classification System (LCCS), so that users can compare actual (https://lcviewer.vito.be/) vs potential (this data set) land cover. Two classes not available in the LCCS were added: subtropical/tropical mangrove vegetation and sub-polar or polar barren-lichen-moss, grassland. The map was created using relief and climate variables representing conditions the climate for the last 20+ years and predicted at 250 m globally using an Ensemble Machine Learning approach as implemented in the mlr package for R. Processing steps are described in detail here. Maps with _sd_ contain estimated model errors per class. Antarctica is not included."
url <- "https://doi.org/10.5281/zenodo.3631254"
license <- "Attribution-ShareAlike 4.0 International"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "cit_Hengl2020.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2020-10-15",
           type = "static",
           licence = license,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           path = occurrenceDBDir)


# pre-process data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#

data <- readRDS(file = paste0(thisPath, "lcv_nat.landcover.pnts_sites.rds"))

# preprocess
#
data <- data %>% drop_na(map_code_pnv)

# manage ontology ---
#
newConcepts <- tibble(target = c("Forests", "Forests", "Forests",
                                 "Herbaceous associations", "Shrubland", "Forests",
                                 "Forests", "Forests", "Forests",
                                 "Herbaceous associations", "Forests", "Forests",
                                 "Forests", "open spaces", "moss",
                                 "Shrubland", "Forests"),
                      new = unique(data$map_code_pnv),
                      class = "landcover",
                      description = NA,
                      match = "close",
                      certainty = 3)

luckiOnto <- new_source(name = thisDataset,
                        description = description,
                        date = Sys.Date(),
                        homepage = url,
                        license = license,
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = newConcepts$new,
                         target = get_concept(x = newConcepts %>% select(label = target), ontology = luckiOnto),
                         source = thisDataset,
                         description = newConcepts$description,
                         match = newConcepts$match,
                         certainty = newConcepts$certainty,
                         ontology = luckiOnto, matchDir = paste0(occurrenceDBDir, "01_concepts/"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = longitude_decimal_degrees,
    y = latitude_decimal_degrees,
    geometry = NA,
    date = dmy("01-01-2009"),
    country = NA_character_,
    irrigated = NA,
    area = NA_real_,
    presence = T,
    externalID = as.character(point_id),
    externalValue = map_code_pnv,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "validation",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
