# script arguments ----
#
thisDataset <- "Szantoi2021"
description <- "Natural resources are increasingly being threatened in the world. Threats to biodiversity and human well-being pose enormous challenges to many vulnerable areas. Effective monitoring and protection of sites with strategic conservation importance require timely monitoring with special focus on certain land cover classes which are especially vulnerable. Larger ecological zones and wildlife corridors warrant monitoring as well, as these areas have an even higher degree of pressure and habitat loss as they are not “protected” compared to Protected Areas (i.e. National Parks). To address such a need, a satellite-imagery-based monitoring workflow to cover at-risk areas was developed. During the program's first phase, a total of 560 442 km2 area in sub-Saharan Africa was covered. In this update we remapped some of the areas with the latest satellite images available, and in addition we added some new areas to be mapped. Thus, in this version we updated and mapped an additional 852 025km2 in the Caribbean, African and Pacific regions with up to 32 land cover classes. Medium to high spatial resolution satellite imagery was used to generate dense time series data from which the thematic land cover maps were derived. Each map and change map were fully verified and validated by an independent team to achieve our strict data quality requirements. Further details regarding the sites selection, mapping and validation procedures are described in the corresponding publication: Szantoi, Zoltan; Brink, Andreas; Lupi, Andrea (2021): An update and beyond: key landscapes for conservation land cover and change monitoring, thematic and validation datasets for the African, Caribbean and Pacific region (in review, Earth System Science Data/)."
url <- "https://doi.pangaea.de/10.1594/PANGAEA.931968"
license <- "CC-BY-4.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "dataset931968.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-10-18"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
list_files <- list.files(path =  paste0(thisPath, "ALL_DATA_KLC_2/ValidationData/ValidationData/"), pattern = ".shp$", full.names = T)
data <- map(list_files, st_read) %>%
  bind_rows()


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
    country = NA_character_,
    x = NA_real_,
    y = NA_real_,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(paste0(str_extract(year, pattern = "(\\d)+"), "-01-01")),
    externalID = NA_character_,
    externalValue = as.character(LCC),
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "visual interpretation",
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

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
