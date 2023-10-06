# script arguments ----
#
thisDataset <- "BioTime"
description <- "Abstract Motivation The BioTIME database contains raw data on species identities and abundances in ecological assemblages through time. These data enable users to calculate temporal trends in biodiversity within and amongst assemblages using a broad range of metrics. BioTIME is being developed as a community-led open-source database of biodiversity time series. Our goal is to accelerate and facilitate quantitative analysis of temporal patterns of biodiversity in the Anthropocene. Main types of variables included The database contains 8,777,413 species abundance records, from assemblages consistently sampled for a minimum of 2 years, which need not necessarily be consecutive. In addition, the database contains metadata relating to sampling methodology and contextual information about each record. Spatial location and grain BioTIME is a global database of 547,161 unique sampling locations spanning the marine, freshwater and terrestrial realms. Grain size varies across datasets from 0.0000000158 km2 (158 cm2) to 100 km2 (1,000,000,000,000 cm2). Time period and grain BioTIME records span from 1874 to 2016. The minimal temporal grain across all datasets in BioTIME is a year. Major taxa and level of measurement BioTIME includes data from 44,440 species across the plant and animal kingdoms, ranging from plants, plankton and terrestrial invertebrates to small and large vertebrates. Software format .csv and .SQL."
url <- "https://doi.org/10.1111/geb.12729 https://"
licence <- "various"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "pericles_1466823827.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2019-09-10"),
           type = "dynamic",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", ""))


# harmonise data ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "BioTIMEQuery02_04_2018.csv"))
data2 <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "BioTIMEMetadata_02_04_2018.csv")) %>%
  left_join(., data, by = "STUDY_ID")

temp <- data2 %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = NA_character_,
    x = LONGITUDE,
    y = LATITUDE,
    geometry = NA,
    epsg = 4326,
    area = AREA_SQ_KM * 10000,
    date = NA,
    # year = paste(START_YEAR, END_YEAR, sep = "_"),
    # day = NA_integer_,
    # country = NA_character_,
    externalID = NA_character_,
    externalValue = HABITAT,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "meta study",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = as.numeric(year),
         fid = row_number()) %>%
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

# matches <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "BioTIME_ontology.csv"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
