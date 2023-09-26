# script arguments ----
#
thisDataset <- "Borer2019"
description <- "Sodium is unique among abundant elemental nutrients, because most plant species do not require it for growth or development, whereas animals physiologically require sodium. Foliar sodium influences consumption rates by animals and can structure herbivores across landscapes. We quantified foliar sodium in 201 locally abundant, herbaceous species representing 32 families and, at 26 sites on four continents, experimentally manipulated vertebrate herbivores and elemental nutrients to determine their effect on foliar sodium. Foliar sodium varied taxonomically and geographically, spanning five orders of magnitude. Site‐level foliar sodium increased most strongly with site aridity and soil sodium; nutrient addition weakened the relationship between aridity and mean foliar sodium. Within sites, high sodium plants declined in abundance with fertilisation, whereas low sodium plants increased. Herbivory provided an explanation: herbivores selectively reduced high nutrient, high sodium plants. Thus, interactions among climate, nutrients and the resulting nutritional value for herbivores determine foliar sodium biogeography in herbaceous‐dominated systems."
url <- "https://doi.org/10.5061/dryad.c742372 https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "pericles_1461024822.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-06-01"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "sodium-resp-data-table.csv"))


# harmonise data ----
#
temp <- data %>%
  distinct(latitude, longitude, year, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = case_when(country == "US" ~ "United States of America",
                        country == "AU" ~ "Australia",
                        country == "PT" ~ "Portugal",
                        country == "CA" ~ "Canada",
                        country == "CH" ~ "Switzerland",
                        country == "ZA" ~ "South Africa",
                        country == "UK" ~ "united Kingdom"),
    x = longitude,
    y = latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    area = 25,
    # year = year,
    # month = NA_real_,
    # day = NA_integer_,
    externalID = NA_character_,
    externalValue = "Permanent grazing",
    irrigated = FALSE,
    presence = FALSE,
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
