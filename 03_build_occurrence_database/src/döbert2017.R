# script arguments ----
#
thisDataset <- "Döbert2017"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_13652745105.bib"))

regDataset(name = thisDataset,
           description = "Summary Logging is a major driver of tropical forest degradation, with severe impacts on plant richness and composition. Rarely have these effects been considered in terms of their impact on the functional and phylogenetic diversity of understorey plant communities, despite the direct relevance to community reassembly trajectories. Here, we test the effects of logging on functional traits and evolutionary relatedness, over and above effects that can be explained by changes in species richness alone. We hypothesised that strong environmental filtering will result in more clustered (under-dispersed) functional and phylogenetic structures within communities as logging intensity increases. We surveyed understorey plant communities at 180 locations across a logging intensity gradient from primary to repeatedly logged tropical lowland rain forest in Sabah, Malaysia. For the 691 recorded plant taxa, we generated a phylogeny to assess plot-level phylogenetic relatedness. We quantified 10 plant traits known to respond to disturbance and affect ecosystem functioning, and tested the influence of logging on functional and phylogenetic structure. We found no significant effect of forest canopy loss or road configuration on species richness. By contrast, both functional dispersion and phylogenetic dispersion (net relatedness index) showed strong gradients from clustered towards more randomly assembled communities at higher logging intensity, independent of variation in species richness. Moreover, there was a significant nonlinear shift in the trait dispersion relationship above a logging intensity threshold of c. 65\% canopy loss (±17\% CL). All functional traits showed significant phylogenetic signals, suggesting broad concordance between functional and phylogenetic dispersion, at least below the logging intensity threshold. Synthesis. We found a strong logging signal in the functional and phylogenetic structure of understorey plant communities, over and above species richness, but this effect was opposite to that predicted. Logging increased, rather than decreased, functional and phylogenetic dispersion in understorey plant communities. This effect was particularly pronounced for functional response traits, which directly link disturbance with plant community reassembly. Our study provides novel insights into the way logging affects understorey plant communities in tropical rain forest and highlights the importance of trait-based approaches to improve our understanding of the broad range of logging-associated impacts.",
           url = "https://doi.org/10.1111/1365-2745.12794",
           download_date = "2022-01-21",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "PlotData.csv"))


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)
externalValue = case_when(block == "og" ~ "old-growth forest",
                          block != "og" ~ "secondary forest"),


# harmonise data ----
#
a <- data %>%
  st_as_sf(coords = c("east", "north"), crs = "+proj=utm +zone=49N") %>% st_transform(4326) %>%
  st_coordinates() %>%
  as_tibble()
temp <- cbind(a,data)

temp <- temp %>%
  mutate(
    fid = row_number(),
    x = X,
    y = Y,
    year = NA_real_,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    country = "Malaysia",
    irrigated = FALSE,
    externalID = plot.code,
    externalValue = ,
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
