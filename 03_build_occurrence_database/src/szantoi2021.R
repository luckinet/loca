# script arguments ----
#
thisDataset <- ""
description <- ""
url <- "https://doi.org/ https://"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "")) # or bibtex_reader()

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd(),
           type = NA_character_,
           licence = licence,
           contact = NA_character_,
           disclosed = NA,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", ""))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = NA_character_,
    country = NA_character_,
    x = NA_real_,
    y = NA_real_,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = NA_character_,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = NA,
    sample_type = NA_character_,
    collector = NA_character_,
    purpose = NA_character_) %>%
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




# script arguments ----
#
thisDataset <- "Szantoi2021"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


description <- "Natural resources are increasingly being threatened in the world. Threats to biodiversity and human well-being pose enormous challenges to many vulnerable areas. Effective monitoring and protection of sites with strategic conservation importance require timely monitoring with special focus on certain land cover classes which are especially vulnerable. Larger ecological zones and wildlife corridors warrant monitoring as well, as these areas have an even higher degree of pressure and habitat loss as they are not “protected” compared to Protected Areas (i.e. National Parks). To address such a need, a satellite-imagery-based monitoring workflow to cover at-risk areas was developed. During the program's first phase, a total of 560 442 km2 area in sub-Saharan Africa was covered. In this update we remapped some of the areas with the latest satellite images available, and in addition we added some new areas to be mapped. Thus, in this version we updated and mapped an additional 852 025km2 in the Caribbean, African and Pacific regions with up to 32 land cover classes. Medium to high spatial resolution satellite imagery was used to generate dense time series data from which the thematic land cover maps were derived. Each map and change map were fully verified and validated by an independent team to achieve our strict data quality requirements. Further details regarding the sites selection, mapping and validation procedures are described in the corresponding publication: Szantoi, Zoltan; Brink, Andreas; Lupi, Andrea (2021): An update and beyond: key landscapes for conservation land cover and change monitoring, thematic and validation datasets for the African, Caribbean and Pacific region (in review, Earth System Science Data/)."
url <- "https://doi.pangaea.de/10.1594/PANGAEA.931968"
license <- "CC-BY-4.0"

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "dataset931968.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2022-10-18",
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#

list_files <- list.files(path =  paste0(thisPath, "ALL_DATA_KLC_2/ValidationData/ValidationData/"), pattern = ".shp$", full.names = T)
data <- map(list_files, st_read) %>%
  bind_rows()


# manage ontology ---
#
newConcepts <- tibble(target = ,
                      new = ,
                      class = ,
                      description = ,
                      match = ,
                      certainty = )

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
  st_make_valid() %>%
  st_transform(., crs = "EPSG:4326") %>%
  pivot_longer(c("plaus2015r", "plaus2020r", "plaus2000", "plaus2000r", "plaus2015", "plaus2020",  "plaus2005",  "plaus2010",  "plaus2005r", "plaus2010r", "plaus2016",  "plaus2016r"), names_to = "year", values_to = "LCC") %>%
 mutate(across(starts_with('LCC'), ~replace(., . %in% c(0, 91, 140, 96, 95, 123, 124, 92, 139), NA))) %>%
  mutate(x = st_coordinates(.)[,1],
         y = st_coordinates(.)[,2]) %>%
  drop_na(LCC) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    geometry = NA,
    date = ymd(paste0(str_extract(year, pattern = "(\\d)+"), "-01-01")),
    country = NA_character_,
    irrigated = F,
    area = NA_real_,
    presence = T,
    externalID = NA_character_,
    externalValue = as.character(LCC),
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "visual interpretation",
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
