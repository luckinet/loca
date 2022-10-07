# script arguments ----
#
thisDataset <- "Raymundo2018"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "citation-325955139.bib"))

regDataset(name = thisDataset,
           description = "Recent insights show that tropical forests are shifting in species composition, possibly due to changing environmental conditions. However, we still poorly understand the forest response to different environmental change drivers, which limits our ability to predict the future of tropical forests. Although some studies have evaluated drought effects on tree communities, we know little about the influence of increased water availability. Here, we evaluated how an increase in water availability caused by an artificial reservoir affected temporal changes in forest structure, species and functional diversity, and community-weighted mean traits. Furthermore, we evaluated how demographical groups (recruits, survivors and trees that died) contributed to these temporal changes in tropical dry forests. We present data for the dynamics of forest change over a 10-year period for 120 permanent plots that were far from the water’s edge before reservoir construction and are now close to the water’s edge (0–60 m). Plots close to the water’s edge had an abrupt increase in water availability, while distant plots did not. Plots close to the water’s edge showed an increase in species and functional diversity, and in the abundance of species with traits associated with low drought resistance (i.e., evergreen species with simple leaves and low wood density), whereas plots far from the water’s edge did not change. Changes in overall community metrics were mainly due to recruits rather than to survivors or dead trees. Overall stand basal area did not change because growth and recruitment were balanced by mortality. Synthesis. Our results showed that tropical dry forests can respond quickly to abrupt changes in environmental conditions. Temporal changes in vegetation metrics due to increased water availability were mainly attributed to recruits, suggesting that these effects are lasting and may become stronger over time. The lack of increase in basal area towards the water’s edge, and the shift towards higher abundance of soft-wooded species, could reduce the carbon stored and increase the forest’s vulnerability to extreme weather events. Further “accidental” large-scale field experiments like ours could provide more insights into forest responses and resilience to global change.",
           url = "https://doi.org/10.1111/1365-2745.13031",
           download_date = "2022-01-07",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "Data from Raymundo et al. (2018).xlsx"), sheet = 3)


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
    x = X,
    y = Y,
    type = "point",
    area = NA_real_,
    geometry = NA,
    presence = F,
    luckinetID = 1132,
    year = paste("2005_", "2006_", "2007_", "2008_", "2009_", "2010_", "2011_", "2012_", "2013_", "2014_", "2015"),
    month = NA_real_,
    day = NA_integer_,
    datasetID = thisDataset,
    country = "Brazil",
    irrigated = F,
    externalID = NA_character_,
    externalValue = "Naturally Regenerating Forest",
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    epsg = 4326) %>%
  separate_rows(year, sep = "_") %>%
  mutate(year = as.numeric(year),
         fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
