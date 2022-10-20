# script arguments ----
#
thisDataset <- "Morera-Beita2019"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "Recent studies have reported a consistent pattern of strong dominance of a small subset of tree species in neotropical forests. These species have been called “hyperdominant” at large geographical scales and “oligarchs” at regional-landscape scales when being abundant and frequent. Forest community assembly is shaped by environmental factors and stochastic processes, but so far the contribution of oligarchic species to the variation of community composition (i.e., beta diversity) remains poorly known. To that end, we established 20.1-ha plots, that is, five sites with four forest types (ridge, slope and ravine primary forest, and secondary forest) per site, in humid lowland tropical forests of southwestern Costa Rica to (a) investigate how community composition responds to differences in topography, successional stage, and distance among plots for different groups of species (all, oligarch, common and rare/very rare species) and (b) identify oligarch species characterizing changes in community composition among forest types. From a total of 485 species of trees, lianas and palms recorded in this study only 27 species (i.e., 6%) were nominated as oligarch species. Oligarch species accounted for 37% of all recorded individuals and were present in at least half of the plots. Plant community composition significantly differed among forest types, thus contributing to beta diversity at the landscape scale. Oligarch species was the component best explained by geographical and topographic variables, allowing a confident characterization of the beta diversity among tropical lowland forest stands."
url <- "https://doi.org/10.1111/btp.12638"
license <- "CC0 1.0"

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1744742951.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "2022-01-10",
           type = "static",
           licence = ,
           contact = "see corresponding author",
           disclosed = "no",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "tree_abundance_data_GolfoDulce_BITR-18-091R2.xlsx"), sheet = 6)



# harmonise data ----
#
temp <- data %>%
  mutate(
    fid = row_number(),
    x = `longitude (decimal degrees)`,
    y = `latitude (decimal degrees)`,
    luckinetID = 1136,
    year = NA_real_,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    country = "Costa Rica",
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = NA_character_,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, year, month, day, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())

# before preparing data for storage, test that all required variables are available
assertNames(x = names(temp),
            must.include = c("datasetID", "fid", "country", "x", "y", "epsg",
                             "year", "month", "day", "irrigated",
                             "externalID", "externalValue", "LC1_orig", "LC2_orig", "LC3_orig",
                             "sample_type", "collector", "purpose"))


# write output ----
#
saveDataset(object = temp, dataset = thisDataset)
