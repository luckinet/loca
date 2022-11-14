# script arguments ----
#
thisDataset <- "Srdb"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "The Soil Respiration Database (SRDB) is a near-universal compendium of published soil respiration (Rs) data. The database encompasses published studies that report at least one of the following data measured in the field (not laboratory): annual soil respiration, mean seasonal soil respiration, a seasonal or annual partitioning of soil respiration into its source fluxes, soil respiration temperature response (Q10), or soil respiration at 10 degrees C. The SRDB's orientation is to seasonal and annual fluxes, not shorter-term or chamber-specific measurements, and the database is dominated by temperate, well-drained forest measurement locations. Version 5 (V5) is the compilation of 2,266 published studies with measurements taken between 1961-2017. V5 features more soil respiration data published in Russian and Chinese scientific literature for better global spatio-temporal coverage and improved global climate-space representation. The database is also restructured to have better interoperability with other datasets related to carbon-cycle science.

Soil respiration, the flux of autotrophically- and heterotrophically-generated CO2 from the soil to the atmosphere, remains the least well-constrained component of the terrestrial carbon cycle. Previous ancillary information fields were revised for consistency and simplicity and several new fields (e.g., measurement time, collar insertion depth, and collar area) were added. V5 provides opportunities for the biogeochemistry community to better understand the spatial and temporal variability of Rs, its components, and the overall carbon cycle.

There are 3 data files in comma-separated value (*.csv) format and 5 companion files included in this dataset."
url <- "https://doi.org/10.3334/ORNLDAAC/1827"
license <- ""

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "1578.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2020-12-15",
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "SRDB_V5_1827/data/srdb-data-V5.csv"))

# preprocess
#
prep <- data %>% drop_na(Ecosystem_type, Entry_date, Longitude, Latitude)

# manage ontology ---
#
newConcepts <- tibble(target = c("Forests", "Herbaceous associations", "AGRICULTURAL AREAS",
                                 "Shrubland", "WETLANDS", "Open spaces with little or no vegetation",
                                 "Forests", "Shrubland", "Urban fabric",
                                 "Open spaces with little or no vegetation", "Woody plantation", "Herbaceous associations",
                                 "Permanent grazing", "Shrub orchards", "Open spaces with little or no vegetation",
                                 "Urban fabric", "Herbaceous associations", "Inland wetlands",
                                 "Inland wetlands", "Grass crops", "Inland wetlands",
                                 NA, "Inland wetlands"),
                      new = unique(prep$Ecosystem_type),
                      class = c("landcover", "landcover", "landcover group",
                                "landcover", "landcover group", "landcover",
                                "landcover", "landcover", "landcover",
                                "landcover", "land-use", "landcover",
                                "land-use", "land-use", "landcover",
                                "landcover", "landcover", "landcover",
                                "landcover", "class", "landcover",
                                NA, "landcover"),
                      description = NA,
                      match = "close",
                      certainty = c(3, 3, 3,
                                    3, 3, 2,
                                    3, 3, 3,
                                    2, 2, 2,
                                    2, 2, 3,
                                    3, 3, 3,
                                    2, 3, 3,
                                    NA, 3))

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
temp <- prep %>%
  distinct(Latitude, Longitude, Ecosystem_type, Entry_date, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    x = Longitude,
    y = Latitude,
    date = ymd(Entry_date),
    type = "point",
    geometry = NA,
    area = NA_real_,
    country = Country,
    irrigated = NA_character_,
    externalID = NA_character_,
    presence = T,
    externalValue = Ecosystem_type,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "meta study",
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
