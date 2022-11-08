# script arguments ----
#
thisDataset <- "BioTime"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1466823827.bib"))

regDataset(name = thisDataset,
           description = "Abstract Motivation The BioTIME database contains raw data on species identities and abundances in ecological assemblages through time. These data enable users to calculate temporal trends in biodiversity within and amongst assemblages using a broad range of metrics. BioTIME is being developed as a community-led open-source database of biodiversity time series. Our goal is to accelerate and facilitate quantitative analysis of temporal patterns of biodiversity in the Anthropocene. Main types of variables included The database contains 8,777,413 species abundance records, from assemblages consistently sampled for a minimum of 2 years, which need not necessarily be consecutive. In addition, the database contains metadata relating to sampling methodology and contextual information about each record. Spatial location and grain BioTIME is a global database of 547,161 unique sampling locations spanning the marine, freshwater and terrestrial realms. Grain size varies across datasets from 0.0000000158 km2 (158 cm2) to 100 km2 (1,000,000,000,000 cm2). Time period and grain BioTIME records span from 1874 to 2016. The minimal temporal grain across all datasets in BioTIME is a year. Major taxa and level of measurement BioTIME includes data from 44,440 species across the plant and animal kingdoms, ranging from plants, plankton and terrestrial invertebrates to small and large vertebrates. Software format .csv and .SQL.",
           url = "https://doi.org/10.1111/geb.12729",
           download_date = "2019-09-10",
           type = "dynamic",
           licence = "various",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#
data <- read_csv(paste0(thisPath, "BioTIMEQuery02_04_2018.csv"))
data2 <- read_csv(paste0(thisPath, "BioTIMEMetadata_02_04_2018.csv")) %>% left_join(., data, by = "STUDY_ID")

# manage ontology ---
#
matches <- read_csv(paste0(thisPath, "BioTIME_ontology.csv"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close", 
             source = thisDataset,
             certainty = 3) 

# harmonise data ----
#

temp <- data2 %>%
  mutate(
    datasetID = thisDataset,
    type = "areal",
    geometry = NA,
    x = LONGITUDE,
    y = LATITUDE,
    year = paste(START_YEAR, END_YEAR, sep = "_"),
    month = NA_real_,
    day = NA_integer_,
    country = NA_character_,
    irrigated = F,
    area = AREA_SQ_KM * 10000,
    presence = T,
    externalID = NA_character_,
    externalValue = HABITAT,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "meta study",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = as.numeric(year),
         fid = row_number()) %>%
  select(datasetID, fid, country, x, y, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())

# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
