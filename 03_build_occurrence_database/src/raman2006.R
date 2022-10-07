# script arguments ----
#
thisDataset <- "Raman2006"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1007_s10531-005-2352-5-citation.ris")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "As large nature reserves occupy only a fraction of the earth’s land surface, conservation biologists are critically examining the role of private lands, habitat fragments, and plantations for conservation. This study in a biodiversity hotspot and endemic bird area, the Western Ghats mountains of India, examined the effects of habitat structure, floristics, and adjacent habitats on bird communities in shade-coffee and cardamom plantations and tropical rainforest fragments. Habitat and birds were sampled in 13 sites: six fragments (three relatively isolated and three with canopy connectivity with adjoining shade-coffee plantations and forests), six plantations differing in canopy tree species composition (five coffee and one cardamom), and one undisturbed primary rainforest control site in the Anamalai hills. Around 3300 detections of 6000 individual birds belonging to 106 species were obtained. The coffee plantations were poorer than rainforest in rainforest bird species, particularly endemic species, but the rustic cardamom plantation with diverse, native rainforest shade trees, had bird species richness and abundance comparable to primary rainforest. Plantations and fragments that adjoined habitats providing greater tree canopy connectivity supported more rainforest and fewer open-forest bird species and individuals than sites that lacked such connectivity. These effects were mediated by strong positive effects of vegetation structure, particularly woody plant variables, cane, and bamboo, on bird community structure. Bird community composition was however positively correlated only to floristic (tree species) composition of sites. The maintenance or restoration of habitat structure and (shade) tree species composition in shade-coffee and cardamom plantations and rainforest fragments can aid in rainforest bird conservation in the regional landscape.",
           url = "https://doi.org/10.1007/s10531-005-2352-5",
           download_date = "20022-01-08",
           type = "static",
           licence = NA_character_,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)



# read dataset ----
#
data <- read_csv(paste0(thisPath, "02_Sites.csv"))
times <- read_csv(paste0(thisPath, "04_PointCountData.csv"))


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
data <- data %>% left_join(., times, by = "SiteCode")
data$luckinetID <- c(770, 1125, 1125, 1125, 770, 1125, 1125, 1138, 1138, 1138, 1138, 1138, 1138)
times <- times %>% distinct(Day, Month, Year, SiteCode)

temp <- data %>%
  mutate(
    fid = row_number(),
    x = Longitude,
    y = Latitude,
    year = Year,
    month = Month,
    day = Day,
    datasetID = thisDataset,
    country = "India",
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = NA_character_,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
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
