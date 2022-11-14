# script arguments ----
#
thisDataset <- "Doughty2015"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#

bib <- ris_reader(paste0(thisPath, "10.1038_nature14213-citation.ris"))

regDataset(name = thisDataset,
           description = "Severe drought in a tropical forest ecosystem suppresses photosynthetic carbon uptake and plant maintenance respiration, but growth is maintained, suggesting that, overall, less carbon is available for tree tissue maintenance and defence, which may cause the subsequent observed increase in tree mortality.",
           url = "https://doi.org/10.1038/nature14213",
           download_date = "2021-12-3",
           type = "static",
           licence = "",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "summary_manual.xlsx"))


# manage ontology ---
#
matches <- tibble(new = c(unique(data$land_use)),
                  old = c("Forest land", "Undisturbed forest", "Undisturbed forest", "Naturally regenerating forest"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)

# harmonise data ----
#
temp <- data %>%
  mutate(
    fid = row_number(),
    x = longitude,
    y = latitude,
    date = ymd(pate0(year, "-01-01")),
    datasetID = thisDataset,
    irrigated = FALSE,
    externalID = NA_character_,
    externalValue = land_use,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    presence = TRUE,
    type = "point",
    area = NA_real_,
    geometry = NA,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
