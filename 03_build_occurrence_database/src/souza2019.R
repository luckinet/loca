# script arguments ----
#
thisDataset <- "Souza2019"
thisPath <- paste0(occurrenceDBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

description <- "The responses of forest communities to interacting anthropogenic disturbances like climate change and logging are poorly known. Subtropical forests have been heavily modified by humans and their response to climate change is poorly understood. We investigated the 9-year change observed in a mixed conifer-hardwood Atlantic forest mosaic that included both mature and selectively logged forest patches in subtropical South America. We used demographic monitoring data within 10 1 ha plots that were subjected to distinct management histories (plots logged until 1955, until 1987, and unlogged) to test the hypothesis that climate change affected forest structure and dynamics differentially depending on past disturbances. We determined the functional group of all species based on life-history affinities as well as many functional traits like leaf size, specific leaf area, wood density, total height, stem slenderness, and seed size data for the 66 most abundant species. Analysis of climate data revealed that minimum temperatures and rainfall have been increasing in the last few decades of the 20th century. Floristic composition differed mainly with logging history categories, with only minor change over the nine annual census intervals. Aboveground biomass increased in all plots, but increases were higher in mature unlogged forests, which showed signs of forest growth associated with increased CO2, temperature, and rainfall/treefall gap disturbance at the same time. Logged forests showed arrested succession as indicated by reduced abundances of Pioneers and biomass-accumulators like Large Seeded Pioneers and Araucaria, as well as reduced functional diversity. Management actions aimed at creating regeneration opportunities for long-lived pioneers are needed to restore community functional diversity, and ecosystem services such as increased aboveground biomass accumulation. We conclude that the effects of climate drivers on the dynamics of Brazilian mixed Atlantic forests vary with land-use legacies, and can differ importantly from the ones prevalent in better known tropical forests."
url <- "https://doi.org/10.1002/ece3.5289"
license <- "CC BY 4.0"

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_204577589.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           type = "static",
           contact = "see corresponding author",
           disclosed = "yes",
           licence = licence,
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "data_Souza_handmade_PP.csv"))


# manage ontology ---
#
# newIDs <- add_concept(term = unique(data$land_use_category),
#                       class = "landuse group",
#                       source = thisDataset)
#
# getID(pattern = "Forest land", class = "landuse group") %>%
#   add_relation(from = newIDs$luckinetID, to = .,
#                relation = "is synonym to", certainty = 3)
luckinetID = 1132, ## not sure if this is correct Here: "Five of the
#studied plots had never been logged (hereafter unlogged plots),
#while the other plots experienced uncontrolled selective logging until 1955 or 1987
#(hereafter early-logged and recently logged plots, respectively)" but we only have one coordinate


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = , # "point" or "areal" (such as plot, region, nation, etc)
    x = , # x-value of centroid
    y = , # y-value of centroid
    geometry = NA,
    date = , # must be 'POSIXct' object, see lubridate-package. These can be very easily created for instance with dmy(SURV_DATE), if its in day/month/year format
    country = NA_character_, # the country of each observation/row
    irrigated = , # in case the irrigation status is provided
    area = , # in case the features are from plots and the table gives areas but no spatial object is available
    presence = , # whether the data are 'presence' data (TRUE), or whether they are 'absence' data (i.e., that the data point indicates the value in externalValue is not present) (FALSE)
    externalID = NA_character_, # the external ID of the input data
    externalValue = , # the column of the land use classification
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = , # "field", "visual interpretation", "experience", "meta study" or "modelled"
    collector = , # "expert", "citizen scientist" or "student"
    purpose = , # "monitoring", "validation", "study" or "map development"
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())


# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)
write_rds(x = luckiOnto, file = paste0(dataDir, "tables/luckiOnto.rds"))

message("\n---- done ----")
