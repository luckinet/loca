# script arguments ----
#
thisDataset <- "Osuri2019"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_2150892510.bib"))

regDataset(name = thisDataset,
           description = "Ecological restoration is a leading strategy for reversing biodiversity losses and enhancing terrestrial carbon sequestration in degraded tropical forests. There have been few comprehensive assessments of recovery following restoration in fragmented forest landscapes, and the efficacy of active versus passive (i.e., natural regeneration) restoration remains unclear. We examined 11 indicators of forest structure, tree diversity and composition (adult and sapling), and aboveground carbon storage in 25 pairs of actively restored (AR; 7–15 yr after weed removal and mixed-native tree species planting) and naturally regenerating (NR) plots within degraded rainforest fragments, and in 17 less-disturbed benchmark (BM) rainforest plots in the Western Ghats, India. We assessed the effects of active restoration on the 11 indicators and tested the hypothesis that the effects of active restoration increase with isolation from contiguous and relatively intact rainforests. Active restoration significantly increased canopy cover, adult tree and sapling density, adult and sapling species density (overall and late-successional), compositional similarity to benchmarks, and aboveground carbon storage, which recovered 14–82% toward BM targets relative to NR baselines. By contrast, tree height–diameter ratios and the proportion of native saplings did not recover consistently in actively restored forests. The effects of active restoration on canopy cover, species density (adult), late-successional species density (adult and sapling), and species composition, but not carbon storage, increased with isolation across the fragmented landscape. Our findings show that active restoration can promote recovery of forest structure, composition, and carbon storage within 7–15 yr of restoration in degraded tropical rainforest fragments, although the benefits of active over passive restoration across fragmented landscapes would depend on indicator type and may increase with site isolation. These findings on early stages of recovery suggest that active restoration in ubiquitous fragmented landscapes of the tropics could complement passive restoration of degraded forests in less fragmented landscapes, and protection of intact forests, as a key strategy for conserving biodiversity and mitigating climate change.",
           url = "https://doi.org/10.1002/ecs2.2860",
           download_date = "2022-01-10",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#
data <- read_csv(paste0(thisPath, "Resto_site_info.csv"))
times <- read_csv(paste0(thisPath, "tree_data.csv"))


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
data <- left_join(data, times, by = "Plot_code")
data$Date <- dmy(data$Date)

temp <- data %>%
  mutate(
    fid = row_number(),
    x = Lat,
    y = Long,
    luckinetID = 1125,
    year = year(Date),
    month = month(Date),
    day = day(Date),
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
