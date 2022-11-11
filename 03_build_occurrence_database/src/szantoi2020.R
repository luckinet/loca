# script arguments ----
#
thisDataset <- "Szantoi2020"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "Threats to biodiversity pose an enormous challenge for Africa. Mounting social and economic demands on natural resources increasingly threaten key areas for conservation. Effective protection of sites of strategic conservation importance requires timely and highly detailed geospatial monitoring. Larger ecological zones and wildlife corridors warrant monitoring as well, as these areas have an even higher degree of pressure and habitat loss. To address this, a satellite imagery based15 monitoring workflow to cover at-risk areas at various details was developed. During the program’s first phase, a total of 560,442km2 area in Sub-Saharan Africa was covered, from which 153,665km2 were mapped with 8 land cover classes while 406,776km2 were mapped with up to 32 classes. Satellite imagery was used to generate dense time series data from which thematic land cover maps were derived. Each map and change map were fully verified and validated by an independent team to achieve our strict data quality requirements. The independent validation datasets for each KLCs are also described and 20 presented here (The complete dataset available at Szantoi et al., 2020A https://doi.pangaea.de/10.1594/PANGAEA.914261, and a demonstration dataset at Szantoi et al., 2020B https://doi.pangaea.de/10.1594/PANGAEA.915849)."
url <- "https://doi.pangaea.de/10.1594/PANGAEA.914261, https://doi.org/10.5194/essd-2020-77"
license <- "CC BY 4.0"

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "dataset914261.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2021-09-14",
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#

file_list <- list.files(path = paste0(thisPath, "ALL_DATA/validationData_Sub-Sahara_Africa/"), pattern = ".shp$", full.names = T)

data <-  do.call(bind_rows, map(.x =file_list, .f = st_read))

LC_Class <- read_csv2(paste0(thisPath, "LC_class.csv"))

# manage ontology ---
#
newConcepts <- tibble(target = LC_Class$new,
                      new = unique(LC_Class$LandCover),
                      class = LC_Class$class,
                      description = NA,
                      match = "close",
                      certainty = LC_Class$certainty)

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
j2000 <- data %>%
  select(y, x, Mapcode = plaus2000) %>% mutate(year = 2000)

j2015 <- data %>%
  select(y, x, Mapcode = plaus2015) %>% mutate(year = 2015)

j2016 <- data %>%
  select(y, x, Mapcode = plaus2016) %>% mutate(year = 2016)

j2017 <- data %>%
  select(y, x, Mapcode = plaus2017) %>% mutate(year = 2017)

temp <- bind_rows(j2000, j2015, j2016, j2017) %>% left_join(., LC_Class, by = "Mapcode")

temp <- temp %>%
  drop_na(LandCover) %>%
  st_transform(., crs = "EPSG:4326") %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    x = x,
    y = y ,
    type = "point",
    geometry = geometry,
    area = NA_real_,
    presence = T,
    date = ymd(paste0(year, "-01-01")),
    country = NA_character_,
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = LandCover,
    LC1_orig = LandCover,
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
