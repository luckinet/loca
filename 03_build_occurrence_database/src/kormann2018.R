# script arguments ----
#
thisDataset <- "Kormann2018"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1365266455.bib"))

regDataset(name = thisDataset,
           description = "Tropical conservation strategies traditionally focus on large tracts of pristine forests but, given rapid primary forest decline, understanding the role of secondary forest remnants for biodiversity maintenance is critical. Until now, the interactive effects of changes in forest amount, configuration and disturbance history (secondary vs. primary forest) on the conservation value of tropical landscapes have remained unknown, hampering the incorporation of these global change drivers into local and global conservation planning. We disentangled effects of landscape-wide forest amount, fragment size and forest age (old growth vs. secondary forest) on abundance, α-diversity, β-diversity (biotic homogenization) and community shifts of bird communities in human-dominated landscapes of southern Costa Rica. Utilizing two complementary methods, yielding 6,900 individual detections and 223 species, we characterized bird communities in 49 forest fragments representing independent gradients in fragment size (<5 ha vs. >30 ha) and forest amount (5%–80%) in the surrounding landscape (within 1000 m). Abundance and α-diversity of forest specialists and insectivores declined by half in small fragments, but only in landscapes with little old-growth forest. Conversely, secondary forest at the landscape scale showed no such compensation effect. Similarly, a null-model approach indicated significant biotic homogenization in small vs. large fragments, but only in landscapes with little old-growth forest, suggesting forest amount and configuration interactively affect β-diversity in tropical human-dominated landscapes. Finally, dramatic abundance-based community shifts relative to intact forests are largely a result of landscape-scale loss of old growth rather than changes in overall forest cover. Policy implications. Our study provides strong evidence that retaining old growth within tropical human-modified landscapes can simultaneously curb erosion of avian forest specialist α-diversity, mitigate collapse of β-diversity (biotic homogenization) and dampen detrimental avian community shifts. However, secondary forests play, at best, a subordinate role to mitigate these processes. To maintain tropical forest biodiversity, retaining old-growth forest within landscapes should be first priority, highlighting a land-sparing approach.",
           url = "https://doi.org/10.5061/dryad.0t9d3",
           download_date = "2022-01-22",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)


# read dataset ----
#
data <- read_tsv(paste0(thisPath, "Data/PointCounts.txt"))
data <- data %>%
  mutate(year = "5-2011_6-2011_6-2012") %>%
  separate_rows(year, sep = "_") %>%
  separate(year, sep = "-", into = c("month", "year"))


# harmonise data ----
#
temp <- data %>%
  distinct(X,Y, .keep_all = T) %>%
  mutate(
    fid = row_number(),
    x = X,
    y = Y,
    type = "areal",
    presence = F,
    area = Area * 10000,
    geometry = NA,
    year = as.numeric(year),
    month = as.numeric(month),
    day = NA_integer_,
    datasetID = thisDataset,
    country = "Costa Rica",
    irrigated = F,
    externalID = NA_character_,
    externalValue = "Undisturbed Forest",
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
