# script arguments ----
#
thisDataset <- "Szantoi2021AfriCariPaci"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "Natural resources are increasingly being threatened in the world. Threats to biodiversity and human well-being pose enormous challenges to many vulnerable areas. Effective monitoring and protection of sites with strategic conservation importance require timely monitoring with special focus on certain land cover classes which are especially vulnerable. Larger ecological zones and wildlife corridors warrant monitoring as well, as these areas have an even higher degree of pressure and habitat loss as they are not “protected” compared to Protected Areas (i.e. National Parks). To address such a need, a satellite-imagery-based monitoring workflow to cover at-risk areas was developed. During the program’s first phase, a total of 560 442 km2 area in sub-Saharan Africa was covered. In this update we remapped some of the areas with the latest satellite images available, and in addition we added some new areas to be mapped. Thus, in this version we updated and mapped an additional 852 025km2 in the Caribbean, African and Pacific regions with up to 32 land cover classes. Medium to high spatial resolution satellite imagery was used to generate dense time series data from which the thematic land cover maps were derived. Each map and change map were fully verified and validated by an independent team to achieve our strict data quality requirements. Further details regarding the sites selection, mapping and validation procedures are described in the corresponding publication: Szantoi, Zoltan; Brink, Andreas; Lupi, Andrea (2021): An update and beyond: key landscapes for conservation land cover and change monitoring, thematic and validation datasets for the African, Caribbean and Pacific region (in review, Earth System Science Data/).

Data format: vector (shapefile, polygon - LC/LCC dataset), vector (shapefile, point - validation dataset),
Geographic Coordinate System (LC/LCC dataset): World Geodetic System 1984 (EPSG:4326) and its datum (EPSG:6326),
Minimum mapping unit: 3ha for land cover and 0.5ha for land cover change
Land cover/change dataset attributes:
[map_codeA] - dichotomous level,
[map_code} - modular level,
[class_name] - corresponding modular class name.
Validation dataset attributes (not all are present):
[plaus200X] - corresponding class for the change map (i.e. 2000), modular level
[plaus200Xr] - corresponding class for the change map (i.e. 2000), aggregated classes
[plaus20XX] - corresponding class for the land cover map (i.e. 2015), modular level
[plaus20XXr] - corresponding class for the land cover map (i.e. 2015), aggregated classes
The naming of all attributes follow the same structure in all shapefiles - see Table 2 Dichotomous and Modular thematic land cover/use classes and in the 3.5 Validation dataset production section in the corresponding publication."
url <- "https://doi.org/10.5281/zenodo.4621374"
license <- "Attribution 4.0 International"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "cita.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "", # YYYY-MM-DD
           type = "", # dynamic or static
           licence = license,
           contact = "", # optional, if it's a paper that should be "see corresponding author"
           disclosed = "", # whether the data are freely available "yes"/"no"
           bibliography = bib,
           update = TRUE)



# read dataset ----
#
file_list <- list.files(path = paste0(thisPath, "key_landscapes_for_conservation_phase2/ValidationData"), pattern = ".shp$", full.names = T)

data <-  do.call(bind_rows, map(.x =file_list, .f = st_read))

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

# in case new harmonised concepts appear here (avoid if possible)
# luckiOnto <- new_concept(new = , broader = , class = , description = ,
#                          ontology = luckiOnto)

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
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = st_coordinates(.)[,1],
    y = st_coordinates(.)[,2],
    geometry = geometry,
    date = ymd(paste0(str_extract(year, pattern = "(\\d)+"), "-01-01")),
    country = NA_character_,
    irrigated = NA,
    area = NA_real_,
    presence = T,
    externalID = NA_character_,
    externalValue = LCC,
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
