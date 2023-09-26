# script arguments ----
#
thisDataset <- "Falster2015"
description <- "Understanding how plants are constructed—i.e., how key size dimensions and the amount of mass invested in different tissues varies among individuals—is essential for modeling plant growth, carbon stocks, and energy fluxes in the terrestrial biosphere. Allocation patterns can differ through ontogeny, but also among coexisting species and among species adapted to different environments. While a variety of models dealing with biomass allocation exist, we lack a synthetic understanding of the underlying processes. This is partly due to the lack of suitable data sets for validating and parameterizing models. To that end, we present the Biomass And Allometry Database (BAAD) for woody plants. The BAAD contains 259634 measurements collected in 176 different studies, from 21084 individuals across 678 species. Most of these data come from existing publications. However, raw data were rarely made public at the time of publication. Thus, the BAAD contains data from different studies, transformed into standard units and variable names. The transformations were achieved using a common workflow for all raw data files. Other features that distinguish the BAAD are: (i) measurements were for individual plants rather than stand averages; (ii) individuals spanning a range of sizes were measured; (iii) plants from 0.01–100 m in height were included; and (iv) biomass was estimated directly, i.e., not indirectly via allometric equations (except in very large trees where biomass was estimated from detailed sub-sampling). We included both wild and artificially grown plants. The data set contains the following size metrics: total leaf area; area of stem cross-section including sapwood, heartwood, and bark; height of plant and crown base, crown area, and surface area; and the dry mass of leaf, stem, branches, sapwood, heartwood, bark, coarse roots, and fine root tissues. We also report other properties of individuals (age, leaf size, leaf mass per area, wood density, nitrogen content of leaves and wood), as well as information about the growing environment (location, light, experimental treatment, vegetation type) where available. It is our hope that making these data available will improve our ability to understand plant growth, ecosystem dynamics, and carbon cycling in the world's vegetation."
url <- "https://doi.org/10.1890/14-1889.1 https://github.com/dfalster/baad"
licence <- "CC BY 4.0"


# reference ----
#
bib <- ris_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "pericles_1939917096.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = dmy("10-09-2022"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(file = paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "baad_data/baad_data.csv"))


# harmonise data ----
#
temp <- data %>%
  distinct(studyName, latitude, longitude, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = NA_character_,
    x = longitude,
    y = latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = str_remove(gsub("[^0-9]","", studyName), pattern = "0000"),
    externalID = NA_character_,
    externalValue = "Naturally Regenerating Forest",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "meta study",
    collector = "export",
    purpose = "study") %>%
  na_if(y = "") %>%
  mutate(date = ymd(paste0(date, "-01-01"))) %>%
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
