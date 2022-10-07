# script arguments ----
#
thisDataset <- "Shooner2018"
thisPath <- paste0(DBDir, thisDataset, "/")
assertDirectoryExists(x = thisPath)
message("\n---- ", thisDataset, " ----")

# reference ----
#
bib <- bibtex_reader(paste0(thisPath, "pericles_215089259.bib"))

regDataset(name = thisDataset,
           description = "Large-scale environmental gradients have been invaluable for unraveling the processes shaping the evolution and maintenance of biodiversity. Environmental gradients provide a natural setting totest theories about species diversity and distributions within a landscape with changing biotic and abioticinteractions. Elevational gradients are particularly useful because they often encompass a large climaticrange within a small geographical extent. Here, we analyzed tree communities in plots located throughoutArunachal Pradesh, a province in northeast India located on the southern face of the Eastern Himalayas,representing one of the largest elevational gradients in the world. Using indices of species and phyloge-netic diversity, we described shifts in community structure across the landscape and explored the putativebiotic and abiotic forces influencing species assembly. As expected, species richness and phylogeneticdiversity decreased with increasing elevation; however, contrary to predictions of environmentalfiltering,species relatedness did not show any clear trend. Nonetheless, patterns of beta diversity (both taxonomicand phylogenetic) strongly suggest lineagefiltering along the elevational gradient. Our results may beexplained iffiltering is driving the assembly of species from distinct evolutionary lineages. New metricsexploring community contributions to regional taxonomic and phylogenetic beta diversity provided addi-tional evidence for the persistence of unique communities at high elevations. We suggest that these pat-terns may be consistent withfiltering on glacial relicts, part of once more diverse clades with convergenttraits suited to climates at the last glacial maximum, resulting in random or over-dispersed communityassemblages at high elevations. We propose that these high-elevation sites with evolutionarily distinct spe-cies represent possible regions for conservation priority that may provide refugia for species threatened bycurrent warming trends.",
           url = "https://esajournals.onlinelibrary.wiley.com/doi/pdf/10.1002/ecs2.2157",
           download_date = "2022-01-13",
           type = "static",
           licence = "CC BY 3.0",
           contact = "stephanie.shooner@mail.mcgill.ca",
           disclosed = "yes",
           bibliography = bib,
           update = TRUE)


# read dataset ----
#
data <- read_csv(paste0(thisPath, "AP_PlotSummary.csv"))

data$ontology <- paste(data$Grazing, data$crop, sep = ",")
data <- data %>% separate_rows(., ontology, sep = ",") %>%
  mutate(ontology = na_if(ontology, "NA"),
         ontology = trimws(ontology))

# manage ontology ---
#
matches <- tibble(new = c(unique(data$ontology)),
                  old = c(NA, "VEGETABLES", "Temporary grazing", NA,
                          "Temporary grazing", "maize", "Naturally Regenerating Forest", "Naturally Regenerating Forest",
                          "rice", "Naturally Regenerating Forest", "Citrus Fruit", "pineapple",
                          "VEGETABLES", "Naturally Regenerating Forest", "orange", "mustard",
                          "tea", "rice"))

getConcept(label_en = matches$old) %>%
  pull(label_en) %>%
  newMapping(concept = .,
             external = matches$new,
             match = "close",
             source = thisDataset,
             certainty = 3)


# harmonise data ----
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
temp <- bind_rows(temp2, temp1)

temp <- temp %>% mutate(
  WorkDoneDate = dmy(WorkDoneDate),
  day = day(WorkDoneDate),
  month = month(WorkDoneDate),
  year = year(WorkDoneDate),
  presence = T,
  area = Area_tr,
  type = "areal",
  geometry = NA,
  irrigated = F,
  country = "India",
  externalID = Plot,
  datasetID = thisDataset,
  externalValue = crop,
  LC1_orig = NA_character_,
  LC2_orig = NA_character_,
  LC3_orig = NA_character_,
  sample_type = "field",
  collector = "expert",
  purpose = "study",
  epsg = 4326,
  fid = row_number()) %>%
  select(datasetID, fid, country, x, y, geometry, epsg, type, year, month, day, irrigated, area, presence, externalID, externalValue, LC1_orig, LC2_orig, LC3_orig, sample_type, collector, purpose, everything())

# write output ----
#
validateFormat(object = temp) %>%
  saveDataset(dataset = thisDataset)

message("\n---- done ----")
