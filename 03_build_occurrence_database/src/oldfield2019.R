# script arguments ----
#
thisDataset <- "Oldfield2019"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "soil-5-15-2019.bib"))

regDataset(name = thisDataset,
           description = "Resilient, productive soils are necessary to sustainably intensify agriculture to increase yields while minimizing environmental harm. To conserve and regenerate productive soils, the need to maintain and build soil organic matter (SOM) has received considerable attention. Although SOM is considered key to soil health, its relationship with yield is contested because of local-scale differences in soils, climate, and farming systems. There is a need to quantify this relationship to set a general framework for how soil management could potentially contribute to the goals of sustainable intensification. We developed a quantitative model exploring how SOM relates to crop yield potential of maize and wheat in light of co-varying factors of management, soil type, and climate. We found that yields of these two crops are on average greater with higher concentrations of SOC (soil organic carbon). However, yield increases level off at ∼20% SOC. Nevertheless, approximately two-thirds of the world's cultivated maize and wheat lands currently have SOC contents of less than 20%. Using this regression relationship developed from published empirical data, we then estimated how an increase in SOC concentrations up to regionally specific targets could potentially help reduce reliance on nitrogen (N) fertilizer and help close global yield gaps. Potential N fertilizer reductions associated with increasing SOC amount to 70% and 5% of global N fertilizer inputs across maize and wheat fields, respectively. Potential yield increases of 10±11% (mean±SD) for maize and 23±37% for wheat amount to 32% of the projected yield gap for maize and 60% of that for wheat. Our analysis provides a global-level prediction for relating SOC to crop yields. Further work employing similar approaches to regional and local data, coupled with experimental work to disentangle causative effects of SOC on yield and vice versa, is needed to provide practical prescriptions to incentivize soil management for sustainable intensification.",
           url = "https://doi.org/10.5194/soil-5-15-2019",
           download_date = "2022-01-13",
           type = "static",
           licence = "CC BY 4.0",
           contact = "emily.oldfield@yale.edu",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "resource_map_doi_10_5063_F19W0CQ5/data/Oldfield_et_al_Database.xlsx"))


# harmonise data ----
#
temp <- data %>%
  distinct(longitude, latitude, crop, `year of study`, .keep_all = TRUE) %>%
  mutate(
    fid = row_number(),
    x = longitude,
    y = latitude,
    year = `year of study`,
    month = NA_real_,
    day = NA_integer_,
    datasetID = thisDataset,
    irrigated = case_when(irigation == 1 ~ TRUE,
                           irigation == 0 ~ FALSE,
                          TRUE~ FALSE),
    externalID = NA_character_,
    externalValue = crop,
    presence = T,
    type = "point",
    area = NA_real_,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
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
