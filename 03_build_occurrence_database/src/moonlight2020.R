# script arguments ----
#
thisDataset <- "Moonlight2020"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "Data package of Nordeste Brazilian Caatinga Long-term Inventory plots."
url <- "http://dx.doi.org/https://doi.org/10.5521/forestplots.net/2020_7"
license <- "CC BY-SA 4.0"

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "ref.bib"))


regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2021-08-06",
           type = "dynamic",
           licence = "CC BY-SA 4.0",
           contact = NA_character_,
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "forestPlots_Moonlight.xlsx"), sheet = 3)

# preprocess
#

data <- data %>%
  mutate(
    `Forest Status` = case_when(`Forest Status` == "Grazed" ~ paste0("Grazed_Forest"),
                                TRUE ~ as.character(`Forest Status`))) %>%
  separate_rows(`Forest Status`, sep = "_")

# manage ontology ---
#
newConcepts <- tibble(target = c("Undisturbed Forest", "Naturally Regenerating Forest", "Naturally Regenerating Forest",
                                 "Naturally Regenerating Forest", "Temporary grazing", "Forests"),
                      new =  unique(data$`Forest Status`),
                      class = c("land-use", "land-use", "land-use",
                                "land-use", "land-use", "landcover"),
                      description = NA,
                      match = "close",
                      certainty = 3)

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
  separate(`Last Census Date`, into = c("year", "rest"))

temp <- temp %>%
  mutate(
    fid = row_number(),
    x = `Longitude Decimal`,
    y = `Latitude Decimal`,
    datasetID = thisDataset,
    date = ymd(paste0(year, "-01-01")),
    type = "areal",
    area = `Ground Area (ha)` * 10000,
    presence = T,
    geometry = NA,
    country = tolower(Country),
    irrigated = F,
    externalID = `Plot Code`,
    externalValue = `Forest Status`,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
