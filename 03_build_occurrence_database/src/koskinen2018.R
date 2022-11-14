# script arguments ----
#
thisDataset <- "Koskinen2018"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "Validation data set collected by the author team in the field, November 2016"
url <- "https://doi.pangaea.de/10.1594/PANGAEA.894891, https://doi.org/10.1016/j.isprsjprs.2018.12.011"
license <- "CC-BY-4.0"

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Tanzania_Southern_Highlands_validation_dataset_field.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2022-01-22",
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_tsv(paste0(thisPath, "Tanzania_Southern_Highlands_validation_dataset_field.tab"), skip = 18)


# manage ontology ---
#
onto <- read_csv(paste0(thisPath, "ontology_koskinen2018.csv"))
newConcepts <- tibble(target = onto$target,
                      new = onto$new,
                      class = onto$class,
                      description = NA,
                      match = "close",
                      certainty = onto$certainty)

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
    fid = row_number(),
    x = Longitude,
    y = Latitude,
    date = ymd("2016-11-01"),
    datasetID = thisDataset,
    country = "Tanzania",
    irrigated = NA_character_,
    externalID = as.character(ID),
    externalValue = `Land use (Level 3)`,
    geometry = NA,
    type = "point",
    area = NA_real_,
    presence = T,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
