# script arguments ----
#
thisDataset <- "Drakos2020"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "bibtex-7112.bib"))

regDataset(name = thisDataset,
           description = "The agINFRA project (www.aginfra.eu) was a European Commission funded project under the 7th Framework Programme that aimed to introduce agricultural scientific communities to the vision of open and participatory data-intensive science. agINFRA has now evolved into the European hub for data-powered research on agriculture, food and the environment, serving the research community through multiple roles. Working on enhancing the interoperability between heterogeneous data sources, the agINFRA project has left a set of grid- and cloud- based services that can be reused by future initiatives and adopted by existing ones, in order to facilitate the dissemination of agricultural research, educational and other types of data. On top of that, agINFRA provided a set of domain-specific recommendations for the publication of agri-food research outcomes. This paper discusses the concept of the agINFRA project and presents its major outcomes, as adopted by existing initiatives activated in the context of agricultural research and education.",
           url = "10.12688/f1000research.6349.2",
           download_date = "",
           type = "static",
           licence = "CC BY 4.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#
data <- read_csv(paste0(thisPath, "data_points.csv"))


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
    x = ,
    y = ,
    year = ,
    month = ,
    day = ,
    datasetID = thisDataset,
    country = NA_character_,
    irrigated = NA_character_,
    externalID = NA_character_,
    externalValue = ,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "", # "field", "visual interpretation" or "experience"
    collector = "", # "expert", "citizen scientist" or "student"
    purpose = "", # "monitoring", "validation", "study" or "map development"
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
