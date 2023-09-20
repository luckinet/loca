# script arguments ----
#
thisDataset <- "Roman2021"
description <- "These data represent land cover change in Philadelphia, Pennsylvania over 40 years, with land cover visually interpreted from aerial imagery in 1970, 1980, 1990, and 2000. Land cover classes were tree/shrub, herbaceous, other pervious, building, and other impervious at 10,000 random points."
url <- "https://doi.org/10.2737/RDS-2021-0033 https://"
licence <- ""


# reference ----
#
bib <- bibentry(
  title = "Philadelphia land cover change data, 1970-2010",
  bibtype = "Misc",
  institution = "Forest Service Research Data Archive",
  url = "https://doi.org/10.2737/RDS-2021-0033",
  author = c(
    person("Lara", "Roman", role = "aut"),
    person("Indigo J.", "Catton", role = "aut"),
    person("Eric J.", "Greenfield", role = "aut"),
    person("Hamil", "Pearsall", role = "aut"),
    person("Theodore S.", "Eisenman", role = "aut"),
    person("Jason G.", "Henning", role = "aut")),
  year = "2021",
  address = "Fort Collins, CO")

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-13"),
           type = "static",
           licence = licence,
           contact = NA_character_,
           disclosed = NA,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Data/Philadelphia_land_cover_change_data.csv"))


# pre-process data ----
#
a2010 <- data %>%
  select(-"2000", -"1990", -"1980", -"1970") %>%
  mutate(year = 2010) %>%
  rename(LC = "2010")

a2000 <- data %>%
  select(-"2010", -"1990", -"1980", -"1970") %>%
  mutate(year = 2000) %>%
  rename(LC = "2000")

a1990 <- data %>%
  select(-"2010", -"2000", -"1980", -"1970") %>%
  mutate(year = 1990) %>%
  rename(LC = "1990")

a1980 <- data %>%
  select(-"2010", -"2000", -"1990", -"1970") %>%
  mutate(year = 1980) %>%
  rename(LC = "1980")

a1970 <- data %>%
  select(-"2010", -"2000", -"1990", -"1980") %>%
  mutate(year = 1970) %>%
  rename(LC = "1970")

data <- bind_rows(a2010, a2000, a1990, a1980, a1970) %>%
  left_join(., LC_Class, by = "LC")


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = NA_character_,
    country = "United States of America",
    x = DecDegX,
    y = DecDegY,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = NA_character_,
    attr_1 = LC_text,
    attr_1_typ = "landcover",
    irrigated = NA,
    presence = NA,
    sample_type = "field",
    collector = "expert",
    purpose = NA_character_) %>%
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
