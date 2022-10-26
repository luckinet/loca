# script arguments ----
#
thisDataset <- "Bastin2017"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "The extent of forest in dryland biomes"
url <- "https://doi.org/10.1126/science.aam6527"    # ideally the doi, but if it doesn't have one, the main source of the database
license <- ""


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "csp_356_.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           type = "static",
           licence = license,
           bibliography = bib,
           download_date = "2021-12-15",
           contact = "see corresponding author",
           disclosed = "yes",
           path = paste0(occurrenceDBDir, "inv_datasets.csv"))


# read dataset ----
#
unzip(exdir = thisPath, zipfile = paste0(thisPath, "aam6527_Bastin_Database-S1.csv.zip"))
data <- read_delim(paste0(thisPath, "aam6527_Bastin_Database-S1.csv"), delim = ";")


# manage ontology ---
#
newConcepts <- tibble(target = c("Forests", "Forests"),
                      new = unique(data$land_use_category),
                      class = "landcover",
                      description = "",
                      match = "close",
                      certainty = 3)

luckiOnto <- new_source(name = thisDataset,
                        description = description,
                        homepage = url,
                        date = Sys.Date(),
                        license = license,
                        ontology = luckiOnto)

# in case new harmonised concepts appear here (avoid if possible)
# luckiOnto <- new_concept(new = , broader = , class = , description = ,
#                          ontology = luckiOnto)

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
  mutate(fid = row_number(),
         type = "point",
         x = location_x,
         y = location_y,
         geometry = NA,
         year = as.numeric(2015),
         month = NA_real_,
         day = NA_integer_,
         country = dryland_assessment_region,
         irrigated = FALSE,
         area = NA_real_,
         presence = if_else(land_use_category == "forest", TRUE, FALSE),
         datasetID = thisDataset,
         externalValue = land_use_category,
         externalID = NA_character_,
         LC1_orig = NA_character_,
         LC2_orig = NA_character_,
         LC3_orig = NA_character_,
         sample_type = "visual interpretation",
         collector = "citizen scientist",
         purpose = "study",
         epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
