# script arguments ----
#
thisDataset <- "Bauters2015"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_1744742951.bib"))

regDataset(name = thisDataset,
           description = "On the African continent, the population is expected to expand fourfold in the next century, which will increasingly impact the global carbon cycle and biodiversity conservation. Therefore, it is of vital importance to understand how carbon stocks and community assembly recover after slash-and-burn events in tropical second growth forests. We inventoried a chronosequence of 15 1-ha plots in lowland tropical forest of the central Congo Basin and evaluated changes in aboveground and soil organic carbon stocks and in tree species diversity, functional composition, and community-weighted functional traits with succession. We aimed to track long-term recovery trajectories of species and carbon stocks in secondary forests, comparing 5 to 200+ year old secondary forest with reference primary forest. Along the successional gradient, the functional composition followed a trajectory from resource acquisition to resource conservation, except for nitrogen-related leaf traits. Despite a fast, initial recovery of species diversity and functional composition, there were still important structural and carbon stock differences between old growth secondary and pristine forest, which suggests that a full recovery of secondary forests might take much longer than currently shown. As such, the aboveground carbon stocks of 200+year old forest were only 57% of those in the pristine reference forest, which suggests a slow recovery of aboveground carbon stocks, although more research is needed to confirm this observation. The results of this study highlight the need for more in-depth studies on forest recovery in Central Africa, to gain insight into the processes that control biodiversity and carbon stock recovery.",
           url = "https://doi.org/10.1111/btp.12647",
           download_date = "2022-01-14",
           type = "static",
           licence = "CC0 1.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_xlsx(paste0(thisPath, "location_handmade_PP.xlsx"))


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)
luckinetID = case_when(`Forest Type` == "Old Secondary" | `Forest Type` == "Young Secondary" | `Forest Type` == "Young Forest" ~ 1132,
                       `Forest Type` == "Old-Mix" | `Forest Type` == "Old-Gil" ~ 1136),


# harmonise data ----
# .
temp <- data %>%
  mutate(
    fid = row_number(),
    x = Longitude,
    y = Latitude,
    year = NA_real_,
    month = NA_real_,
    day = NA_real_,
    datasetID = thisDataset,
    country = "Democratic Republic of the Congo (DRC)",
    irrigated = FALSE,
    externalID = Plot,
    externalValue = `Forest Type`,
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
