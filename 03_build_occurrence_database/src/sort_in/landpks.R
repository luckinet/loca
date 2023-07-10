# script arguments ----
#
thisDataset <- "LandPKS"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "ref.bib")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "Agricultural production must increase significantly to meet the needs of a growing global population with increasing per capita consumption of food, fiber, building materials, and fuel. Consumption already exceeds net primary production in many parts of the world (Imhoff et al. 2004).",
           url = "https://doi.org/10.2489/jswc.68.1.5A",
           download_date = "2020-07-13",
           type = "dynamic",
           licence = "public",
           contact = "https://landpotential.org/about/contact/",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Export_LandInfo_Data.csv"))


# manage ontology ---
#



# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    x = ,
    y = ,
    year = ,
    month = ,
    day = ,
    country = NA_character_,
    irrigated = NA_character_,
    area = ,
    presence = TRUE,
    externalID = NA_character_,
    externalValue = ,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = , # "field", "visual interpretation", "experience", "meta study" or "modelled"
    collector = , # "expert", "citizen scientist" or "student"
    purpose = , # "monitoring", "validation", "study" or "map development"
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
saveDataset(object = temp, dataset = thisDataset)
