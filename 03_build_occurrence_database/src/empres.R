# script arguments ----
#
thisDataset <- "empres"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- ""
url <- "https://empres-i.apps.fao.org/"
license <- ""


# reference ----
#
bib <- ris_reader(paste0(thisPath, ""))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2022-10-26",
           type = "static",
           licence = license,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           path = occurrenceDBDir)


# pre-process data ----
#
# (potentially) collate all raw datasets into one full dataset (if not previously done)


# read dataset ----
#
listFiles <- list.files(paste0(thisPath), full.names = T)[2:7]

data <- map(listFiles, read_csv, skip = 10, col_types = "cccccccnnccccccc")

data[[3]] <- data[[3]] %>%
  mutate(Human.deaths = as.numeric(Human.deaths),
         Humans.affected = as.double(Humans.affected))

data <- bind_rows(data)

# preprocess
#

data <- data %>%
  filter(!str_detect(Species, 'Wild'))


# manage ontology ---
#
newConcepts <- tibble(target = c("pig", "UNGULATES", "cattle", "UNGULATES",
                                 "goat", "sheep", "sheep goat", NA,
                                 "chicken", NA, NA, "horse",
                                 "horse", "UNGULATES", "camel", "buffalo",
                                 "deer", "UNGULATES", NA, "mule",
                                 "sheep goat", "buffalo", "horse", "turkey",
                                 "ferret", "mink", "pigeon", "cattle",
                                 "Poultry Birds", NA, "duck", "goose",
                                 NA, NA, NA, "rabbit",
                                 "buffalo"),
                      new = unique(data$Species),
                      class = c("commodity", "group", "commodity", "group",
                                "commodity", "commodity", "aggregate", NA,
                                "commodity", NA, NA, "commodity",
                                "commodity", "group", "commodity", "commodity",
                                "commodity", "group", NA, "commodity",
                                "aggregate", "commodity", "commodity", "commodity",
                                "commodity", "commodity", "commodity", "commodity",
                                "class", NA, "commodity", "commodity",
                                NA, NA, NA, "commodity",
                                "commodity"),
                      description = NA,
                      match = "close",
                      certainty = c(3, 1, 3, 1,
                                    3, 3, 3, NA,
                                    3, NA, NA, 3,
                                    2, 1, 3, 3,
                                    3, 1, NA, 3,
                                    3, 3, 3, 3,
                                    3, 3, 3, 2,
                                    1, NA, 3, 3,
                                    NA, NA, NA, 3,
                                    3))

luckiOnto <- new_source(name = thisDataset,
                        description = description,
                        date = Sys.Date(),
                        homepage = url,
                        license = license,
                        ontology = luckiOnto)

luckiOnto <- new_concept(new = "deer", broader = ".002.019", class = "commodity", description = NA,
                          ontology = luckiOnto)

luckiOnto <- new_concept(new = "CARNIVORES", broader = ".002", class = "group", description = NA,
                         ontology = luckiOnto)

luckiOnto <- new_concept(new = "Mustelids", broader = ".002.021", class = "class", description = NA, # broader depends on carnivores
                         ontology = luckiOnto)

luckiOnto <- new_concept(new = "ferret", broader = ".002.021.001", class = "commodity", description = NA,
                         ontology = luckiOnto)
luckiOnto <- new_concept(new = "mink", broader = ".002.021.001", class = "commodity", description = NA,
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
  mutate(
    datasetID = thisDataset,
    type = "point",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    date = dmy(Observation.date..dd.mm.yyyy.),
    country = Country,
    irrigated = F,
    area = NA_real_,
    presence = T,
    externalID = NA_character_,
    externalValue = Species,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring",
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
