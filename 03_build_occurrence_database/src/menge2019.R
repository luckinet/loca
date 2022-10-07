# script arguments ----
#
thisDataset <- "Menge2019"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_13652745107.bib"))

regDataset(name = thisDataset,
           description = "Symbiotic nitrogen (N)-fixing trees can provide large quantities of new N to ecosystems, but only if they are sufficiently abundant. The overall abundance and latitudinal abundance distributions of N-fixing trees are well characterised in the Americas, but less well outside the Americas. Here, we characterised the abundance of N-fixing trees in a network of forest plots spanning five continents, ~5,000 tree species and ~4 million trees. The majority of the plots (86%) were in America or Asia. In addition, we examined whether the observed pattern of abundance of N-fixing trees was correlated with mean annual temperature and precipitation. Outside the tropics, N-fixing trees were consistently rare in the forest plots we examined. Within the tropics, N-fixing trees were abundant in American but not Asian forest plots (~7% versus ~1% of basal area and stems). This disparity was not explained by mean annual temperature or precipitation. Our finding of low N-fixing tree abundance in the Asian tropics casts some doubt on recent high estimates of N fixation rates in this region, which do not account for disparities in N-fixing tree abundance between the Asian and American tropics. Synthesis. Inputs of nitrogen to forests depend on symbiotic nitrogen fixation, which is constrained by the abundance of N-fixing trees. By analysing a large dataset of ~4 million trees, we found that N-fixing trees were consistently rare in the Asian tropics as well as across higher latitudes in Asia, America and Europe. The rarity of N-fixing trees in the Asian tropics compared with the American tropics might stem from lower intrinsic N limitation in Asian tropical forests, although direct support for any mechanism is lacking. The paucity of N-fixing trees throughout Asian forests suggests that N inputs to the Asian tropics might be lower than previously thought.",
           url = "https://doi.org/10.1111/1365-2745.13199",
           download_date = "2022-01-18",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "MengeEtAl_Appendix2_SuppInfo_Final.xlsx"))


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)


# harmonise data ----
#
temp <- data %>%
  mutate(
    fid = row_number(),
    x = Longitude,
    y = Latitude,
    year = NA_character_,
    month = NA_character_,
    day = NA_character_,
    datasetID = thisDataset,
    country = NA_character_,
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = "Forest land",
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
