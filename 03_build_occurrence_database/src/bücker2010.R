# script arguments ----
#
thisDataset <- "Bücker2010"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "FOR816_macros.bib"))

regDataset(name = thisDataset,
           description = "Despite the importance of tropical montane cloud forest streams, studies investigating aquatic communities in these regions are rare and knowledge on the driving factors of community structure is missing. The objectives of this study therefore were to understand how land-use influences habitat structure and macroinvertebrate communities in cloud forest streams of southern Ecuador. We evaluated these relationships in headwater streams with variable land cover, using multivariate statistics to identify relationships between key habitat variables and assemblage structure, and to resolve differences in composition among sites. Results show that shading intensity, substrate type and pH were the environmental parameters most closely related to variation in community composition observed among sites. In addition, macroinvertebrate density and partly diversity was lower in forested sites, possibly because the pH in forested streams lowered to almost 5 during spates. Standard bioindicator metrics were unable to detect the changes in assemblage structure between disturbed and forested streams. In general, our results indicate that tropical montane headwater streams are complex and heterogeneous ecosystems with low invertebrate densities. We also found that some amount of disturbance, i.e. patchy deforestation, can lead at least initially to an increase in macroinvertebrate taxa richness of these streams.",
           url = "https://doi.org/10.1594/PANGAEA.777749",
           download_date = "2021-09-14",
           type = "static",
           licence = "CC-BY-3.0",
           contact = "see corresponding author",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)

# read dataset ----
#
data <- read_tsv(paste0(thisPath, "FOR816_macros.tab"), skip = 74)

# manage ontology ---
#
matches <- tibble(new = c(unique(data$`Land use`)),
                  old = c("Permanent grazing", "Undisturbed Forest", NA, "Naturally Regenerating Forest"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)

# harmonise data ----
#
temp <- data %>%
  separate(`Date/Time`, c("Date","Time"), sep = " ") %>%
  distinct(Latitude, Longitude, `Land use`, .keep_all = TRUE) %>%
  mutate(
    date = ymd(`Date`),
    fid = row_number(),
    x = Longitude,
    y = Latitude,
    datasetID = thisDataset,
    country = "Ecuador",
    irrigated = FALSE,
    externalID = `Sample label (the first two digits denote t...)`,
    externalValue = `Land use`,
    LC1_orig = NA_character_,
    LC2_orig = NA_character_,
    LC3_orig = NA_character_,
    sample_type = "field",
    collector = "expert",
    purpose = "study",
    geometry = NA,
    area = NA_real_,
    type = "point",
    presence = TRUE,
    epsg = 4326) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, date, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())

# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
