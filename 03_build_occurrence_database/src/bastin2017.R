# script arguments ----
#
thisDataset <- "Bastin2017"
description <- "The extent of forest in dryland biomes"
url <- "https://doi.org/10.1126/science.aam6527" # doi, in case this exists and/or download url separated by empty space
licence <- ""


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "csp_356_.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           type = "static",
           licence = licence,
           bibliography = bib,
           download_date = dmy("15-12-2021"),
           contact = "see corresponding author",
           disclosed = TRUE,
           path = occurrenceDBDir)


# read dataset ----
#
unzip(exdir = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/"),
      zipfile = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "aam6527_Bastin_Database-S1.csv.zip"))
data <- read_delim(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "aam6527_Bastin_Database-S1.csv"), delim = ";")


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = dryland_assessment_region,
    x = location_x,
    y = location_y,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd("2015", truncated = 2),
    externalID = NA_character_,
    externalValue = land_use_category,
    irrigated = FALSE,
    presence = if_else(land_use_category == "forest", TRUE, FALSE),
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "visual interpretation",
    collector = "citizen scientist",
    purpose = "study") %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated,
         area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())


# manage ontology ---
#
new_source(name = thisDataset,
           description = description,
           homepage = url,
           date = Sys.Date(),
           license = license,
           ontology = ontoDir)

# newConcepts <- tibble(target = c("Forests", "Forests"), # translating both to forest, and record the non-forest as absences, instead of presences below
#                       new = unique(data$land_use_category),
#                       class = "landcover",
#                       description = "",
#                       match = "close",
#                       certainty = 3)
#

# luckiOnto <- new_mapping(new = newConcepts$new,
#                          target = get_concept(x = newConcepts %>% select(label = target), ontology = luckiOnto),
#                          source = thisDataset,
#                          description = newConcepts$description,
#                          match = newConcepts$match,
#                          certainty = newConcepts$certainty,
#                          ontology = luckiOnto, matchDir = paste0(occurrenceDBDir, "01_concepts/"))

out <- matchOntology(table = temp,
                     columns = ,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
