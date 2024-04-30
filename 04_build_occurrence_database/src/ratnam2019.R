# script arguments ----
#
thisDataset <- "Ratnam2019"
description <- "Two dominant biomes that occur across the southern Indian peninsula are dry deciduous “forests” and evergreen forests, with the former occurring in drier regions and the latter in wetter regions, sometimes in close proximity to each other. Here we compare stem and leaf traits of trees from multiple sites across these biomes to show that dry deciduous “forest” species have, on average, lower height: diameter ratios, lower specific leaf areas, higher wood densities and higher relative bark thickness, than evergreen forest species. These traits are diagnostic of these dry deciduous “forests” as open, well-lit, drought-, and fire-prone habitats where trees are conservative in their growth strategies and invest heavily in protective bark tissue. These tree traits together with the occurrence of a C4 grass-dominated understory, diverse mammalian grazers, and frequent fires indicate that large tracts of dry deciduous “forests” of southern India are more accurately classified as mesic deciduous “savannas."
url <- "https://doi.org/10.3389/fevo.2019.00008 https://"
licence <- ""


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "10.3389-fevo.2019.00008-citation.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-08-18"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "frontiers_ratnam.csv"))


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = country,
    x = x,
    y = y,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd("2019-01-01"),
    externalID = NA_character_,
    externalValue = "Naturally Regenerating Forest",
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
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
