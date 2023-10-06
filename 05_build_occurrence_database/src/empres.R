# script arguments ----
#
thisDataset <- "empres"
description <- ""
url <- "https://doi.org/ https://empres-i.apps.fao.org/"
licence <- ""


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "")) # or bibtex_reader()

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-10-26"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
listFiles <- list.files(paste0(occurrenceDBDir, "00_incoming/", thisDataset), full.names = T)[2:7]

data <- map(listFiles, read_csv, skip = 10, col_types = "cccccccnnccccccc")


# pre-process data ----
#
data[[3]] <- data[[3]] %>%
  mutate(Human.deaths = as.numeric(Human.deaths),
         Humans.affected = as.double(Humans.affected))

data <- bind_rows(data)

data <- data %>%
  filter(!str_detect(Species, 'Wild'))

# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = Country,
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = dmy(Observation.date..dd.mm.yyyy.),
    externalID = NA_character_,
    externalValue = Species,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring") %>%
  drop_na(date) %>%
  mutate(fid = row_number()) %>%
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

# newConcepts <- tibble(target = c("pig", "UNGULATES", "cattle", "UNGULATES",
#                                  "goat", "sheep", "sheep goat", NA,
#                                  "chicken", NA, NA, "horse",
#                                  "horse", "UNGULATES", "camel", "buffalo",
#                                  "deer", "UNGULATES", NA, "mule",
#                                  "sheep goat", "buffalo", "horse", "turkey",
#                                  "ferret", "mink", "pigeon", "cattle",
#                                  "Poultry Birds", NA, "duck", "goose",
#                                  NA, NA, NA, "rabbit",
#                                  "buffalo"),
#                       new = unique(data$Species),
#                       class = c("commodity", "group", "commodity", "group",
#                                 "commodity", "commodity", "aggregate", NA,
#                                 "commodity", NA, NA, "commodity",
#                                 "commodity", "group", "commodity", "commodity",
#                                 "commodity", "group", NA, "commodity",
#                                 "aggregate", "commodity", "commodity", "commodity",
#                                 "commodity", "commodity", "commodity", "commodity",
#                                 "class", NA, "commodity", "commodity",
#                                 NA, NA, NA, "commodity",
#                                 "commodity"),
#                       description = NA,
#                       match = "close",
#                       certainty = c(3, 1, 3, 1,
#                                     3, 3, 3, NA,
#                                     3, NA, NA, 3,
#                                     2, 1, 3, 3,
#                                     3, 1, NA, 3,
#                                     3, 3, 3, 3,
#                                     3, 3, 3, 2,
#                                     1, NA, 3, 3,
#                                     NA, NA, NA, 3,
#                                     3))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
