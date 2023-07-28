# script arguments ----
#
thisDataset <- "Raley2017"
description <- "This data publication contains bird count data from breeding bird surveys conducted between 1984 and 1986 in 151 natural fire-regenerated Douglas-fir stands within 3 provinces of Washington and Oregon: Southern Washington Cascade Range, Oregon Cascade Range, and the Oregon Coast Ranges. The sampling design incorporated an age gradient (young, mature, old-growth) and a moisture gradient (dry, mesic, wet). The moisture gradient was investigated only in old-growth stands (i.e., old-growth dry, old-growth mesic, and old-growth wet) and the age gradient was studied only in mesic stands (i.e., old-growth mesic, mature mesic, young mesic). In each stand, birds were sampled using the variable circular plot technique and, generally, early-morning surveys were conducted 6 times from mid-April to early July during 2 consecutive breeding seasons. Surveys were conducted in 48 Douglas-fir stands in the Southern Washington Cascades and a total of 71 bird species were detected; 56 stands were surveyed in the Oregon Cascades and 79 species were detected; and 47 stands were surveyed in the Oregon Coast Ranges and 85 species were detected. This publication also contains related stand data, including location, elevation, stand age, and moisture."
url <- "https://doi.org/10.2737/RDS-2017-0058 https://"
licence <- ""


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
           description = description,
           url = url,
           download_date = ymd("2022-01-08"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Data/OldGrowthProgram_Stand_Data.csv"))
stand1 <- read_csv(paste0(thisPath, "Data/OldGrowthProgram_BirdData_OR_Cascade.csv"))
stand2 <- read_csv(paste0(thisPath, "Data/OldGrowthProgram_BirdData_OR_Coast.csv"))
stand3 <- read_csv(paste0(thisPath, "Data/OldGrowthProgram_BirdData_SWC.csv"))


# pre-process data ----
#
stand <- bind_rows(stand1, stand1, stand3)
data <- stand %>% separate(day, sep = 1, into = c("month", "day")) %>%
  left_join(., data, by = "stdno")


# harmonise data ----
#
temp <- data %>%
  distinct(day, yr, month, long_NAD27, lat_NAD27, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "United States of America",
    x = long_NAD27,
    y = lat_NAD27,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = as.numeric(paste(19, yr, sep = "")),
    # month = as.numeric(month),
    # day = as.integer(day),
    externalID = NA_character_,
    externalValue = as.character(age),
    irrigated = NA,
    presence = NA,
    sample_type = "field",
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

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
