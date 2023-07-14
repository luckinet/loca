# script arguments ----
#
thisDataset <- "Capaverde2018"
description <- "The distribution patterns of animal species at local scales have been explained by direct influences of vegetation structure, topography, food distribution, and availability. However, these variables can also interact and operate indirectly on the distribution of species. Here, we examined the direct and indirect effects of food availability (fruits and insects), vegetation clutter, and elevation in structuring phyllostomid bat assemblages in a continuous terra firme forest in Central Amazonia. Bats were captured in 49 plots over 25-km² of continuous forest. We captured 1138 bats belonging to 52 species with 7056 net*hours of effort. Terrain elevation was the strongest predictor of species and guild compositions, and of bat abundance. However, changes in elevation were associated with changes in vegetation clutter, and availability of fruits and insects consumed by bats, which are likely to have had direct effects on bat assemblages. Frugivorous bat composition was more influenced by availability of food-providing plants, while gleaning-animalivore composition was more influenced by the structural complexity of the vegetation. Although probably not causal, terrain elevation may be a reliable predictor of bat-assemblage structure at local scales in other regions. In situations where it is not possible to collect local variables, terrain elevation can substitute other variables, such as vegetation structure, and availability of fruits and insects."
url <- "https://doi.org/10.1111/btp.12546 https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1744742950.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-08-11"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Bats_Ducke_data_metadata.xlsx"), sheet = 3)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "Brazil",
    x = LONG,
    y = LAT,
    geometry = NA,
    epsg = 4326,
    area = 250 * 40,
    date = NA,
    year = "2013_2014",
    externalID = as.character(Plots),
    externalValue = "Undisturbed Forest",
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = ymd(paste0(year, "-01-01"))) %>%
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
