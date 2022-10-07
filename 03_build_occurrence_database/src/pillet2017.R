# script arguments ----
#
thisDataset <- "Pillet2017"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_13652745106.bib")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "Tropical forest mortality is controlled by both biotic and abiotic processes, but how these processes interact to determine forest structure is not well understood. Using long-term demography data from permanent forest plots at the Paracou Tropical Forest Research Station in French Guiana, we analysed the relative influence of competition and climate on tree mortality. We found that self-thinning is evident at the stand level, and is associated with clumped mortality at smaller scales (<2 m) and regular spacing of living trees at intermediate (2.5–7.5 m) scales. A competition index (CI) based on spatial clustering of dead trees was used to build predictive mortality models, which also accounted for climate interactions. The model that most closely fitted observations included both the CI and climatic variables, with climate-only and competition-only models less informative than the full model. There was strong evidence for U-shaped size-specific mortality, with highest mortality for small and very large trees, as well as sensitivity of trees to drought, especially when temperatures were high, and when soils were water saturated. The effect of the CI was more complex than expected a priori: a higher CI was associated with lower mortality odds, which we hypothesize is caused by gap-phase dynamics, but there was also evidence for competition-induced mortality at very high CI values. The strong signature of competition as a control over mortality at the stand and individual scales confirms its important role in determining tropical forest structure. The complexity of the competition-mortality relationship and its interaction with climate indicates that a thorough consideration of the scale of analysis is needed when inferring the role of competition in tropical forests, but demonstrates that climate-only mortality models can be significantly improved by including competition effects, even when ignoring species-specific effects. Synthesis. Empirical models such as the one developed here can help constrain and improve process-based vegetation models, serving both as a benchmark and as a means to disentangle mortality processes. Tropical vegetation dynamic models would benefit greatly from explicitly considering the role of competition in stand development and self-thinning while modelling demography, as well as its interaction with climate.",
           url = "https://doi.org/10.1111/1365-2745.12876",
           download_date = "2022-01-09",
           type = "static",
           licence = NA_character_,
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "spatialanalysis.csv"))


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
    x = X,
    y = Y,
    luckinetID = 1125,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    country = NA_character_,
    irrigated = NA_character_,
    presence = TRUE,
    externalID = NA_character_,
    externalValue = NA_character_,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "monitoring",
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, year, month, day, irrigated, presence,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())

# before preparing data for storage, test that all required variables are available
assertNames(x = names(temp),
            must.include = c("datasetID", "fid", "country", "x", "y", "epsg",
                             "year", "month", "day", "irrigated", "presence",
                             "externalID", "externalValue", "LC1_orig", "LC2_orig", "LC3_orig",
                             "sample_type", "collector", "purpose"))


# write output ----
#
saveDataset(object = temp, dataset = thisDataset)
message("\n---- done ----")

