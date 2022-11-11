# script arguments ----
#
thisDataset <- "SAMPLES"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "Agricultural greenhouse gas emission factors"
url <- "https://samples.ccafs.cgiar.org/emissions-data/"
license <- ""


# reference ----
#
bib <- bibentry(bibtype = "Misc",
                url = "https://samples.ccafs.cgiar.org/emissions-data/",
                author = "SAMPLES (Standard Assessment of Agricultural Mitigation Potential and Livelihoods)",
                year = "2022")

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2021-09-23",
           type = "dynmaic",
           licence = license,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           path = occurrenceDBDir)

# read dataset ----
#
data <- read_csv(file = paste0(thisPath, "emissions.csv"))


# preprocess ----
#
temp <- data %>% separate_rows(description, sep = "/") %>%
  separate_rows(description, sep = "[+]")

temp1 <- data %>% select(id, org_desc = description)

data <- left_join(temp, temp1, by = "id")

# manage ontology ---
#

onto <- read_csv(paste0(thisPath, "SAMPLES_onto.csv"))

newConcepts <- tibble(target = onto$target,
                      new = onto$new,
                      class = onto$class,
                      description = NA,
                      match = "close",
                      certainty = onto$certainty)

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

temp <- data %>%
  select(-start_date) %>%
  rename(start_date = end_date)

temp <- data %>%
  select(-end_date) %>%
  bind_rows(temp)

temp <- data %>%
  mutate(
    datasetID = thisDataset,
    type = "point",
    x = longitude,
    y = latitude,
    geometry = NA,
    date = ymd(start_date),
    country = country,
    irrigated = case_when(str_match(org_desc, "irrigated") == "irrigated" ~ T,
                          is.character(description) ~ F),
    area = NA_real_,
    presence = T,
    externalID = as.character(id),
    externalValue = description,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type ="field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  drop_na(date) %>%
  mutate(fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
