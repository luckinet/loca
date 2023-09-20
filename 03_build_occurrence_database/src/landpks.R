# script arguments ----
#
thisDataset <- "LandPKS"
description <- "Agricultural production must increase significantly to meet the needs of a growing global population with increasing per capita consumption of food, fiber, building materials, and fuel. Consumption already exceeds net primary production in many parts of the world (Imhoff et al. 2004)."
url <- "https://doi.org/10.2489/jswc.68.1.5A https://"
licence <- ""


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "ref.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2020-07-13"),
           type = "dynamic",
           licence = licence,
           contact = "https://landpotential.org/about/contact/",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)



# read dataset ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Export_LandInfo_Data.csv"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = NA_character_,
    country = NA_character_,
    x = NA_real_,
    y = NA_real_,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    externalID = NA_character_,
    externalValue = NA_character_,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = NA,
    presence = NA,
    sample_type = NA_character_,
    collector = NA_character_,
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
