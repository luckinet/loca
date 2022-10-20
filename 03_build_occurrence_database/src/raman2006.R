# script arguments ----
#
thisDataset <- "Raman2006"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "As large nature reserves occupy only a fraction of the earth’s land surface, conservation biologists are critically examining the role of private lands, habitat fragments, and plantations for conservation. This study in a biodiversity hotspot and endemic bird area, the Western Ghats mountains of India, examined the effects of habitat structure, floristics, and adjacent habitats on bird communities in shade-coffee and cardamom plantations and tropical rainforest fragments. Habitat and birds were sampled in 13 sites: six fragments (three relatively isolated and three with canopy connectivity with adjoining shade-coffee plantations and forests), six plantations differing in canopy tree species composition (five coffee and one cardamom), and one undisturbed primary rainforest control site in the Anamalai hills. Around 3300 detections of 6000 individual birds belonging to 106 species were obtained. The coffee plantations were poorer than rainforest in rainforest bird species, particularly endemic species, but the rustic cardamom plantation with diverse, native rainforest shade trees, had bird species richness and abundance comparable to primary rainforest. Plantations and fragments that adjoined habitats providing greater tree canopy connectivity supported more rainforest and fewer open-forest bird species and individuals than sites that lacked such connectivity. These effects were mediated by strong positive effects of vegetation structure, particularly woody plant variables, cane, and bamboo, on bird community structure. Bird community composition was however positively correlated only to floristic (tree species) composition of sites. The maintenance or restoration of habitat structure and (shade) tree species composition in shade-coffee and cardamom plantations and rainforest fragments can aid in rainforest bird conservation in the regional landscape."
url <- "https://doi.org/10.1007/s10531-005-2352-5, https://doi.org/10.5061/dryad.4mw6m907q"
license <- ""

# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1007_s10531-005-2352-5-citation.ris"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = "20022-01-08",
           type = "static",
           licence = licence,
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
newConcepts <- tibble(target = c("Undisturbed Forest", "Forests", "Woody plantation",
                                 "Woody plantation", "Undisturbed Forest", "Woody plantation",
                                 "Naturally Regenerating Forest", "Forests", "Forests",
                                 "Forests", "Forests", "Forests",
                                 "Forests"),
                      new = unique(data$Description),
                      class = c("land-use", "landcover", "land-use",
                                "land-use", "land-use", "land-use",
                                "land-use", "landcover", "landcover",
                                "landcover", "landcover", "landcover",
                                "lanndcover"),
                      description = NA,
                      match = "close",
                      certainty = 3)

luckiOnto <- new_source(name = thisDataset,
                        description = description,
                        date = Sys.Date(),
                        homepage = url,
                        license = license,
                        ontology = luckiOnto)

luckiOnto <- new_mapping(new = newConcepts$new,
                         target = get_concept(x = newConcepts %>% select(label = target), ontology = luckiOnto),
                         source = thisDataset,
                         description = newConcepts$description,
                         match = newConcepts$match,
                         certainty = newConcepts$certainty,
                         ontology = luckiOnto, matchDir = paste0(occurrenceDBDir, "01_concepts/"))


# harmonise data ----
#
temp <- data %>% left_join(., times, by = "SiteCode")

temp <- temp %>%
  distinct(Day, Month, Year, SiteCode, .keep_all = T) %>%
  mutate(
    fid = row_number(),
    x = Longitude,
    y = Latitude,
    date = ymd(paste(Year, Month, Day, sep = "-")),
    type = "point",
    presence = T,
    area = NA_real_,
    geometry = NA,
    datasetID = thisDataset,
    country = "India",
    irrigated = F,
    externalID = NA_character_,
    externalValue = Description,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
