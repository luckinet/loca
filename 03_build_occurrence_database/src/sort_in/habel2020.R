# script arguments ----
#
thisDataset <- "Habel2020"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1744742952.bib"))

regDataset(name = thisDataset,
           description = "Habitat identity and landscape configuration significantly shape species communities and affect ecosystem functions. The conservation of natural ecosystems is of particular relevance in regions where landscapes have already been largely transformed into farmland and where habitats suffer under resource exploitation. The spill-over of ecosystem functions from natural ecosystems into farmland may positively influence agricultural productivity and human livelihood quality. We measured three proxies of ecosystem functioning: Pollinator diversity (using pan traps), seed dispersal (a seed removal experiment), and predation (using dummy caterpillars). We assessed these ecosystem functions in three forest types of the East African dry coastal forest (Brachystegia forest, Cynometra forest, mixed forest), as well as in adjoining farmland and in plantations of exotic trees (Eucalyptus mainly). We measured ecosystem functions at 20 plots for each habitat type, and along gradients ranging from the forest into farmland. We also recorded various environmental parameters for each study plot. We did not find significant differences of ecosystem functions when combining all proxies assessed, neither among the three natural forest types, nor between natural forest and plantations. However, we found trends for single ecosystem functions. We identified highest pollinator diversity along the forest margin and in farmlands. Vegetation cover and blossom density affected the level of predation positively. Based on our findings we suggest that flowering gardens around housings and woodlots across farmland areas support ecosystem functioning, and thus improve human livelihood quality. We conclude that levels of overall ecosystem functions are affected by entire landscapes, and high landscape heterogeneity, as found in our case, might blur potential negative effects and trends arising from habitat destruction and degradation. ",
           url = "https://doi.org/10.5061/dryad.vt4b8gtnx",
           download_date = "2022-01-25",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Supplement_REFA.xlsx"), skip = 5)

# manage ontology ---
#
matches <- tibble(new = c(unique(data$Habitat)),
                  old = c(NA, "Naturally regenerating forest",
                          "Naturally regenerating forest",
                          "Naturally regenerating forest",
                          "Woody plantation", NA))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)



temp <- data[-c(1,2),]

temp <- temp %>%
  distinct(Latitude, Longitude, .keep_all = TRUE) %>%
  mutate(
    x = Longitude,
    y = Latitude,
    year = "03-2018_04-2018",
    datasetID = thisDataset,
    country = "Kenya",
    irrigated = F,
    externalID = as.character(Nr.),
    externalValue = Habitat,
    presence = T,
    area = NA_real_,
    type =  "point",
    geometry = NA,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  mutate(
    fid = row_number(),
    date = dmy(paste0("01-", year))) %>%
select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")

