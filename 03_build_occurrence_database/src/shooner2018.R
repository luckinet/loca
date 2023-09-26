# script arguments ----
#
thisDataset <- "Shooner2018"
description <- "Large-scale environmental gradients have been invaluable for unraveling the processes shaping the evolution and maintenance of biodiversity. Environmental gradients provide a natural setting totest theories about species diversity and distributions within a landscape with changing biotic and abioticinteractions. Elevational gradients are particularly useful because they often encompass a large climaticrange within a small geographical extent. Here, we analyzed tree communities in plots located throughoutArunachal Pradesh, a province in northeast India located on the southern face of the Eastern Himalayas,representing one of the largest elevational gradients in the world. Using indices of species and phyloge-netic diversity, we described shifts in community structure across the landscape and explored the putativebiotic and abiotic forces influencing species assembly. As expected, species richness and phylogeneticdiversity decreased with increasing elevation; however, contrary to predictions of environmentalfiltering,species relatedness did not show any clear trend. Nonetheless, patterns of beta diversity (both taxonomicand phylogenetic) strongly suggest lineagefiltering along the elevational gradient. Our results may beexplained iffiltering is driving the assembly of species from distinct evolutionary lineages. New metricsexploring community contributions to regional taxonomic and phylogenetic beta diversity provided addi-tional evidence for the persistence of unique communities at high elevations. We suggest that these pat-terns may be consistent withfiltering on glacial relicts, part of once more diverse clades with convergenttraits suited to climates at the last glacial maximum, resulting in random or over-dispersed communityassemblages at high elevations. We propose that these high-elevation sites with evolutionarily distinct spe-cies represent possible regions for conservation priority that may provide refugia for species threatened bycurrent warming trends."
url <- "https://doi.org/10.1002/ecs2.2157 https://"
licence <- "CC BY 3.0"


# reference ----
#
bib <- bibtex_reader(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "pericles_215089259.bib"))

regDataset(name = thisDataset,
           description = description,
           url = url,
           download_date = ymd("2022-01-13"),
           type = "static",
           licence = licence,
           contact = "stephanie.shooner@mail.mcgill.ca",
           disclosed = TRUE,
           bibliography = bib,
           path = occurrenceDBDir)


# read dataset ----
#
data <- read_csv(paste0(occurrenceDBDir, "00_incoming/", thisDataset, "/", "AP_PlotSummary.csv"))


# pre-process data ----
#
chd = substr(data$BeginLatitude, 3, 3)[1]
chm = substr(data$BeginLatitude, 6, 6)[1]
chs = substr(data$BeginLatitude, 12, 12)[1]

# convert coordinates
temp <- data %>%
  mutate(lat1 = as.numeric(char2dms(paste0(data$BeginLatitude, 'N'), chd = chd, chm = chm, chs = chs)),
         long1 = as.numeric(char2dms(paste0(data$BeginLongitude, 'E'), chd = chd, chm = chm, chs = chs)),
         lat2 = as.numeric(char2dms(paste0(data$EndLatitude, 'N'), chd = chd, chm = chm, chs = chs)),
         long2 = as.numeric(char2dms(paste0(data$EndLongitude, 'E'), chd = chd, chm = chm, chs = chs)))

temp1 <- subset(temp, select = -c(lat2, long2)) %>% rename(x = long1, y = lat1)
temp2 <- subset(temp, select = -c(lat1, long1)) %>% rename(x = long2, y = lat2)

data <- bind_rows(temp2, temp1)


# harmonise data ----
#
temp <- data %>%
  mutate(
    datasetID = thisDataset,
    fid = row_number(),
    type = "areal",
    country = "India",
    x = NA_real_,
    y = NA_real_,
    geometry = NA,
    epsg = 4326,
    area = Area_tr,
    date = NA,
    # day = day(WorkDoneDate),
    # month = month(WorkDoneDate),
    # year = year(WorkDoneDate),
    externalID = Plot,
    externalValue = crop,
    attr_1 = Grazing,
    attr_1_typ = "?",
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

# matches <- tibble(new = c(unique(data$ontology)),
#                   old = c(NA, "VEGETABLES", "Temporary grazing", NA,
#                           "Temporary grazing", "maize", "Naturally Regenerating Forest", "Naturally Regenerating Forest",
#                           "rice", "Naturally Regenerating Forest", "Citrus Fruit", "pineapple",
#                           "VEGETABLES", "Naturally Regenerating Forest", "orange", "mustard",
#                           "tea", "rice"))

out <- matchOntology(table = temp,
                     columns = externalValue,
                     dataseries = thisDataset,
                     ontology = ontoDir)


# write output ----
#
validateFormat(object = out) %>%
  saveDataset(path = paste0(occurrenceDBDir, "02_processed/"), name = thisDataset)

message("\n---- done ----")
