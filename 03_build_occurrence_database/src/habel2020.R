# script arguments ----
#
thisDataset <- "Habel2020"
description = "Habitat identity and landscape configuration significantly shape species communities and affect ecosystem functions. The conservation of natural ecosystems is of particular relevance in regions where landscapes have already been largely transformed into farmland and where habitats suffer under resource exploitation. The spill-over of ecosystem functions from natural ecosystems into farmland may positively influence agricultural productivity and human livelihood quality. We measured three proxies of ecosystem functioning: Pollinator diversity (using pan traps), seed dispersal (a seed removal experiment), and predation (using dummy caterpillars). We assessed these ecosystem functions in three forest types of the East African dry coastal forest (Brachystegia forest, Cynometra forest, mixed forest), as well as in adjoining farmland and in plantations of exotic trees (Eucalyptus mainly). We measured ecosystem functions at 20 plots for each habitat type, and along gradients ranging from the forest into farmland. We also recorded various environmental parameters for each study plot. We did not find significant differences of ecosystem functions when combining all proxies assessed, neither among the three natural forest types, nor between natural forest and plantations. However, we found trends for single ecosystem functions. We identified highest pollinator diversity along the forest margin and in farmlands. Vegetation cover and blossom density affected the level of predation positively. Based on our findings we suggest that flowering gardens around housings and woodlots across farmland areas support ecosystem functioning, and thus improve human livelihood quality. We conclude that levels of overall ecosystem functions are affected by entire landscapes, and high landscape heterogeneity, as found in our case, might blur potential negative effects and trends arising from habitat destruction and degradation. "
url <- "https://doi.org/10.5061/dryad.vt4b8gtnx https://"
licence <- "CC0 1.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "pericles_1744742952.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-25"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_xlsx(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "Supplement_REFA.xlsx"), skip = 5)


# pre-process data ----
#
temp <- data[-c(1,2),]


# harmonise data ----
#
temp <- data %>%
  distinct(Latitude, Longitude, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type =  "point",
    country = "Kenya",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = NA,
    # year = "03-2018_04-2018",
    externalID = as.character(Nr.),
    externalValue = Habitat,
    # attr_1 = NA_character_,
    # attr_1_typ = NA_character_,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  separate_rows(year, sep = "_") %>%
  mutate(
    fid = row_number(),
    date = dmy(paste0("01-", year))) %>%
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

# matches <- tibble(new = c(unique(data$Habitat)),
#                   old = c(NA, "Naturally regenerating forest",
#                           "Naturally regenerating forest",
#                           "Naturally regenerating forest",
#                           "Woody plantation", NA))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
