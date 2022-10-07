# script arguments ----
#
thisDataset <- "Raley2017"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibentry(
  title = "Diurnal breeding bird data for unmanaged Douglas-fir forests in western Washington and Oregon: 1984-1986",
  bibtype = "Misc",
  doi = "https://doi.org/10.2737/RDS-2017-0058",
  institution = "Forest Service Research Data Archive",
  year = "2017",
  auther = c(
    person("Catherine M.", "Raley"),
    person("Mark H.", "Huff")))

regDataset(name = thisDataset,
           description = "This data publication contains bird count data from breeding bird surveys conducted between 1984 and 1986 in 151 natural fire-regenerated Douglas-fir stands within 3 provinces of Washington and Oregon: Southern Washington Cascade Range, Oregon Cascade Range, and the Oregon Coast Ranges. The sampling design incorporated an age gradient (young, mature, old-growth) and a moisture gradient (dry, mesic, wet). The moisture gradient was investigated only in old-growth stands (i.e., old-growth dry, old-growth mesic, and old-growth wet) and the age gradient was studied only in mesic stands (i.e., old-growth mesic, mature mesic, young mesic). In each stand, birds were sampled using the variable circular plot technique and, generally, early-morning surveys were conducted 6 times from mid-April to early July during 2 consecutive breeding seasons. Surveys were conducted in 48 Douglas-fir stands in the Southern Washington Cascades and a total of 71 bird species were detected; 56 stands were surveyed in the Oregon Cascades and 79 species were detected; and 47 stands were surveyed in the Oregon Coast Ranges and 85 species were detected. This publication also contains related stand data, including location, elevation, stand age, and moisture.",
           url = "https://doi.org/10.2737/RDS-2017-0058",
           download_date = "2022-01-08",
           type = "static",
           licence = NA_character_,
           contact = NA_character_,
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#
data <- read_csv(paste0(thisPath, "Data/OldGrowthProgram_Stand_Data.csv"))
stand1 <- read_csv(paste0(thisPath, "Data/OldGrowthProgram_BirdData_OR_Cascade.csv"))
stand2 <- read_csv(paste0(thisPath, "Data/OldGrowthProgram_BirdData_OR_Coast.csv"))
stand3 <- read_csv(paste0(thisPath, "Data/OldGrowthProgram_BirdData_SWC.csv"))


# manage ontology ---
#
# define labels in the new dataset and their matching already harmonised labels
matches <- tibble(new = c(as.character(unique(data$age))),
                  old = c("Naturally Regenerating Forest",
                          "Naturally Regenerating Forest",
                          "Undisturbed Forest"))


getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)


# harmonise data ----
#
stand <- bind_rows(stand1, stand1, stand3)
temp <- stand %>% separate(day, sep = 1, into = c("month", "day")) %>%
  left_join(., data, by = "stdno")

temp <- temp %>%
  distinct(day, yr, month, long_NAD27, lat_NAD27, .keep_all = T) %>%
  mutate(
    fid = row_number(),
    x = long_NAD27,
    y = lat_NAD27,
    geometry = NA,
    area = NA_real_,
    presence = F,
    type = "point",
    luckinetID = 1125,
    year = as.numeric(paste(19, yr, sep = "")),
    month = as.numeric(month),
    day = as.integer(day),
    datasetID = thisDataset,
    country = "United States of America",
    irrigated = F,
    externalID = NA_character_,
    externalValue = as.character(age),
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4267) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
