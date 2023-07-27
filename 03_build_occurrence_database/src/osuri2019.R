# script arguments ----
#
thisDataset <- "Osuri2019"
description <- "Ecological restoration is a leading strategy for reversing biodiversity losses and enhancing terrestrial carbon sequestration in degraded tropical forests. There have been few comprehensive assessments of recovery following restoration in fragmented forest landscapes, and the efficacy of active versus passive (i.e., natural regeneration) restoration remains unclear. We examined 11 indicators of forest structure, tree diversity and composition (adult and sapling), and aboveground carbon storage in 25 pairs of actively restored (AR; 7–15 yr after weed removal and mixed-native tree species planting) and naturally regenerating (NR) plots within degraded rainforest fragments, and in 17 less-disturbed benchmark (BM) rainforest plots in the Western Ghats, India. We assessed the effects of active restoration on the 11 indicators and tested the hypothesis that the effects of active restoration increase with isolation from contiguous and relatively intact rainforests. Active restoration significantly increased canopy cover, adult tree and sapling density, adult and sapling species density (overall and late-successional), compositional similarity to benchmarks, and aboveground carbon storage, which recovered 14–82% toward BM targets relative to NR baselines. By contrast, tree height–diameter ratios and the proportion of native saplings did not recover consistently in actively restored forests. The effects of active restoration on canopy cover, species density (adult), late-successional species density (adult and sapling), and species composition, but not carbon storage, increased with isolation across the fragmented landscape. Our findings show that active restoration can promote recovery of forest structure, composition, and carbon storage within 7–15 yr of restoration in degraded tropical rainforest fragments, although the benefits of active over passive restoration across fragmented landscapes would depend on indicator type and may increase with site isolation. These findings on early stages of recovery suggest that active restoration in ubiquitous fragmented landscapes of the tropics could complement passive restoration of degraded forests in less fragmented landscapes, and protection of intact forests, as a key strategy for conserving biodiversity and mitigating climate change."
url <- "https://doi.org/10.1002/ecs2.2860"
license <- "CC0 1.0"


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_2150892510.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-10"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "Resto_site_info.csv"))
times <- read_csv(paste0(thisPath, "tree_data.csv"))


# harmonise data ----
#
temp <- left_join(data, times, by = "Plot_code") %>%
  distinct(Long, Lat, Year_restored, .keep_all = T) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "India",
    x = Lat,
    y = Long,
    geometry = NA,
    epsg = 4326,
    area = Area,
    date = dmy(Date),
    externalID = NA_character_,
    externalValue = "Naturally Regenerating Forest",
    irrigated = FALSE,
    presence = FALSE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
  drop_na(x, y, date) %>%
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

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
