# script arguments ----
#
thisDataset <- "Hudson2016"
description = "The PREDICTS project—Projecting Responses of Ecological Diversity In Changing Terrestrial Systems (www.predicts.org.uk)—has collated from published studies a large, reasonably representative database of comparable samples of biodiversity from multiple sites that differ in the nature or intensity of human impacts relating to land use. We have used this evidence base to develop global and regional statistical models of how local biodiversity responds to these measures. We describe and make freely available this 2016 release of the database, containing more than 3.2 million records sampled at over 26,000 locations and representing over 47,000 species. We outline how the database can help in answering a range of questions in ecology and conservation biology. To our knowledge, this is the largest and most geographically and taxonomically representative database of spatial comparisons of biodiversity that has been collated to date; it will be useful to researchers and international efforts wishing to model and understand the global status of biodiversity."
url <- "https://doi.org/10.5519/0066354 https://"
licence <- "CC-BY-4.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Hudson_cit-bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-06-02"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "database.csv"))


# pre-process data ----
#
data <- data %>%
  mutate(Tid = row_number())

data <- data %>%
  mutate(start = year(Sample_start_earliest),
         end = year(Sample_end_latest),
         Tid = row_number())

data <- data %>%
  transmute(Tid , year = map2(start, end, `:`)) %>%
  unnest %>%
  left_join(., data, by = "Tid")


# harmonise data ----
#
temp <- data %>%
  distinct(Biome, Longitude, Latitude, year, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = Country,
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = Habitat_patch_area_square_metres,
    date = NA,
    # year = as.numeric(year),
    # month = NA_real_,
    # day = NA_integer_,
    externalID = NA_character_,
    externalValue = Biome,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "meta study",
    collector = "expert",
    purpose = "study") %>%
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

# matches <- tibble(new = c(unique(data$Biome)),
#                   old = c("Forests", "Forests",
#                           "Forests", "Shrubland",
#                           "Forests", "Shrubland",
#                           "Shrubland", "Marine wetlands",
#                           "Forests", "Herbaceous associations",
#                           "Forests", "Forests",
#                           "Inland wetlands", "Shrubland"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
