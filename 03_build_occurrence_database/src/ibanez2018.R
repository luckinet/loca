# script arguments ----
#
thisDataset <- "Ibanez2018"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_13652745107.bib"))

regDataset(name = thisDataset,
           description = "Tropical cyclones (TCs) are large-scale disturbances that regularly impact tropical forests. Although long-term impacts of TCs on forest structure have been proposed, a global test of the relationship between forest structure and TC frequency and intensity is lacking. We test on a pantropical scale whether TCs shape the structure of tropical and subtropical forests in the long term We compiled forest structural features (stem density, basal area, mean canopy height and maximum tree size) for plants ≥10 cm in diameter at breast height from published forest inventory data (438 plots ≥0.1 ha, pooled into 250 1 × 1-degree grid cells) located in dry and humid forests. We computed maps of cyclone frequency and energy released by cyclones per unit area (power dissipation index, PDI) using a high-resolution historical database of TCs trajectories and intensities. We then tested the relationship between PDI and forest structural features using multivariate linear models, controlling for climate (mean annual temperature and water availability) and human disturbance (human foot print). Forests subject to frequent cyclones (at least one TCs per decade) and high PDI exhibited higher stem density and basal area, and lower canopy heights. However, the relationships between PDI and basal area or canopy height were partially masked by lower water availability and higher human foot print in tropical dry forests. Synthesis. Our results provide the first evidence that tropical cyclones have a long-term impact on the structure of tropical and subtropical forests in a globally consistent way. The strong relationship between power dissipation index and stem density suggests that frequent and intense tropical cyclones reduce canopy cover through defoliation and tree mortality, encouraging higher regeneration and turnover of biomass. The projected increase in intensity and poleward extension of tropical cyclones due to anthropogenic climate change may therefore have important and lasting impacts on the structure and dynamics of forests in the future.",
           url = "https://doi.org/10.1111/1365-2745.13039",
           download_date = "2022-01-22",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Appendix S1_corrected.csv"))


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)


# harmonise data ----
#
temp <- data %>%
  mutate(
    fid = row_number(),
    x = Long,
    y = Lat,
    year = NA_real_,
    month = NA_real_,
    day = NA_integer_,
    datasetID = thisDataset,
    country = Country,
    irrigated = F,
    externalID = NA_character_,
    externalValue = "Undisturbed Forest",
    presence = F,
    type = "point",
    area = NA_real_,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "meta study",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())

# In case we are dealing with areal data, build object that contains polygons
# temp_sf <- temp %>%
#   mutate(geom = ) %>% # select the geometry object
#   select(datasetID, fid, geom)


# write output ----
#
validateFormat(object = temp, type = "in-situ point") %>%
  saveDataset(dataset = thisDataset)

# validateFormat(object = temp_sf, type = "in-situ areal") %>%
#   write_sf(dsn = paste0(thisDataset, "_sf.gpkg"), delete_layer = TRUE)

message("\n---- done ----")
