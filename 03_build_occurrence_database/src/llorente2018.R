# script arguments ----
#
thisDataset <- "Llorente2018"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "citation-321419495.ris"))

regDataset(name = thisDataset,
           description = "CARBOSOL is a collaborative network of 8 research teams from Spanish Universities and Research Centres focused on the study of soil organic matter and the Global Carbon Cycle. Our aim is to perform an accurate quantitation of Soil Organic Carbon (SOC) stocks in Spain for different land uses, soil types and depths, and assess the environmental drivers of C storage. Furthermore, the compilation and processing of large-scale data sets is crucial for the modelling of C stocks. Over time, researchers in Spain have generated vast information about soil profiles. However, SOC data often cover limited areas and there are few available studies covering all climatic areas and land uses. Besides, this information is scattered, not easily available and presented in many different formats. The organization of Spanish soil profiles information in a wide, unique and harmonized database is an essential tool for improving our knowledge on Spanish soil properties and dynamics. It is important to point out that the Iberian Peninsula presents a characteristic spatial and temporal variability based upon a diverse geography and a variety of climates. Heterogeneous landscapes offer a natural playground to understand factors affecting SOC, while assessing overall country stocks (Doblas-Miranda et al. 2013). Under the different Mediterranean forest types climate and vegetation control SOC sequestration, while the effect of texture is less pronounced (Chiti et al. 2012). In collaboration with soil experts, CARBOSOL has compiled soil profile data from 635 sources (published and unpublished studies). Detailed information from 6,610 geo-refereed profiles linked to 22,105 analytical horizons is now available. It represents largest harmonized soil information collection in Spain.",
           url = "https://doi.org/10.1594/PANGAEA.884515",
           download_date = "2021-10-18",
           type = "static",
           licence = "CC-BY-3.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#
data <- read_tsv(file = paste0(thisPath, "CARBOSOL_profile.tab"), skip = 34)


# manage ontology ---
#
matches <- tibble(new = c(unique(data$LCC)),
                  old = c("Forests", "Forests", "Forests", "Forests",
                          "Herbaceous associations", "Permanent grazing", NA,
                          "Permanent cropland", "Permanent cropland",
                          "Open spaces with little or no vegetation",
                          "WETLANDS",
                          "Permanent cropland"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    date = ymd(paste0(Date, "-01-01")),
    country = "Spain",
    irrigated = case_when(LCC == "Irrigated land" ~ TRUE,
                          LCC != "Irrigated land" ~ FALSE),
    area = NA_real_,
    presence = T,
    externalID = as.character(`Sample ID (Unique identification number ...)`),
    externalValue = LCC,
    LC1_orig = LCC,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study" ,
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
