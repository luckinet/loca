# script arguments ----
#
thisDataset <- "Chaudhary2016"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- ris_reader(paste0(thisPath, "10.1038_srep23954-citation.ris"))

regDataset(name = thisDataset,
           description = "Forests managed for timber have an important role to play in conserving global biodiversity. We evaluated the most common timber production systems worldwide in terms of their impact on local species richness by conducting a categorical meta-analysis. We reviewed 287 published studies containing 1008 comparisons of species richness in managed and unmanaged forests and derived management, taxon and continent specific effect sizes. We show that in terms of local species richness loss, forest management types can be ranked, from best to worse, as follows: selection and retention systems, reduced impact logging, conventional selective logging, clear-cutting, agroforestry, timber plantations, fuelwood plantations. Next, we calculated the economic profitability in terms of the net present value of timber harvesting from 10 hypothetical wood-producing Forest Management Units (FMU) from around the globe. The ranking of management types is altered when the species loss per unit profit generated from the FMU is considered. This is due to differences in yield, timber species prices, rotation cycle length and production costs. We thus conclude that it would be erroneous to dismiss or prioritize timber production regimes, based solely on their ranking of alpha diversity impacts.",
           url = "https://www.nature.com/articles/srep23954",
           download_date = "2021-09-14",
           type = "static",
           licence = "CC BY 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

https://git.idiv.de/mas/projects/luckinet/02_data_processing/01_build_point_database/-/issues/18

# read dataset ----
#
data <- read_xls(paste0(thisPath, "srep23954-s1.xls"), sheet = 2)


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)


luckinetID = case_when(`Management type` == "clear-cut" ~ 1125,
                       `Management type` == "retention" ~ 1125,
                       `Management type` == "selective logging" ~ 1125,
                       `Management type` == "Selection system" ~ 1125,
                       `Management type` == "Reduced impact logging" ~ 1125,
                       `Management type` == "plantation" ~ 1138,
                       `Management type` == "plantation fuel" ~ 1138,
                       `Management type` == "plantation non-timber" ~ 1138,
                       `Management type` == "slash-and-burn" ~ 1117,
                       `Management type` == "agroforestry" ~ 1118),

# harmonise data ----
#
temp <- data %>%
  select(1:15) %>%
  rename(x = longitude,
         y = latitude) %>%
  mutate(externalID = row_number()) %>%
  distinct(x, y, `Management type`, .keep_all = TRUE) %>%
  mutate(fid = seq_along(Study_ID),
         country = Country,
         year = NA_real_,
         month = NA_real_,
         day = NA_real_,
         irrigated = NA_real_,
         datasetID = thisDataset,
         externalValue = `Management type`,
         LC1_orig = NA_character_,
         LC2_orig = NA_character_,
         LC3_orig = NA_character_,
         sample_type = "meta study",
         collector = "expert",
         purpose = "monitoring",
         epsg = 4326) %>%
  select(datasetID, fid, country, x, y, epsg, year, month, day, irrigated,
         externalID, externalValue, LC1_orig, LC2_orig, LC3_orig,
         sample_type, collector, purpose, everything())

assertNames(x = names(temp),
            must.include = c("datasetID", "fid", "country", "x", "y", "epsg",
                             "year", "month", "day", "irrigated",
                             "externalID", "externalValue", "LC1_orig", "LC2_orig", "LC3_orig",
                             "sample_type", "collector", "purpose"))


# write output ----
saveDataset(object = temp, dataset = thisDataset)
