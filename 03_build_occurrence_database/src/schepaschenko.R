# script arguments ----
#
thisDataset <- "Schepaschenko2017"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "Schepaschenko-etal_2017.bib"))

regDataset(name = thisDataset,
           description = "The most comprehensive dataset of in situ destructive sampling measurements of forest biomass in Eurasia have been compiled from a combination of experiments undertaken by the authors and from scientific publications. Biomass is reported as four components: live trees (stem, bark, branches, foliage, roots); understory (above- and below ground); green forest floor (above- and below ground); and coarse woody debris (snags, logs, dead branches of living trees and dead roots), consisting of 10,351 unique records of sample plots and 9,613 sample trees from ca 1,200 experiments for the period 1930–2014 where there is overlap between these two datasets. The dataset also contains other forest stand parameters such as tree species composition, average age, tree height, growing stock volume, etc., when available. Such a dataset can be used for the development of models of biomass structure, biomass extension factors, change detection in biomass structure, investigations into biodiversity and species distribution and the biodiversity-productivity relationship, as well as the assessment of the carbon pool and its dynamics, among many others.",
           url = "https://doi.org/10.1038/sdata.2017.70",
           type = "static",
           licence = "CC BY 4.0",
           bibliography = bib,
           download_date = "2021-12-17",
           contact = "see corresponding author",
           disclosed = "yes",
           update = TRUE)


# read dataset ----
#
data <- read_tsv(paste0(thisPath, "Biomass_plot_DB.tab"), skip = 54)


# manage ontology ---
#
matches <- tibble(new = unique(data$Origin),
                  old = c("Undisturbed Forest", "Planted Forest", NA,
                          "Naturally Regenerating Forest", "Undisturbed Forest",
                          "Naturally Regenerating Forest"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = ., external = matches$new, match = "close",
             source = thisDataset, certainty = 3)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    year = `Date (Year of measurements)`,
    month = NA_real_,
    day = NA_integer_,
    country = `Country (Country code (ISO ALPHA-3))`,
    irrigated = NA,
    area = NA_real_,
    presence = TRUE,
    externalID = as.character(`ID (Unique record ID)`),
    externalValue = Origin,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, area, epsg, type, year, month, day, irrigated, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
