# script arguments ----
#
thisDataset <- "Bücker2010"
description <- "Despite the importance of tropical montane cloud forest streams, studies investigating aquatic communities in these regions are rare and knowledge on the driving factors of community structure is missing. The objectives of this study therefore were to understand how land-use influences habitat structure and macroinvertebrate communities in cloud forest streams of southern Ecuador. We evaluated these relationships in headwater streams with variable land cover, using multivariate statistics to identify relationships between key habitat variables and assemblage structure, and to resolve differences in composition among sites. Results show that shading intensity, substrate type and pH were the environmental parameters most closely related to variation in community composition observed among sites. In addition, macroinvertebrate density and partly diversity was lower in forested sites, possibly because the pH in forested streams lowered to almost 5 during spates. Standard bioindicator metrics were unable to detect the changes in assemblage structure between disturbed and forested streams. In general, our results indicate that tropical montane headwater streams are complex and heterogeneous ecosystems with low invertebrate densities. We also found that some amount of disturbance, i.e. patchy deforestation, can lead at least initially to an increase in macroinvertebrate taxa richness of these streams."
url <- "https://doi.org/10.1594/PANGAEA.777749 https://"
licence <- "CC-BY-3.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "FOR816_macros.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2021-09-14"),
           type = "static",
           licence = licence,
           contact = "see corresponding author",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_tsv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "FOR816_macros.tab"), skip = 74)


# harmonise data ----
#
temp <- data %>%
  separate(`Date/Time`, c("Date","Time"), sep = " ") %>%
  distinct(Latitude, Longitude, `Land use`, .keep_all = TRUE) %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "point",
    country = "Ecuador",
    x = Longitude,
    y = Latitude,
    geometry = NA,
    epsg = 4326,
    area = NA_real_,
    date = ymd(`Date`),
    externalID = `Sample label (the first two digits denote t...)`,
    externalValue = `Land use`,
    irrigated = FALSE,
    presence = TRUE,
    sample_type = "field",
    collector = "expert",
    purpose = "study") %>%
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

# matches <- tibble(new = c(unique(data$`Land use`)),
#                   old = c("Permanent grazing", "Undisturbed Forest", NA, "Naturally Regenerating Forest"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
