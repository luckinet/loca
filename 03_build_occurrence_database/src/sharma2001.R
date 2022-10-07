# script arguments ----
#
thisDataset <- "Sharma2001"
thisPath <- paste0(DBDir, thisDataset, "/")


# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "S0378377401000890.bib")) # choose between ris_reader() or bibtex_reader()

regDataset(name = thisDataset,
           description = "Study was undertaken to assess the water use, moisture extraction and water use efficiency (WUE) of irrigated wheat, when grown in association with boundary plantation of poplar, at different distances (0–3, 3–6, 6–9, 9–12, 12–15 and >15 m (control)) from poplar (Populus deltoides M.) tree line. Presence of 3-year old poplar plantation at the boundary of wheat field caused 7.5% higher water use than control (plots having no effect of tree line) up to 3 m distance from tree line which further intensified up to 12.7% and extended up to 6 m distance with 4-year old plantation. Similarly, maximum moisture extraction, both laterally and vertically, observed near the tree line. Contrary to this, WUE of wheat was reduced by 4.6% between 0 and 3 m distance from tree line with 3-year old plantation, decline intensified further to 18.6% with 4-year old plantation. However, wheat was benefited by boundary plantation of trees between 3 and 9 m distance from the base of the tree line which resulted in increased WUE of the wheat crop up to 9%.",
           url = "https://doi.org/10.1016/S0378-3774(01)00089-0", # ideally the doi, but if it doesn't have one, the main source of the database
           download_date = "2022-01-13", # YYYY-MM-DD
           type = "static", # dynamic or static
           licence = NA_character_, # optional
           contact = "nks@mailcity.com", # optional, if it's a paper that should be "see corresponding author"
           disclosed = "yes", # whether the data are freely available "yes"/"no"
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_delim(paste0(thisPath, "Sharma2001.csv"), delim = ";", trim_ws = T)


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
chd = substr(data$lat, 3, 3)[1]
chm = substr(data$lat, 5, 5)[1]

temp <- data %>% mutate(
        y = as.numeric(char2dms(paste0(data$lat,'N'), chd = chd, chm = chm)),
        x = as.numeric(char2dms(paste0(data$long,'E'), chd = chd, chm = chm)))

temp <- temp %>%
  mutate(
    month = NA_real_,
    day = NA_real_,
    irrigated = NA_real_,
    country = "India",
    externalID = ID,
    externalLC = NA_character_,
    sample_type = "expert, field",
    datasetID = thisDataset,
    luckinetID = 282,
    externalValue = commo,
    fid = seq_along(externalID)) %>%
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
