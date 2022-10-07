# script arguments ----
#
thisDataset <- "Borer2019"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "pericles_1461024822.ris"))

regDataset(name = thisDataset,
           description = "Sodium is unique among abundant elemental nutrients, because most plant species do not require it for growth or development, whereas animals physiologically require sodium. Foliar sodium influences consumption rates by animals and can structure herbivores across landscapes. We quantified foliar sodium in 201 locally abundant, herbaceous species representing 32 families and, at 26 sites on four continents, experimentally manipulated vertebrate herbivores and elemental nutrients to determine their effect on foliar sodium. Foliar sodium varied taxonomically and geographically, spanning five orders of magnitude. Site‐level foliar sodium increased most strongly with site aridity and soil sodium; nutrient addition weakened the relationship between aridity and mean foliar sodium. Within sites, high sodium plants declined in abundance with fertilisation, whereas low sodium plants increased. Herbivory provided an explanation: herbivores selectively reduced high nutrient, high sodium plants. Thus, interactions among climate, nutrients and the resulting nutritional value for herbivores determine foliar sodium biogeography in herbaceous‐dominated systems. ",
           url = "https://doi.org/10.5061/dryad.c742372",
           download_date = "2022-06-01",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#

data <- read_csv(file = paste0(thisPath, "sodium-resp-data-table.csv"))

# harmonise data ----
#

temp <- data %>%
  distinct(latitude, longitude, year, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    x = longitude,
    y = latitude,
    geometry = NA,
    year = year,
    month = NA_real_,
    day = NA_integer_,
    country = case_when(country == "US" ~ "United States of America",
                        country == "AU" ~ "Australia",
                        country == "PT" ~ "Portugal",
                        country == "CA" ~ "Canada",
                        country == "CH" ~ "Switzerland",
                        country == "ZA" ~ "South Africa",
                        country == "UK" ~ "united Kingdom"),
    irrigated = F,
    area = 25,
    presence = F,
    externalID = NA_character_,
    externalValue = "Permanent grazing",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
