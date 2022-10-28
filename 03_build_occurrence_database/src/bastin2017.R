# script arguments ----
#
thisDataset <- "Bastin2017"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "csp_356_.bib"))

description <- "The extent of forest in dryland biomes"
url <- "https://doi.org/10.1126/science.aam6527"    # ideally the doi, but if it doesn't have one, the main source of the database
license <- ""

regDataset(name = thisDataset,
           description = description,
           url = url,
           type = "static",
           licence = license,
           bibliography = bib,
           download_date = dmy("15-12-2021"),
           contact = "see corresponding author",
           disclosed = TRUE,
           path = occurrenceDBDir)


# read dataset ----
#
unzip(exdir = thisPath, zipfile = paste0(thisPath, "aam6527_Bastin_Database-S1.csv.zip"))
data <- read_delim(paste0(thisPath, "aam6527_Bastin_Database-S1.csv"), delim = ";")


# manage ontology ---
#
newConcepts <- tibble(target = c("Forests", "Forests"), # translating both to forest, and record the non-forest as absences, instead of presences below
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


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(path = occurrenceDBDir, name = thisDataset)

write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
