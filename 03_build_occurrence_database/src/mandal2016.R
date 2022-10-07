# script arguments ----
#
thisDataset <- "Mandal2016"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "citations-20220118T144928.bibtex"))

regDataset(name = thisDataset,
           description = "Conversion of tropical forests and diverse multicrop agricultural land to commercial monocultures is a conservation concern worldwide. In northeast India, landscapes under shifting agriculture (or jhum) practiced by tribal communities are increasingly being replaced by monoculture plantations (e.g., teak, oil palm). We compared oil palm and teak plantations, shifting agricultural fields, and forest fallows (0–8 yr regeneration) with tropical rainforest edge and interior sites in Dampa Tiger Reserve, Mizoram, India. Twenty replicate transects were surveyed in each of the 5 study strata for vegetation structure, bird species richness and density, bird abundance, and species composition. Tree density and canopy and vertical structure were lowest in oil palm plantations, intermediate in teak plantations and jhum, and highest in rainforest sites. Tree density in jhum (4.3 stems per 100 m2) was much higher than in oil palm plantations (0.5 stems per 100 m2), but lower than in rainforest (6.8–8.2 stems per 100 m2), with bamboo absent in oil palm plantations and most abundant in regenerating jhum (25 culms per 50 m2). We recorded 107 bird species (94 forest species, 13 open-country species). Oil palm plantations had the lowest forest bird species richness (10 species), followed by teak plantations (38), while jhum (50) had only slightly lower species richness than the rainforest edge (58) and interior (70). Forest bird abundance in the jhum landscape was similar to that in rainforest, on average 304% higher than in oil palm plantations, and 87% higher than in teak plantations. Jhum sites were more similar in bird community composition to rainforest than were monocultures. Rapid recovery of dense and diverse secondary bamboo forests during fallow periods makes the shifting agricultural landscape mosaic a better form of land use for bird conservation than monocultures. Land use policy and conservation plans should provide greater support for shifting agriculture, while mandating better land use practices such as retention of forest remnants, native trees, and riparian vegetation in monoculture plantations.",
           url = "https://doi.org/10.1650/CONDOR-15-163.1",
           download_date = "2022-01-18",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "vegplots.csv"))

# manage ontology ---
#
matches <- tibble(new = c(unique(data$LandUse)),
                  old = c("oil palm", "Woody plantation", "Temporary cropland",
                          "Naturally Regenerating Forest", "Naturally Regenerating Forest"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)

# harmonise data ----
#
temp <- data %>%
  mutate(
    fid = row_number(),
    x = LocE,
    y = LocN,
    date = dmy(Date),
    datasetID = thisDataset,
    country = "India",
    irrigated = F,
    externalID = NA_character_,
    externalValue = LandUse,
    presence = T,
    area = NA_real_,
    type = "point",
    geometry = NA,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    geometry = NA,
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
